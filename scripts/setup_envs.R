condaenv_name <- "nd.site.condaenv"

install.packages(
  pkgs = setdiff("renv", rownames(installed.packages())),
  repos = "https://cloud.r-project.org"
)

# install.packages(
#   pkgs = setdiff("pak", rownames(installed.packages())),
#   repos = "https://cloud.r-project.org"
# )
# options(renv.config.pak.enabled = TRUE)

renv::activate()

renv::install("cli", prompt = FALSE)
cli::cli_alert_success("renv activated")

options(
  # renv.config.repos.override = c(
  #   "https://cran.rstudio.com/"
  # ),
  renv.config.ppm.enabled = TRUE
)
renv::install("yaml", prompt = FALSE)
renv::restore()

renv::repair()

cli::cli_alert_success("renv restored")

renv::install("reticulate", prompt = FALSE)
python_path <- local({
  .conda_list <- reticulate::conda_list()

  if (condaenv_name %in% .conda_list$name) {
    .python_path <- .conda_list$python[.conda_list$name == condaenv_name]
  } else {
    .python_path <- reticulate::conda_create(
      envname = condaenv_name,
      environment = "environment.yml"
    )
  }
  return(.python_path)
})

cli::cli_alert_success("conda environment created")

renv::use_python(python_path, type = "conda", name = condaenv_name)

renv::install("m-pilarski/helprrr", prompt = FALSE)
helprrr::setenv_persist(
  RETICULATE_PYTHON = python_path,
  RENV_PYTHON = python_path
)

renv::snapshot(prompt = FALSE)

yaml::read_yaml("environment.yml") |>
  purrr::discard_at("prefix") |>
  yaml::write_yaml("environment.yml")
