# scripts/setup_envs.R

install.packages(
  pkgs = c("pak", "renv", "reticulate"),
  repos = "https://packagemanager.posit.co/cran/latest",
  Ncpus = parallel::detectCores()
)

renv::restore(clean = TRUE, prompt = FALSE)
