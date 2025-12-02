---
title: Entitätsanalyse
subtitle: Automatisierte Identifikation und Klassifikation von Entitäten und Eigennamen
figtitle: 🏷️
date: '2024-11-25T14:25:49+01:00'
toc_show: true
draft: false
html-table-processing: none
---


## Was ist Entitätsanalyse?

Die Entitätsanalyse ist eine NLP-Methode zur automatischen Erkennung und Klassifizierung wichtiger Begriffe (z.B. Personen, Orte, Organisationen) in unstrukturierten Texten. Als Entität bezeichnet man dabei die Information, die aus dem Text extrahiert werden soll. Eine Entität stellt dabei einen Begriff dar, der in einem Text konsequent das gleiche bezeichnet. So lassen sich mittels Entitätsanalyse beispielsweise Namen von Personen, Firmennamen, Orte, Ereignisse oder Zeitangaben erkennen und extrahieren. Dafür sind zwei Schritte grundlegend: Die Identifikation von Entitäten im Text und deren Zuordnung zu vordefinierten Kategorien.

{{< div class=\"grid my-4\" >}} {{< div class=\"g-col-12\" >}}

<img src="img/ner.svg" style="width:100.0%" />

{{< /div >}} {{< /div >}}

## Anwendungen

{{< fa-ul >}}
{{< fa-solid-li icon=\"star\"  >}} **Identifikation sensibler Informationen:** Mittels Entitätsanalyse lassen sich personenbezogene Daten wie Namen oder Adressen automatisch erkennen und pseudonymisieren.
{{< /fa-solid-li >}}
{{< fa-solid-li icon=\"lightbulb\"  >}} **Wettbewerbsanalyse:** Durch das Extrahieren von Mitbewerber- oder Produktnamen lassen sich relevante Informationen für Marktanalysen gewinnen.
{{< /fa-solid-li >}}
{{< fa-solid-li icon=\"ticket-simple\" >}} **Dokumentenklassifikation:** Die Entitätsanalyse erkennt relevante Begriffe wie „Rechnung" oder „Projektbericht" und unterstützt so die automatische Kategorisierung von Dokumenten. {{< /fa-solid-li >}}
{{< /fa-ul >}}

## Ansätze zur Entitätsanalyse

<!-- TODO: Reichen die beiden Ansätze? Oder auch "machine learning" basiert (zB Spacy)? -->

Für diese Methode gibt es verschiedene Algorithmen, aus denen Unternehmen je nach Bedarf und verfügbaren Ressourcen wählen können:

### Regelbasierte Entitätsanalyse

Regelbasierte Ansätze der Entitätsanalyse nutzen vordefinierte Muster und Wörterlisten, um Entitäten wie Personen, Organisationen oder Orte im Text zu identifizieren. Dabei werden meist zwei Verfahren kombiniert: Lexikonbasierte Erkennung und musterbasierte Regeln.

<?xml version="1.0" encoding="UTF-8"?>
<div id="wtzrvyffwy" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
  <table class="gt_table" data-quarto-disable-processing="true" data-quarto-bootstrap="false" style="-webkit-font-smoothing: antialiased; -moz-osx-font-smoothing: grayscale; font-family: var(--bs-body-font-family); display: table; border-collapse: collapse; line-height: normal; margin-left: auto; margin-right: auto; color: #333333; font-size: var(--bs-body-font-size); font-weight: var(--bs-body-fontweight); font-style: normal; background-color: rgba(255, 255, 255, 0); width: 50%; border-top-style: solid; border-top-width: 2px; border-top-color: #A8A8A8; border-right-style: none; border-right-width: 2px; border-right-color: #D3D3D3; border-bottom-style: solid; border-bottom-width: 2px; border-bottom-color: #A8A8A8; border-left-style: none; border-left-width: 2px; border-left-color: #D3D3D3;" width="50%" bgcolor="rgba(255, 255, 255, 0)">
    <thead style="border-style: none;">
      <tr class="gt_col_headings" style="border-style: none; border-top-style: solid; border-top-width: 2px; border-top-color: #D3D3D3; border-bottom-style: solid; border-bottom-width: 2px; border-bottom-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3;">
        <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="Entität" style="border-style: none; color: #333333; background-color: rgba(255, 255, 255, 0); font-size: 100%; font-weight: bold; text-transform: inherit; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: bottom; padding-top: 5px; padding-bottom: 6px; padding-left: 5px; padding-right: 5px; overflow-x: hidden; text-align: left;" bgcolor="rgba(255, 255, 255, 0)" valign="bottom" align="left">Entität</th>
        <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="Beispiel" style="border-style: none; color: #333333; background-color: rgba(255, 255, 255, 0); font-size: 100%; font-weight: bold; text-transform: inherit; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: bottom; padding-top: 5px; padding-bottom: 6px; padding-left: 5px; padding-right: 5px; overflow-x: hidden; text-align: left;" bgcolor="rgba(255, 255, 255, 0)" valign="bottom" align="left">Beispiel</th>
      </tr>
    </thead>
    <tbody class="gt_table_body" style="border-style: none; border-top-style: solid; border-top-width: 2px; border-top-color: #D3D3D3; border-bottom-style: solid; border-bottom-width: 2px; border-bottom-color: #D3D3D3;">
      <tr style="border-style: none;">
        <td headers="Entität" class="gt_row gt_left" style="border-style: none; padding-top: 4px; padding-bottom: 4px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left">Organisation</td>
        <td headers="Beispiel" class="gt_row gt_left" style="border-style: none; padding-top: 4px; padding-bottom: 4px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left">JLU</td>
      </tr>
      <tr style="border-style: none;">
        <td headers="Entität" class="gt_row gt_left" style="border-style: none; padding-top: 4px; padding-bottom: 4px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left">Person</td>
        <td headers="Beispiel" class="gt_row gt_left" style="border-style: none; padding-top: 4px; padding-bottom: 4px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left">Max Mustermann</td>
      </tr>
      <tr style="border-style: none;">
        <td headers="Entität" class="gt_row gt_left" style="border-style: none; padding-top: 4px; padding-bottom: 4px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left">Ortsname</td>
        <td headers="Beispiel" class="gt_row gt_left" style="border-style: none; padding-top: 4px; padding-bottom: 4px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left">Gießen</td>
      </tr>
      <tr style="border-style: none;">
        <td headers="Entität" class="gt_row gt_left" style="border-style: none; padding-top: 4px; padding-bottom: 4px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left">Land</td>
        <td headers="Beispiel" class="gt_row gt_left" style="border-style: none; padding-top: 4px; padding-bottom: 4px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left">Deutschland</td>
      </tr>
      <tr style="border-style: none;">
        <td headers="Entität" class="gt_row gt_left" style="border-style: none; padding-top: 4px; padding-bottom: 4px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left">Datum</td>
        <td headers="Beispiel" class="gt_row gt_left" style="border-style: none; padding-top: 4px; padding-bottom: 4px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left">24.05.2024</td>
      </tr>
      <tr style="border-style: none;">
        <td headers="Entität" class="gt_row gt_left" style="border-style: none; padding-top: 4px; padding-bottom: 4px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left">Uhrzeit</td>
        <td headers="Beispiel" class="gt_row gt_left" style="border-style: none; padding-top: 4px; padding-bottom: 4px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left">13:30</td>
      </tr>
      <tr style="border-style: none;">
        <td headers="Entität" class="gt_row gt_left" style="border-style: none; padding-top: 4px; padding-bottom: 4px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left">Produkt</td>
        <td headers="Beispiel" class="gt_row gt_left" style="border-style: none; padding-top: 4px; padding-bottom: 4px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left">Laptop</td>
      </tr>
      <tr style="border-style: none;">
        <td headers="Entität" class="gt_row gt_left" style="border-style: none; padding-top: 4px; padding-bottom: 4px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left">Menge</td>
        <td headers="Beispiel" class="gt_row gt_left" style="border-style: none; padding-top: 4px; padding-bottom: 4px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left">20.000</td>
      </tr>
      <tr style="border-style: none;">
        <td headers="Entität" class="gt_row gt_left" style="border-style: none; padding-top: 4px; padding-bottom: 4px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left">Währung</td>
        <td headers="Beispiel" class="gt_row gt_left" style="border-style: none; padding-top: 4px; padding-bottom: 4px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left">Euro</td>
      </tr>
      <tr style="border-style: none;">
        <td headers="Entität" class="gt_row gt_left" style="border-style: none; padding-top: 4px; padding-bottom: 4px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left">E-Mail</td>
        <td headers="Beispiel" class="gt_row gt_left" style="border-style: none; padding-top: 4px; padding-bottom: 4px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left">mustermann@beispiel.de</td>
      </tr>
    </tbody>
  </table>
</div>

Beim lexikonbasierten Ansatz wird der Text mit einem vordefinierten Lexikon abgeglichen, also mit Listen relevanter Namen und Begriffe. Stimmen Wörter im Text mit diesen Einträgen überein, werden sie als Entität klassifiziert. Ergänzend kommen regelbasierte Methoden zum Einsatz, die sprachliche Strukturen analysieren. Diese Regeln basieren oft auf linguistischen Mustern, wie z.B. Großschreibung innerhalb eines Satzes oder typischen Formatierungen wie Datums- oder E-Mail-Strukturen.

{{< fa-ul >}}
{{< fa-solid-li icon=\"thumbs-up\" color=\"#39b185\" >}} Lässt sich unkompliziert umsetzen, selbst mit begrenzten Ressourcen oder ohne eigene Trainingsdaten. {{< /fa-solid-li >}}
{{< fa-solid-li icon=\"thumbs-up\" color=\"#39b185\" >}} Kann gezielt auf spezifische Anwendungsfälle zugeschnitten werden, etwa durch eigene Lexika oder regelbasierte Anpassungen. {{< /fa-solid-li >}}
{{< fa-solid-li icon=\"thumbs-down\" color=\"#cf597e\" >}} Erfordert kontinuierliche Pflege, da Regeln und Lexika regelmäßig aktualisiert werden müssen. {{< /fa-solid-li >}}
{{< fa-solid-li icon=\"thumbs-down\" color=\"#cf597e\" >}} Die Qualität hängt stark von der Sprache und den verwendeten Wörterbüchern ab. {{< /fa-solid-li >}}
{{< fa-solid-li icon=\"thumbs-down\" color=\"#cf597e\" >}} Sprachliche Varianten und Ausnahmen lassen sich nicht immer zuverlässig erfassen. Dadurch können Entitäten übersehen werden. {{< /fa-solid-li >}}
{{< /fa-ul >}}

### Kontextuelle Entitätsanalyse

Die Entitätsanalyse ist ein weiterer zentraler Anwendungsfall für vortrainierte Sprachmodelle, wie bereits bei der Sentimentanalyse und Themenmodellierung gezeigt. Es stehen Modelle zur Verfügung, die speziell für die Erkennung benannter Entitäten trainiert wurden. Alternativ können Unternehmen bestehende vortrainierte Modelle übernehmen und mittels Fine-Tuning gezielt an ihre individuellen Anforderungen anpassen.

Besonders empfehlenswert sind Modelle aus der BERT-Familie, da sie speziell für Klassifikationsaufgaben wie die Entitätsanalyse konzipiert wurden und kontextuelle Informationen zuverlässig verarbeiten können.

<!-- TODO: add cross refs  -->

Um den Unterschied der beiden Methoden zu verdeutlichen, zeigen wir, wie jede Methode den folgendenen Sätze klassifizieren würde:

<img src="img/context_ner.svg" style="width:100.0%" />

Der kontextuelle Ansatz berücksichtigt die Wörter um den zentralen Begriff und entscheidet so, ob es sich bei "Bank" um eine Parkbank oder ein Finanzinstitut handelt. Grundsätzlich könnte auch ein regelbasierter Ansatz die Ambiguität von "Bank" auflösen, etwa über spezifisch formulierte Regeln. Solche Regeln funktionieren in kontrollierten Szenarien, skalieren jedoch schlecht, sind anfällig für Formulierungsvarianten und erfordern kontinuierliche Wartung. Kontextuelle Verfahren lernen diese Muster aus Daten und treffen die Unterscheidung in neuen Sätzen zuverlässiger.

{{< fa-ul >}}
{{< fa-solid-li icon=\"thumbs-up\" color=\"#39b185\" >}} Analysiert die Bedeutung eines Wortes im Zusammenhang des Satzes und erkennt dadurch unterschiedliche Verwendungen. {{< /fa-solid-li >}}
{{< fa-solid-li icon=\"thumbs-up\" color=\"#39b185\" >}} Vortrainierte Modelle können durch Fine-Tuning an spezifische Domänen angepasst werden. {{< /fa-solid-li >}}
{{< fa-solid-li icon=\"thumbs-down\" color=\"#cf597e\" >}} Erfodert mehr Rechenressourcen im Vergleich zu regelbasierten Verfahren. {{< /fa-solid-li >}}
{{< fa-solid-li icon=\"thumbs-down\" color=\"#cf597e\" >}} Wenn Modelle in der Cloud laufen (z. B. über APIs), kann das problematisch sein, wenn sensible Geschäftsdaten oder Kundendaten verarbeitet werden. {{< /fa-solid-li >}}
{{< /fa-ul >}}

## Exemplarische Anwendung mit BERT

Für die folgende Demo kommt ein Sprachmodell zum Einsatz, das speziell für die **Entitätsanalyse** trainiert wurde. Es kann in deutschsprachigen Texten automatisch Personen, Orte, Organisationen oder andere wichtige Begriffe identifizieren.

### Ausprobieren

Klicken Sie auf **Zufälliger Google News Artikel**, um einen Artikel mit farblich hervorgehobenen Entitäten anzuzeigen.

<div id="loader-f049d61f" class="d-flex justify-content-center justify-content-center align-items-center" style="width: 100%; height: 4rem;">
<div class="spinner-border text-primary" role="status">
<span class="sr-only">Loading...</span>
</div>
</div>
<iframe id="iframe-f049d61f" scrolling="no" loading="lazy" style="width: 100%; height: 0;"></iframe>
<script>$(document).ready(function(){
  $('#iframe-f049d61f').attr('src', 'https://shiny.dsjlu.wirtschaft.uni-giessen.de/ner_demo/');
  $('#iframe-f049d61f').on('load', function() {
     $('#loader-f049d61f').remove();
  });
});</script>
<script>var domains = ['https://shiny.dsjlu.wirtschaft.uni-giessen.de'];
iframeResize(
  {waitForLoad: false, license: 'GPLv3', checkOrigin: domains}, 
  '#iframe-f049d61f'
);</script>
