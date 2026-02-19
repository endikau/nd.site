set_install_opts <- function() {
  # robust check for Ubuntu 24.04 codename
  os_release <- readLines("/etc/os-release", warn = FALSE)
  codename <- sub("^VERSION_CODENAME=", "", os_release[grepl("^VERSION_CODENAME=", os_release)])
  if (length(codename) == 1 && codename == "noble") {

    # Use the *source* P3M endpoint; renv/PPM integration will map to Linux binaries.
    ppm_src <- "https://packagemanager.posit.co/cran/latest"

    options(
      repos = c(CRAN = ppm_src),

      # renv: prefer PPM/P3M integration (rspm.* is deprecated)
      renv.config.ppm.enabled = TRUE,
      renv.config.ppm.default = TRUE,
      renv.config.ppm.url = ppm_src,

      # only if you really want to force this repo during restore()
      renv.config.repos.override = paste0("CRAN=", ppm_src),

      # pak integration (optional)
      renv.config.pak.enabled = TRUE
    )
  }
}


set_install_opts()

install.packages(c("pak", "callr"))

pak::pak(pkg = c("cli", "renv", "reticulate", "rlang"))

run_in_callr <- function(.expr) {
  expr_quo <- rlang::enquo(.expr)
  calling_env <- rlang::caller_env()

  callr::r(
    function(expr_quo, env_list) {
      # Reconstruct an environment from a named list
      e <- list2env(env_list, parent = baseenv())

      # Evaluate the captured expression in that environment
      rlang::eval_tidy(expr_quo, data = e)
    },
    args = list(
      expr_quo = expr_quo,
      env_list = as.list(calling_env, all.names = TRUE)
    )
  )
}

run_in_callr({
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
  }
)

cli::cli_alert_success("renv")

run_in_callr({

    .python_venv_path <- reticulate::virtualenv_python("./venv")
    renv::use_python(.python_venv_path, type = "virtualenv")
    helprrr::setenv_persist(
      RETICULATE_PYTHON = .python_venv_path,
      RENV_PYTHON = .python_venv_path
    )
  }
)

cli::cli_alert_success("venv")

run_in_callr({

    renv::snapshot(prompt = FALSE)
  }
)

cli::cli_alert_success("snapshot")
