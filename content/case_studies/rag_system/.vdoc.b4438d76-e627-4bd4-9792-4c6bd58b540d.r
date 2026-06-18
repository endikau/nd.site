library(dplyr)
library(ggplot2)
library(gt)
library(htmltools)
library(pdftools)
library(purrr)
library(scales)
library(stringr)
library(tibble)
library(tidyr)
library(xml2)

tags <- htmltools::tags

ggplot2::theme_set(`+`(
  ggplot2::theme_minimal(base_size = 14, base_family = "Open Sans"),
  ggplot2::theme(
    axis.text.x = ggplot2::element_text(size = 12),
    axis.text.y = ggplot2::element_text(size = 12),
    axis.title.x = ggplot2::element_text(size = 14),
    axis.title.y = ggplot2::element_text(size = 14),
    title = ggplot2::element_text(size = 14),
    strip.text = ggplot2::element_text(size = 14),
    panel.grid.major = ggplot2::element_blank(),
    panel.grid.minor = ggplot2::element_blank(),
    panel.background = ggplot2::element_rect(fill = NA, colour = NA),
    plot.background = ggplot2::element_rect(fill = NA, colour = NA),
    legend.position = "bottom"
  )
))

data_path <- here::here("content", "case_studies", "rag_system", "data")

clean_text <- function(.text) {
  .text |>
    stringr::str_replace_all("\u00a0", " ") |>
    stringr::str_replace_all("\\s+", " ") |>
    stringr::str_squish()
}

safe_xml_text <- function(.node) {
  if (inherits(.node, "xml_missing") || length(.node) == 0) {
    return(NA_character_)
  }
  clean_text(xml2::xml_text(.node))
}

read_html_text <- function(.path) {
  .doc <- xml2::read_html(.path)
  xml2::xml_remove(xml2::xml_find_all(
    .doc,
    ".//script|.//style|.//noscript|.//nav|.//header|.//footer"
  ))
  .main <- xml2::xml_find_first(.doc, ".//main")
  if (inherits(.main, "xml_missing")) {
    .main <- xml2::xml_find_first(.doc, ".//body")
  }
  safe_xml_text(.main)
}

read_pdf_text <- function(.path) {
  pdftools::pdf_text(.path) |>
    paste(collapse = "\n") |>
    clean_text()
}

chunk_text <- function(.text, .chunk_words = 120, .overlap_words = 30) {
  .words <- stringr::str_split(clean_text(.text), "\\s+")[[1]]
  .words <- .words[nzchar(.words)]
  if (length(.words) == 0) {
    return(character())
  }

  .step <- .chunk_words - .overlap_words
  .starts <- seq(1, length(.words), by = .step)
  purrr::map_chr(.starts, function(.start) {
    .end <- min(.start + .chunk_words - 1, length(.words))
    paste(.words[.start:.end], collapse = " ")
  })
}

tokenize_search <- function(.text) {
  .text |>
    stringr::str_to_lower() |>
    stringr::str_replace_all("[-_/]", " ") |>
    stringr::str_split("[^[:alnum:]äöüß]+") |>
    purrr::pluck(1) |>
    purrr::discard(~ !nzchar(.x))
}
