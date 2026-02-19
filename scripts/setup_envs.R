if (any(readLines("/etc/os-release") == "VERSION_CODENAME=noble")) {
  options(
    repos = c(CRAN = "https://p3m.dev/cran/__linux__/noble/latest"),
    renv.config.ppm.enabled = TRUE,
    renv.config.ppm.default = TRUE,
    renv.config.rspm.enabled = TRUE,
    renv.config.repos.override = "https://packagemanager.posit.co/cran/__linux__/noble/latest"
  )
}

install.packages(
  pkgs = setdiff(
    c("renv", "callr", "cli", "reticulate"),
    rownames(installed.packages())
  ),
  repos = "https://p3m.dev/cran/__linux__/noble/latest"
)

callr::r(
  \(...) {
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
  }, 
  show = TRUE
)

callr::r(
  \(...) {
    renv::activate()
  },
  show = TRUE
)

callr::r(
  \(...) {
    renv::restore(clean = TRUE)
  },
  show = TRUE
)

callr::r(
  \(...) {
    renv::install(
      packages = setdiff(
        c("yaml", "reticulate", "m-pilarski/helprrr", "reticulate"),
        rownames(installed.packages())
      ),
      prompt = FALSE
    )
  },
  show = TRUE
)

cli::cli_alert_success("renv")

callr::r(
  \(...) {
    .python_venv_path <- reticulate::virtualenv_python("./venv")
    renv::use_python(.python_venv_path, type = "virtualenv")
    helprrr::setenv_persist(
      RETICULATE_PYTHON = .python_venv_path,
      RENV_PYTHON = .python_venv_path
    )
  },
  show = TRUE
)

cli::cli_alert_success("venv")

callr::r(
  \(...) {
    renv::snapshot(prompt = FALSE)
  },
  show = TRUE
)

cli::cli_alert_success("snapshot")
