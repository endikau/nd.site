set_pkg_opts()

install.packages("pak")

pak::pak(pkg = c("callr", "cli", "pak", "renv", "reticulate"))

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
    set_pkg_opts()
    renv::activate()
  },
  show = TRUE
)

callr::r(
  \(...) {
    set_pkg_opts()
    renv::restore(clean = TRUE)
  },
  show = TRUE
)

callr::r(
  \(...) {
    set_pkg_opts()
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
