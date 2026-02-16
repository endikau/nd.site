install.packages(
  pkgs = setdiff(
    c("renv", "callr", "reticulate", "cli"), 
    rownames(installed.packages())
  ),
  repos = "https://cloud.r-project.org"
)

# options(renv.config.ppm.enabled = TRUE)

callr::r(\(...){renv::activate()})

callr::r(\(...){renv::restore()})

callr::r(\(...){
  renv::install(c("yaml", "reticulate"), prompt = FALSE)
})

cli::cli_alert_success("renv finished")

callr::r(\(...){

})

callr::r(\(...){
  .python_pyenv_path <- reticulate::install_python("3.12:latest", force = FALSE)
  if (!reticulate::virtualenv_exists("./venv")) { 
    reticulate::virtualenv_create(
      envname = "./venv",
      python = python_pyenv_path,
      requiremens = (if (fs::file_exists("requirements.txt")) {
        "requirements.txt"
      } else {
        NULL
      })
    )
  }
})

cli::cli_alert_success("conda environment created")

renv::use_python(python_path, type = "conda", name = condaenv_name)

renv::install("m-pilarski/helprrr", prompt = FALSE)
helprrr::setenv_persist(
  RETICULATE_PYTHON = python_path,
  RENV_PYTHON = python_path
)

renv::install("callr", prompt = FALSE)
callr::r(\(...){renv::snapshot(prompt = FALSE)})

