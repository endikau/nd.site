if (!"pak" %in% installed.packages()) {
  install.packages("pak")
}
pak::pkg_install("callr", "renv")

assertwd <- function(.wd_leaf) {
  stopifnot(grepl(paste0("(^|/)", .wd_leaf, "/?$"), getwd()))
}
condaenv_name <- "nd.site.condaenv"

################################################################################

callr::r(
  \(.call_env) {
    .call_env$assertwd("nd.site")

    renv::init()
  },
  args = list(.call_env = as.list(environment()))
)

################################################################################

callr::r(
  \(.call_env) {
    .call_env$assertwd("nd.site")

    if (!"pak" %in% installed.packages()) {
      install.packages("pak")
    }
    pak::pkg_install(c("reticulate", "fs", "m-pilarski/helprrr"))

    .conda_list <- reticulate::conda_list()

    if (.call_env$condaenv_name %in% .conda_list$name) {
      .python_path <- (.conda_list$python[
        .conda_list$name == .call_env$condaenv_name
      ])
    } else {
      .python_path <- reticulate::conda_create(
        envname = .call_env$condaenv_name,
        python_version = "3.10",
        environment = (if (fs::file_exists("environment.yml")) {
          "environment.yml"
        } else {
          NULL
        })
      )
    }

    reticulate::conda_install(
      envname = .call_env$condaenv_name,
      packages = "conda-forge::hugo"
    )

    renv::use_python(
      .python_path,
      type = "conda",
      name = .call_env$condaenv_name
    )

    helprrr::setenv_persist(
      RETICULATE_PYTHON = .python_path,
      RENV_PYTHON = .python_path
    )
  },
  args = list(.call_env = as.list(environment()))
)

################################################################################

callr::r(
  \(.call_env) {
    .call_env$assertwd("nd.site")

    renv::snapshot(prompt = FALSE)

    yaml::read_yaml("environment.yml") |>
      purrr::discard_at("prefix") |>
      yaml::write_yaml("environment.yml")
  },
  args = list(.call_env = as.list(environment()))
)
