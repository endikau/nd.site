# xml2 serialisiert per Default mit `options = "format"` und schiebt dabei
# Einrückungen zwischen Kindelemente. In einem <text xml:space="preserve"> wird
# diese Einrückung zu sichtbarem Text und verschiebt die Zeilen -- deshalb ohne
# Formatierung ausgeben.
.as_svg <- function(.doc) as.character(.doc, options = character())

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
  .svg <- xml2::xml_find_first(.doc, "/*")

  # draw.io legt seine editierbare Diagrammquelle (samt eingebetteter Bilder) im
  # Attribut `content` des Wurzelelements ab. Für die Anzeige ist sie nutzlos,
  # macht aber bei manchen Dateien über 95 % der Größe aus. Sie wird nur aus der
  # eingebetteten Kopie entfernt -- die Quelldatei bleibt in draw.io editierbar.
  xml2::xml_attr(.svg, "content") <- NULL

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
  .view_box <- as.numeric(stringi::stri_split_regex(
    xml2::xml_attr(.svg, "viewBox"), "[\\s,]+"
  )[[1]])
  # Schriftgrößen stehen je nach Werkzeug im style-Attribut (Inkscape) oder als
  # Präsentationsattribut (draw.io) -- beide Formen berücksichtigen. Größe 0
  # kommt in draw.io-Exporten für unsichtbare Hilfstexte vor und darf die
  # Auswahl nicht verfälschen; bei Gleichstand gewinnt die größere Angabe, da
  # kleine Werte typischerweise zu ausgeblendeten Fallback-Texten gehören.
  # <foreignObject> wird in diesen Exporten nie gezeichnet (der umgebende
  # <switch> überspringt ihn), seine Schriftgrößen würden die Zählung nur
  # verfälschen -- nur für die Erkennung ausblenden, nicht in der Ausgabe.
  .visible <- stringi::stri_replace_all_regex(
    .as_svg(.doc), "(?s)<foreignObject.*?</foreignObject>", ""
  )
  .sizes <- as.numeric(stringi::stri_match_all_regex(
    .visible, "font-size\\s*[:=]\\s*\"?\\s*([0-9.]+)px"
  )[[1]][, 2])
  .sizes <- .sizes[!is.na(.sizes) & .sizes > 0]
  if (length(.sizes) > 0) {
    .counts <- table(.sizes)
    .font_size <- max(as.numeric(names(.counts)[.counts == max(.counts)]))
    .width <- sprintf("width:%.4fem", .view_box[3] / .font_size)
  } else {
    # Setzt das SVG keine eigene Schriftgröße, erbt sein Text die der Seite.
    # Dann stimmt die Größe genau bei Maßstab 1:1 -- und sie wächst sogar mit,
    # falls die Seite ihre Schriftgröße ändert.
    .width <- sprintf("width:%.4fpx", .view_box[3])
  }
  xml2::xml_attr(.svg, "style") <- .width

  htmltools::tagList(
    htmltools::tags$style(htmltools::HTML(
      ".nd-inline-svg svg { display: block; margin: 0 auto; max-width: 100%; height: auto; }"
    )),
    htmltools::tags$div(
      class = "nd-inline-svg",
      htmltools::HTML(
        stringi::stri_replace_first_regex(.as_svg(.doc), "(?s)\\A.*?(?=<svg)", "")
      )
    )
  )
}
