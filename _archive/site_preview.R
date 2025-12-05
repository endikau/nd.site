serve_hugo <- function(){

  # .hugo_path <- fs::path(.condaenv_path, "bin", "hugo")
  .port <- reticulate::py_run_string(stringi::stri_c(
    "import socket",
    "sock = socket.socket()",
    "sock.bind(('', 0))",
    "free_port = sock.getsockname()[1]",
    "sock.close()",
    sep="\n"
  ))["free_port"]

  on.exit({.hugo_server$kill()})

  # TODO: use callr::r_bg
  .hugo_server <- processx::process$new(
  # .hugo_server <- processx::run(
    command=fs::path(
      fs::path_dir(reticulate::conda_python("nd.site.condaenv")), "hugo"
    ),
    args=as.character(list(
      "server", "--port", as.integer(.port), "--buildDrafts",
      "--buildFuture"
    )),
    wd=here::here("hugo")
  )

  utils::browseURL(paste0("http://localhost:", .port))

  Sys.sleep(Inf)

}

serve_hugo()
