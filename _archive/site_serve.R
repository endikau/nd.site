action_confirmed <- askYesNo("Do you want to update the site?", default = FALSE)

proj_dir <- fs::path_real(here::here())
serve_dir <- fs::path_real("~/Documents/endikau/endikau.shares/site/")
temp_dir <- fs::path_real(fs::dir_create(fs::file_temp(pattern = "dir")))

stopifnot(
  action_confirmed,
  Sys.info()["nodename"] %in% c("hz126d", "hz126w"),
  grepl("/nd.site/?$", proj_dir)
)

processx::run(
  command = "quarto",
  args = c("render"),
  wd = proj_dir
)

processx::run(
  command = "hugo",
  args = c("--cleanDestinationDir", "--destination", temp_dir, "--minify"),
  wd = fs::path(proj_dir, "hugo")
)

# processx::run(
#   command="rm",
#   args=c("-r", fs::path(serve_dir, "*"))
# )

processx::run(
  command = "cp",
  args = c("-a", fs::path(temp_dir, "."), serve_dir)
)
