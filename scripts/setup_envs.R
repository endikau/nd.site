set_install_opts <- function() {
  if (any(readLines("/etc/os-release") == "VERSION_CODENAME=noble")) {
    p3m_repo <- "https://p3m.dev/cran/__linux__/noble/latest"
    options(
      repos = c(CRAN = p3m_repo),
      renv.config.ppm.enabled = TRUE,
      renv.config.ppm.default = TRUE,
      renv.config.rspm.enabled = TRUE,
      renv.config.repos.override = p3m_repo,
      renv.config.pak.enabled = TRUE
    )
  }
}

set_install_opts()

install.packages("pak")

pak::pak(pkg = c("callr", "cli", "renv", "reticulate", "rlang"))

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


as.list(environment())

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
