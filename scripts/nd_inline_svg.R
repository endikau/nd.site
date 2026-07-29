#' SVG direkt in die Seite schreiben statt über <img> einbinden
#'
#' Ein über `<img src="...svg">` eingebundenes SVG ist ein eigenständiges
#' Dokument: die Stylesheets und Webfonts der Seite erreichen es nicht, es kann
#' also ausschließlich Schriften nutzen, die auf dem Rechner der Betrachtenden
#' installiert sind. Fehlt die Schrift, greift ein Ersatz mit anderen
#' Laufweiten und der Text passt nicht mehr zu fest gesetzten Rahmen und
#' Pfeilen. Inline eingebettet ist das SVG Teil des Dokuments und nutzt den
#' Webfont der Seite.
#'
#' @param .file Pfad zur SVG-Datei.
#' @return Ein `htmltools`-Tag zur Weitergabe an `nd.util::render_raw_html()`.
nd_inline_svg <- function(.file) {
  .doc <- xml2::read_xml(.file)

  # Hugos --minify entfernt sonst die bedeutungstragenden Leerzeichen zwischen
  # den <tspan>-Elementen ("auf derBankim Park"). Geschützte Leerzeichen
  # überstehen die Minifizierung und sind metrisch identisch.
  for (.node in xml2::xml_find_all(.doc, "//*[local-name()='text']//text()")) {
    xml2::xml_text(.node) <- stringi::stri_replace_all_fixed(
      xml2::xml_text(.node), " ", "\u00a0"
    )
  }

  # Breite in em, abgeleitet aus der Schriftgröße im SVG: dadurch erscheint der
  # Text im SVG so groß wie der Fließtext der Seite. Maßgeblich ist die
  # häufigste Größe, nicht die größte -- sie steht für den Grundtext der
  # Grafik, während Überschriften darin größer gesetzt sind. Passt die Grafik
  # so nicht in die Spalte, greift max-width und sie wird proportional kleiner.
  .svg <- xml2::xml_find_first(.doc, "/*")
  .view_box <- as.numeric(stringi::stri_split_regex(
    xml2::xml_attr(.svg, "viewBox"), "[\\s,]+"
  )[[1]])
  .sizes <- stringi::stri_match_all_regex(
    as.character(.doc), "font-size:\\s*([0-9.]+)px"
  )[[1]][, 2]
  .font_size <- as.numeric(names(which.max(table(.sizes))))
  xml2::xml_attr(.svg, "style") <- sprintf(
    "width:%.4fem", .view_box[3] / .font_size
  )

  htmltools::tagList(
    htmltools::tags$style(htmltools::HTML(
      ".nd-inline-svg svg { display: block; margin: 0 auto; max-width: 100%; height: auto; }"
    )),
    htmltools::tags$div(
      class = "nd-inline-svg",
      htmltools::HTML(
        stringi::stri_replace_first_regex(as.character(.doc), "(?s)\\A.*?(?=<svg)", "")
      )
    )
  )
}
