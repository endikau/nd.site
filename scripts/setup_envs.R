# ---- Platform helpers -------------------------------------------------------

detect_ubuntu_codename <- function(os_release_path = "/etc/os-release") {
  if (!file.exists(os_release_path)) return(NA_character_)

  os_release <- readLines(os_release_path, warn = FALSE)
  codename <- sub("^VERSION_CODENAME=", "", os_release[grepl("^VERSION_CODENAME=", os_release)])

  if (length(codename) == 1 && nzchar(codename)) codename else NA_character_
}

detect_linux_arch <- function() {
  # Priority order:
  # 1) dpkg (best on Debian/Ubuntu containers; respects target arch under buildx/QEMU)
  # 2) uname -m
  # 3) R fallbacks
  arch <- tryCatch(
    system("dpkg --print-architecture", intern = TRUE),
    error = function(e) character()
  )
  if (!length(arch) || !nzchar(arch[1])) {
    arch <- tryCatch(
      system("uname -m", intern = TRUE),
      error = function(e) character()
    )
  }
  arch <- if (length(arch)) trimws(tolower(arch[1])) else ""

  if (arch == "" || is.na(arch)) {
    # R fallbacks (least preferred)
    arch <- trimws(tolower(.Platform$r_arch %||% R.version$arch %||% ""))
  }

  if (arch %in% c("amd64", "x86_64")) return("x86_64")
  if (arch %in% c("arm64", "aarch64")) return("aarch64")

  stop("Unsupported or unknown architecture: ", arch)
}

`%||%` <- function(x, y) if (is.null(x) || length(x) == 0 || identical(x, "")) y else x

detect_r_minor <- function() {
  paste0(R.version$major, ".", strsplit(R.version$minor, "\\.")[[1]][1])
}

ppm_binary_repo <- function(codename = "noble") {
  arch <- detect_linux_arch()
  rver <- detect_r_minor()

  sprintf(
    "https://packagemanager.posit.co/cran/latest/bin/linux/%s-%s/%s",
    codename, arch, rver
  )
}

# ---- Main installer options -------------------------------------------------

set_install_opts <- function(
  target_codename = "noble",
  verbose = TRUE
) {
  codename <- detect_ubuntu_codename()

  if (!identical(codename, target_codename)) {
    if (verbose) message("set_install_opts(): codename=", codename, " (no changes)")
    return(invisible(FALSE))
  }

  # Base R should use the Linux-binary repo directly
  cran_bin <- ppm_binary_repo(codename = target_codename)

  # renv should use the source-style PPM URL; it will transform internally to the right binaries
  ppm_src <- "https://packagemanager.posit.co/cran/latest"

  options(
    repos = c(CRAN = cran_bin),

    # renv PPM integration (preferred)
    renv.config.ppm.enabled = TRUE,
    renv.config.ppm.url = ppm_src,

    # Ensure renv restore/install uses PPM as the upstream source (and can still transform)
    renv.config.repos.override = c(CRAN = ppm_src),

    # Docker-build stability: avoid pak's background subprocess integration
    renv.config.pak.enabled = FALSE
  )

  if (verbose) {
    message("set_install_opts():")
    message("  Ubuntu codename: ", codename)
    message("  Arch:           ", detect_linux_arch())
    message("  R:              ", detect_r_minor())
    message("  CRAN (binary):  ", cran_bin)
    message("  PPM (source):   ", ppm_src)
  }

  invisible(TRUE)
}

# ---- Script entry -----------------------------------------------------------

set_install_opts()

# Prefer install.packages() during docker build (stable, uses binaries via repos)
install.packages(
  c("callr", "cli", "renv", "reticulate", "rlang"),
  Ncpus = parallel::detectCores()
)

run_in_callr <- function(.expr) {
  expr_quo <- rlang::enquo(.expr)
  calling_env <- rlang::caller_env()

  callr::r(
    function(expr_quo, env_list) {
      e <- list2env(env_list, parent = baseenv())
      rlang::eval_tidy(expr_quo, data = e)
    },
    args = list(
      expr_quo = expr_quo,
      env_list = as.list(calling_env, all.names = TRUE)
    )
  )
}

run_in_callr({
  set_install_opts()

  .python_pyenv_path <- reticulate::install_python(
    "3.12:latest",
    force = FALSE
  )
  if (reticulate::virtualenv_exists("./venv")) {
    reticulate::virtualenv_remove(envname = "./venv")
  }
  reticulate::virtualenv_create(
    envname = "./venv",
    python = .python_pyenv_path
  )
})

run_in_callr({
  set_install_opts()
  renv::activate()
})

run_in_callr({
  set_install_opts()
  renv::restore(clean = TRUE)
})

run_in_callr({
  set_install_opts()
  renv::install(
    packages = setdiff(
      c("yaml", "reticulate", "m-pilarski/helprrr", "reticulate"),
      rownames(installed.packages())
    ),
    prompt = FALSE
  )
})

cli::cli_alert_success("renv")

run_in_callr({
  set_install_opts()

  .python_venv_path <- reticulate::virtualenv_python("./venv")
  renv::use_python(.python_venv_path, type = "virtualenv")
  helprrr::setenv_persist(
    RETICULATE_PYTHON = .python_venv_path,
    RENV_PYTHON = .python_venv_path
  )
})

cli::cli_alert_success("venv")

run_in_callr({
  set_install_opts()
  renv::snapshot(prompt = FALSE)
})

cli::cli_alert_success("snapshot")


# set_install_opts <- function() {
#   # robust check for Ubuntu 24.04 codename
#   os_release <- readLines("/etc/os-release", warn = FALSE)
#   codename <- sub("^VERSION_CODENAME=", "", os_release[grepl("^VERSION_CODENAME=", os_release)])
#   if (length(codename) == 1 && codename == "noble") {

#     # Use the *source* P3M endpoint; renv/PPM integration will map to Linux binaries.
#     ppm_src <- "https://packagemanager.posit.co/cran/latest"

#     options(
#       repos = c(CRAN = ppm_src),

#       # renv: prefer PPM/P3M integration (rspm.* is deprecated)
#       renv.config.ppm.enabled = TRUE,
#       renv.config.ppm.default = TRUE,
#       renv.config.ppm.url = ppm_src,

#       # only if you really want to force this repo during restore()
#       renv.config.repos.override = paste0("CRAN=", ppm_src),

#       # pak integration (optional)
#       renv.config.pak.enabled = TRUE
#     )
#   }
# }


# set_install_opts()

# install.packages(c("pak", "callr"))

# pak::pak(pkg = c("cli", "renv", "reticulate", "rlang"))

# run_in_callr <- function(.expr) {
#   expr_quo <- rlang::enquo(.expr)
#   calling_env <- rlang::caller_env()

#   callr::r(
#     function(expr_quo, env_list) {
#       # Reconstruct an environment from a named list
#       e <- list2env(env_list, parent = baseenv())

#       # Evaluate the captured expression in that environment
#       rlang::eval_tidy(expr_quo, data = e)
#     },
#     args = list(
#       expr_quo = expr_quo,
#       env_list = as.list(calling_env, all.names = TRUE)
#     )
#   )
# }

# run_in_callr({
#   .python_pyenv_path <- reticulate::install_python(
#     "3.12:latest",
#     force = FALSE
#   )
#   if (reticulate::virtualenv_exists("./venv")) {
#     reticulate::virtualenv_remove(envname = "./venv")
#   }
#   reticulate::virtualenv_create(
#     envname = "./venv",
#     python = .python_pyenv_path
#   )
# })

# run_in_callr({
#     set_install_opts()
#     renv::activate()
# })

# run_in_callr({
#     set_install_opts()
#     renv::restore(clean = TRUE)
#   })

# run_in_callr({
#     set_install_opts()
#     renv::install(
#       packages = setdiff(
#         c("yaml", "reticulate", "m-pilarski/helprrr", "reticulate"),
#         rownames(installed.packages())
#       ),
#       prompt = FALSE
#     )
#   }
# )

# cli::cli_alert_success("renv")

# run_in_callr({

#     .python_venv_path <- reticulate::virtualenv_python("./venv")
#     renv::use_python(.python_venv_path, type = "virtualenv")
#     helprrr::setenv_persist(
#       RETICULATE_PYTHON = .python_venv_path,
#       RENV_PYTHON = .python_venv_path
#     )
#   }
# )

# cli::cli_alert_success("venv")

# run_in_callr({

#     renv::snapshot(prompt = FALSE)
#   }
# )

# cli::cli_alert_success("snapshot")
