---
title: Grundlagen
date: '2024-11-25T14:25:49+01:00'
draft: false
tags:
  - foo
  - bar
format: hugo-md
toc_show: true
---


## Datenquellen im Überblick

Viele Unternehmen verfügen über eine Fülle an Kommunikationsdaten, die wertvolle Einblicke bieten können. Doch oft werden diese Datenquellen nicht systematisch erfasst und bleiben deshalb ungenutzt. Im Folgenden finden Sie eine Übersicht über interne und externe Textdatenquellen, die oftmals zur Verfügung stehen, sowie deren Relevanz als Informationsbasis für Unternehmen:

### Interne Textdaten

Interne Datenquellen bieten Einblicke in Ihre Betriebsabläufe und die Bedürfnisse von Kunden:
{{< fa-ul >}}
{{< fa-solid-li icon=\"bullhorn\" >}} **Kundenkommunikation**: Verwaltung von Kundenanfragen und Support-Tickets, um den Service zu verbessern und Probleme schneller zu lösen.{{< /fa-solid-li >}}

{{< fa-solid-li icon=\"square-poll-horizontal\" >}} **Kundenbefragungen**: Analyse des Feedbacks aus Umfragen, um Trends und Wünsche der Zielgruppe zu verstehen.{{< /fa-solid-li >}}

{{< fa-solid-li icon=\"comments\" >}} **Interne Kommunikation**: Erkenntnisse aus Meetingprotokollen, Projektberichten oder E-Mails ziehen.{{< /fa-solid-li >}}

{{< fa-solid-li icon=\"users\" >}} **CRM-Systeme**: Nutzen von Kundeninteraktionen, um personalisierte Angebote und gezielte Kampagnen zu entwickeln.{{< /fa-solid-li >}}

{{< fa-solid-li icon=\"check\" >}} **Qualitätsmanagement-Daten**: Identifikation von Schwachstellen in Produkten oder Prozessen durch die Analyse von Berichten und Protokollen. {{< /fa-solid-li >}}
{{< /fa-ul >}}

### Externe Textdaten

Externe Quellen helfen, Kundenwünsche und Marktveränderungen zu identifizieren:
{{< fa-ul >}}
{{< fa-solid-li icon=\"star\" >}} **Kundenbewertungen**: Erkennen Sie, was Ihre Kunden schätzen oder kritisieren, durch Bewertungen auf Plattformen wie Amazon, Google oder Ihrer eigenen Website. {{< /fa-solid-li >}}

{{< fa-solid-li icon=\"hashtag\" >}} **Social Media-Daten**: Finden Sie heraus, wie Kunden über Ihre Marke sprechen, und erkennen Sie neue Trends in Echtzeit. {{< /fa-solid-li >}}

{{< fa-solid-li icon=\"newspaper\" >}} **Nachrichten und Blogs**: Analysieren Sie Berichte oder Presseartikel, um Ihr Markenimage und die öffentliche Wahrnehmung zu verstehen. {{< /fa-solid-li >}}
{{< /fa-ul >}}

Textdaten durchziehen nahezu **alle Bereiche Ihres Unternehmens**. Das systematische Erfassen solcher Daten ist daher ein erster Schritt, um diese als **Grundlage für fundierte Entscheidungen** zu verwenden.

## Aus unstrukturierten Daten Wissen schöpfen

Textdaten wie E-Mails, Kundenrezensionen oder interne Dokumente stellen viele Unternehmen vor eine Herausforderung -- sie sind unstrukturiert und dadurch vermeintlich schwer auswertbar. Das Hauptproblem von Textdaten ist, dass sie nicht von Computern gelesen werden können, da Computer nur mit Zahlen arbeiten können. Dementsprechend müssen Texte numerisch umgewandelt werden. Im folgenden Abschnitt werden Technologien näher vorgestellt, die diese Umwandlung von Text- zu numerischen Daten ermöglichen, um damit Texte als Datenquelle für weitere Analysen nutzen zu können.

{{< p class=\"pb-0\" >}}
**Natural Language Processing (NLP)** ist eine Technologie, die Computern ermöglicht, schriftliche oder gesprochene Sprache zu verstehen und zu analysieren. Sie kommt ins Spiel, wenn unstrukturierte Texte -- wie E-Mails, Kundenrezensionen oder Social-Media-Beiträge -- verarbeitet werden sollen. NLP wandelt diese Textdaten in strukturierte Daten um, die einfacher auszuwerten sind als in ihrer unstrukturierten Form.
{{< /p >}}

{{< div class=\"grid my-4\" >}} {{< div class=\"g-col-12 g-col-md-8 g-start-md-3\" >}}

<img src="img/nlp.svg" style="width:100.0%" />

{{< /div >}} {{< /div >}}

{{< p class=\"pb-0\" >}}
**Text Mining** ergänzt NLP, indem es darauf abzielt, Muster, Zusammenhänge und Trends in den nun strukturierten Textdaten aufzudecken. Ähnlich wie beim „Mining" -- auf Deutsch Bergbau -- werden Texte nach wertvollen Inhalten durchforstet, um nützliche Erkenntnisse zu fördern. Während NLP auf das Verstehen und die Aufbereitung der Sprache fokussiert ist, nutzt Text Mining diese aufbereiteten Daten, um relevante Muster und Strukturen zu extrahieren. Gemeinsam bilden sie ein leistungsstarkes Duo: NLP bringt die Texte in eine nützliche Form, und Text Mining hebt das verborgene Wissen ans Licht.
{{< /p >}}

{{< div class=\"grid my-4\" >}} {{< div class=\"g-col-8 g-start-3 g-col-md-6 g-start-md-4\" >}}

<img src="img/text_mining.svg" style="width:100.0%" />

{{< /div >}} {{< /div >}}

Die Kombination dieser Methoden eröffnet eine **Vielzahl von Möglichkeiten für Unternehmen**: Von der Optimierung des Kundenservice über die Entwicklung neuer Produkte bis hin zur Identifizierung von Markttrends.

<!-- Das evtl. als eigene Seite anlegen? -->

## Textdaten für Analysen vorbereiten

Der Ausgangspunkt jeder Textanalyse ist eine **Sammlung von Dokumenten bzw. Texten**, welche auch als **Korpus** bezeichnet wird. Dieser kann in der Form noch nicht für Analysen verwendet werden, denn die Texte liegen weiterhin in einem unstrukturierten Format vor. Das Hauptziel des **„Preprocessing"** (deutsch: Vorverarbeitung) ist es, den Aufwand für Computer zu reduzieren, indem man den Korpus auf das Wesentliche reduziert. Dies erlaubt für effizientere Analysen.Um aus Texten relevante Informationen zu extrahieren, müssen diese zunächst in eine für Computer leserliche Struktur gebracht werden. Hierfür werden verschiedene Schritte genommen, sodass zum Schluss eine strukturierte Version des Textes vorliegt, die für weitere Analysen genutzt werden kann.

{{< p class=\"pb-0\" >}}
In den nächsten Abschnitten werden eine Reihe von Vorverarbeitungsschritten erläutert, die je nach der verwendeten Methode unterschiedlich kombiniert werden können. Eine typische Maßnahme ist, die vorliegenden Texte in ihre einzelnen Elemente zu unterteilen, zum Beispiel in Sätze oder einzelne Wörter. Diese kleinsten Einheiten werden in der NLP-Sprache auch als **Tokens** (deutsch: Zeichen oder Symbol), bezeichnet. Entsprechend wird dieser Vorgang auch als **Tokenisierung** bezeichnet.
{{< /p >}}

{{< div class=\"grid my-4\" >}} {{< div class=\"g-col-12\" >}}

<img src="img/token.svg" style="width:100.0%" />

{{< /div >}} {{< /div >}}

Um die Texte weiter zu vereinfachen können zum Beispiel auch alle Wörter **kleingeschrieben** werden, sodass „Heute" und „heute" nicht als zwei verschiedene Begriffe kategorisiert werden. Außerdem könnte man auch alle **Symbole**, wie Punkt, Komma, @, usw., entfernen. Um die Anzahl einzelner Begriffe zu reduzieren, ist es ebenfalls üblich so genannte **Stopwords** zu entfernen. Stopwords sind Begriffe, die sehr häufig in Texten verwendet werden, die jedoch wenig zum Kontext oder der Bedeutung des Textes beitragen, wie Artikel (der, die, das), Konjunktionen (und, oder, aber, ...), und viele mehr.

{{< p class=\"pb-0\" >}}
Um verschiedene Formen von Wörtern auf den jeweiligen Stamm, die sie miteinander Teilen zu reduzieren, können zwei Methoden verwendet werden: **Stemming** und/oder **Lemmatisierung**. Die Methoden können einzeln oder kombiniert werden, mit dem Ziel Wortstämme zu identifizieren und damit die Anzahl einzelner Begriffe in den Texten weiter zu reduzieren. **Stemming** identifiziert die **gemeinsame Basis verschiedener Wörter**, um sie damit auf diese zu reduzieren. Hierfür werden entsprechend Präfixe, Suffixe, etc. entfernt oder abgeschnitten, sodass nur der Wortstamm übrigbleibt. **Lemmatisierung** hingegen, zielt darauf ab Lemmas, also die **Grundform des Wortes**, die in einem Wörterbuch vorzufinden ist, zu identifizieren und Wörter darauf zu reduzieren. Anders als beim Stemming resultiert entsprechend immer ein lexikographisch korrektes Wort bei der Lemmatisierung, da Wörter identifiziert werden und nicht Prä- bzw. Suffixe einfach entfernt werden.
{{< /p >}}

{{< div class=\"grid my-4\" >}} {{< div class=\"g-col-12 g-col-md-8 g-start-md-3\" >}}

<img src="img/stemm_lemm.svg" style="width:100.0%" />

{{< /div >}} {{< /div >}}

Die interaktive Demo zeigt, wie sich **gängige Vorverarbeitungsschritte** auf Textdaten auswirken. Sie können einen Text auswählen und anschließend die einzelnen Schritte nach Belieben anwenden, um den Effekt direkt zu sehen.

<div id="loader-9eb130a6" class="d-flex justify-content-center justify-content-center align-items-center" style="width: 100%; height: 4rem;">
<div class="spinner-border text-primary" role="status">
<span class="sr-only">Loading...</span>
</div>
</div>
<iframe id="iframe-9eb130a6" scrolling="no" loading="lazy" style="width: 100%; height: 0;"></iframe>
<script>$(document).ready(function(){
  $('#iframe-9eb130a6').attr('src', 'https://shiny.dsjlu.wirtschaft.uni-giessen.de/preprocessing_demo/');
  $('#iframe-9eb130a6').on('load', function() {
     $('#loader-9eb130a6').remove();
  });
});</script>
<script>var domains = ['https://shiny.dsjlu.wirtschaft.uni-giessen.de'];
iframeResize(
  {waitForLoad: false, license: 'GPLv3', checkOrigin: domains}, 
  '#iframe-9eb130a6'
);</script>

## Texte numerisch darstellen

Die Vorverarbeitung der Texte allein genügt nicht, um sie vollständig in eine computerlesbare Struktur zu überführen. Es sind weitere Methoden erforderlich, die Wörter numerisch darstellen. Hier gibt es verschiedene Verfahren, die für unterschiedliche Methoden geeignet sind.

### Häufigkeitsbasierte Verfahren

#### Bag of Words

Das **Bag-of-Words-Modell** (BoW) ist eine der einfachsten Methoden, um Texte in eine numerische Form zu überführen. Dabei wird für jeden Text gezählt, wie oft bestimmte Wörter vorkommen, unabhängig von ihrer Reihenfolge oder ihrem Kontext. Jeder Text wird dadurch zu einem sogenannten **Wortvektor**, in dem jedes Element die Häufigkeit eines bestimmten Begriffs angibt.

<?xml version="1.0" encoding="UTF-8"?>
<div id="gffycjldax" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
  <table class="gt_table" data-quarto-disable-processing="true" data-quarto-bootstrap="false" style="-webkit-font-smoothing: antialiased; -moz-osx-font-smoothing: grayscale; font-family: var(--bs-body-font-family); display: table; border-collapse: collapse; line-height: normal; margin-left: auto; margin-right: auto; color: #333333; font-size: var(--bs-body-font-size); font-weight: var(--bs-body-fontweight); font-style: normal; background-color: rgba(255, 255, 255, 0); width: 100%; border-top-style: solid; border-top-width: 2px; border-top-color: #A8A8A8; border-right-style: none; border-right-width: 2px; border-right-color: #D3D3D3; border-bottom-style: solid; border-bottom-width: 2px; border-bottom-color: #A8A8A8; border-left-style: none; border-left-width: 2px; border-left-color: #D3D3D3;" width="100%" bgcolor="rgba(255, 255, 255, 0)">
    <thead style="border-style: none;">
      <tr class="gt_col_headings" style="border-style: none; border-top-style: solid; border-top-width: 2px; border-top-color: #D3D3D3; border-bottom-style: solid; border-bottom-width: 2px; border-bottom-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3;">
        <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="text" style="border-style: none; color: #333333; background-color: rgba(255, 255, 255, 0); font-size: 100%; font-weight: bold; text-transform: inherit; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: bottom; padding-top: 5px; padding-bottom: 6px; padding-left: 5px; padding-right: 5px; overflow-x: hidden; text-align: left;" bgcolor="rgba(255, 255, 255, 0)" valign="bottom" align="left"/>
        <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="das" style="border-style: none; color: #333333; background-color: rgba(255, 255, 255, 0); font-size: 100%; font-weight: bold; text-transform: inherit; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: bottom; padding-top: 5px; padding-bottom: 6px; padding-left: 5px; padding-right: 5px; overflow-x: hidden; text-align: right; font-variant-numeric: tabular-nums;" bgcolor="rgba(255, 255, 255, 0)" valign="bottom" align="right">das</th>
        <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="essen" style="border-style: none; color: #333333; background-color: rgba(255, 255, 255, 0); font-size: 100%; font-weight: bold; text-transform: inherit; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: bottom; padding-top: 5px; padding-bottom: 6px; padding-left: 5px; padding-right: 5px; overflow-x: hidden; text-align: right; font-variant-numeric: tabular-nums;" bgcolor="rgba(255, 255, 255, 0)" valign="bottom" align="right">essen</th>
        <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="gut" style="border-style: none; color: #333333; background-color: rgba(255, 255, 255, 0); font-size: 100%; font-weight: bold; text-transform: inherit; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: bottom; padding-top: 5px; padding-bottom: 6px; padding-left: 5px; padding-right: 5px; overflow-x: hidden; text-align: right; font-variant-numeric: tabular-nums;" bgcolor="rgba(255, 255, 255, 0)" valign="bottom" align="right">gut</th>
        <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="war" style="border-style: none; color: #333333; background-color: rgba(255, 255, 255, 0); font-size: 100%; font-weight: bold; text-transform: inherit; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: bottom; padding-top: 5px; padding-bottom: 6px; padding-left: 5px; padding-right: 5px; overflow-x: hidden; text-align: right; font-variant-numeric: tabular-nums;" bgcolor="rgba(255, 255, 255, 0)" valign="bottom" align="right">war</th>
        <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="der" style="border-style: none; color: #333333; background-color: rgba(255, 255, 255, 0); font-size: 100%; font-weight: bold; text-transform: inherit; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: bottom; padding-top: 5px; padding-bottom: 6px; padding-left: 5px; padding-right: 5px; overflow-x: hidden; text-align: right; font-variant-numeric: tabular-nums;" bgcolor="rgba(255, 255, 255, 0)" valign="bottom" align="right">der</th>
        <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="service" style="border-style: none; color: #333333; background-color: rgba(255, 255, 255, 0); font-size: 100%; font-weight: bold; text-transform: inherit; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: bottom; padding-top: 5px; padding-bottom: 6px; padding-left: 5px; padding-right: 5px; overflow-x: hidden; text-align: right; font-variant-numeric: tabular-nums;" bgcolor="rgba(255, 255, 255, 0)" valign="bottom" align="right">service</th>
        <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="restaurant" style="border-style: none; color: #333333; background-color: rgba(255, 255, 255, 0); font-size: 100%; font-weight: bold; text-transform: inherit; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: bottom; padding-top: 5px; padding-bottom: 6px; padding-left: 5px; padding-right: 5px; overflow-x: hidden; text-align: right; font-variant-numeric: tabular-nums;" bgcolor="rgba(255, 255, 255, 0)" valign="bottom" align="right">restaurant</th>
        <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="sauber" style="border-style: none; color: #333333; background-color: rgba(255, 255, 255, 0); font-size: 100%; font-weight: bold; text-transform: inherit; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: bottom; padding-top: 5px; padding-bottom: 6px; padding-left: 5px; padding-right: 5px; overflow-x: hidden; text-align: right; font-variant-numeric: tabular-nums;" bgcolor="rgba(255, 255, 255, 0)" valign="bottom" align="right">sauber</th>
      </tr>
    </thead>
    <tbody class="gt_table_body" style="border-style: none; border-top-style: solid; border-top-width: 2px; border-top-color: #D3D3D3; border-bottom-style: solid; border-bottom-width: 2px; border-bottom-color: #D3D3D3;">
      <tr style="border-style: none;">
        <td headers="text" class="gt_row gt_left" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left">Das Essen war gut.</td>
        <td headers="das" class="gt_row gt_right" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: right; font-variant-numeric: tabular-nums;" valign="middle" align="right">1</td>
        <td headers="essen" class="gt_row gt_right" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: right; font-variant-numeric: tabular-nums;" valign="middle" align="right">1</td>
        <td headers="gut" class="gt_row gt_right" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: right; font-variant-numeric: tabular-nums;" valign="middle" align="right">1</td>
        <td headers="war" class="gt_row gt_right" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: right; font-variant-numeric: tabular-nums;" valign="middle" align="right">1</td>
        <td headers="der" class="gt_row gt_right" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: right; font-variant-numeric: tabular-nums;" valign="middle" align="right">0</td>
        <td headers="service" class="gt_row gt_right" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: right; font-variant-numeric: tabular-nums;" valign="middle" align="right">0</td>
        <td headers="restaurant" class="gt_row gt_right" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: right; font-variant-numeric: tabular-nums;" valign="middle" align="right">0</td>
        <td headers="sauber" class="gt_row gt_right" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: right; font-variant-numeric: tabular-nums;" valign="middle" align="right">0</td>
      </tr>
      <tr style="border-style: none;">
        <td headers="text" class="gt_row gt_left" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left">Der Service war gut.</td>
        <td headers="das" class="gt_row gt_right" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: right; font-variant-numeric: tabular-nums;" valign="middle" align="right">0</td>
        <td headers="essen" class="gt_row gt_right" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: right; font-variant-numeric: tabular-nums;" valign="middle" align="right">0</td>
        <td headers="gut" class="gt_row gt_right" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: right; font-variant-numeric: tabular-nums;" valign="middle" align="right">1</td>
        <td headers="war" class="gt_row gt_right" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: right; font-variant-numeric: tabular-nums;" valign="middle" align="right">1</td>
        <td headers="der" class="gt_row gt_right" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: right; font-variant-numeric: tabular-nums;" valign="middle" align="right">1</td>
        <td headers="service" class="gt_row gt_right" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: right; font-variant-numeric: tabular-nums;" valign="middle" align="right">1</td>
        <td headers="restaurant" class="gt_row gt_right" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: right; font-variant-numeric: tabular-nums;" valign="middle" align="right">0</td>
        <td headers="sauber" class="gt_row gt_right" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: right; font-variant-numeric: tabular-nums;" valign="middle" align="right">0</td>
      </tr>
      <tr style="border-style: none;">
        <td headers="text" class="gt_row gt_left" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left">Das Restaurant war sauber.</td>
        <td headers="das" class="gt_row gt_right" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: right; font-variant-numeric: tabular-nums;" valign="middle" align="right">1</td>
        <td headers="essen" class="gt_row gt_right" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: right; font-variant-numeric: tabular-nums;" valign="middle" align="right">0</td>
        <td headers="gut" class="gt_row gt_right" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: right; font-variant-numeric: tabular-nums;" valign="middle" align="right">0</td>
        <td headers="war" class="gt_row gt_right" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: right; font-variant-numeric: tabular-nums;" valign="middle" align="right">1</td>
        <td headers="der" class="gt_row gt_right" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: right; font-variant-numeric: tabular-nums;" valign="middle" align="right">0</td>
        <td headers="service" class="gt_row gt_right" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: right; font-variant-numeric: tabular-nums;" valign="middle" align="right">0</td>
        <td headers="restaurant" class="gt_row gt_right" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: right; font-variant-numeric: tabular-nums;" valign="middle" align="right">1</td>
        <td headers="sauber" class="gt_row gt_right" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: right; font-variant-numeric: tabular-nums;" valign="middle" align="right">1</td>
      </tr>
    </tbody>
  </table>
</div>

Dieses Verfahren ist besonders einfach zu implementieren und funktioniert gut für erste Analysen, z.B. für die Analyse von Worthäufigkeiten. Allerdings geht die Bedeutung von Sprache verloren, da weder Satzstruktur noch Wortbedeutung berücksichtigt werden.

#### TF-IDF

**TF-IDF** ist eine Weiterentwicklung des Bag-of-Words-Modells. Es zählt nicht nur, wie **oft ein Wort in einem Text vorkommt** (TF = Term Frequency), sondern prüft auch, wie **selten es im gesamten Textkorpus ist** (IDF = Inverse Document Frequency).

Alltägliche Wörter wie „ist" oder „und" erscheinen in vielen Dokumenten und erhalten deshalb eine niedrige Gewichtung. Fachbegriffe oder thematisch wichtige Wörter, die nur in wenigen Dokumenten auftauchen, werden dagegen stärker gewichtet. So erkennt TF-IDF, welche Begriffe für den jeweiligen Text besonders aussagekräftig sind.

<!-- TODO: Illustration? -->

### Kontextuelle Verfahren

Moderne Verfahren basieren auf sogenannte **Word Embeddings** (Worteinbettungen). Dabei werden Wörter in einem numerischen Raum so eingebettet, dass semantische Ähnlichkeiten messbar werden.

#### Word2Vec

Ein früherer Vertreter solcher Einbettungen ist die Word2Vec Methode. Im Gegensatz zu BoW oder TF-IDF, die Wörter nur zählen, ist Word2Vec ein von Google trainiertes Modell, welches anhand von **neuronalen Netzwerken** lernte, welche Wörter in **ähnlichen Kontexten** verwendet werden und gibt ihnen **ähnliche Vektoren**.

{{< p class=\"pb-0\" >}}
In der Grafik sieht man, dass das Modell nicht nur erkennt, dass „König" und „Königin" zusammengehören, sondern auch die Beziehung zwischen „Mann" und „Frau" versteht. Die Richtung und Länge der Pfeile zeigen, dass die Bedeutung von „König" zu „Königin" ähnlich ist wie von „Mann" zu „Frau". So lassen sich Bedeutungen im Raum nicht nur erkennen, sondern auch rechnerisch ableiten, wie zum Beispiel *König -- Mann + Frau = Königin*.
{{< /p >}}

{{< div class=\"grid my-4\" >}} {{< div class=\"g-col-12 g-col-md-6 g-start-md-4\" >}}

<img src="img/embeddings.svg" style="width:100.0%" />

{{< /div >}} {{< /div >}}

#### BERT

Anders als frühere Verfahren wie Word2Vec, bei denen jedes Wort einen festen Vektor erhält, berechnet **BERT** für jedes Vorkommen eines Wortes einen **eigenen, kontextabhängigen Vektor**. Das Modell betrachtet dabei den gesamten Satz, um die **Wortbedeutung im Zusammenhang** zu verstehen.

**Beispiel:** Das Wort „Bank" bekommt in „Ich sitze auf der Bank" eine andere Repräsentation als in „Die Bank hat heute geschlossen", weil BERT aus dem Kontext die unterschiedlichen Bedeutungen erkennt.

Möglich wird das durch die **Transformer-Architektur**, bei der alle Wörter eines Satzes gleichzeitig betrachtet und ihre Beziehungen zueinander gewichtet werden. So entstehen präzise Vektoren, die sich für anspruchsvolle Aufgaben eignen.

<!-- TODO: very basic illustration of transformers architecture? or how it respects context? -->
