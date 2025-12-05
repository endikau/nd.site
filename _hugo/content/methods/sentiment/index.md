---
title: Sentimentanalyse
subtitle: Automatisierte Erkennung von Stimmungen in Texten
figtitle: 🌡️
date: '2024-11-25T14:25:49+01:00'
toc_show: true
draft: false
html-table-processing: none
---


## Was ist Sentimentanalyse?

Die Sentimentanalyse, auch bekannt als Stimmungsanalyse oder Opinion Mining, ist eine Methode zur automatisierten Erkennung und Bewertung der Emotionen und Meinungen, die in Textdaten zum Ausdruck kommen. Dabei ist das Ziel die Wahrnehmung eines Textes zu quantifizieren -- also zu beurteilen, ob ein Text, wie beispielsweise eine Produktbewertung, ein Kundenfeedback oder ein Social-Media-Beitrag, positiv, negativ oder neutral ist. Dies wird üblicherweise auf einer Skala von -1 bis 1, also von sehr negativ bis sehr positiv.

## Anwendungen

{{< fa-ul >}}
{{< fa-solid-li icon=\"star\"  >}} **Markenreputation überwachen:** Behalten Sie Ihr Markenimage im Blick, indem Sie Kundenfeedback und Online-Bewertungen analysieren. {{< /fa-solid-li >}}
{{< fa-solid-li icon=\"lightbulb\"  >}} **Produktentwicklung und Innovation:** Durch die Analyse von Rezensionen und Feedback lassen sich wertvolle Einblicke in Bedürfnisse und Probleme von Kunden gewinnen, die als Basis für Produktentwicklung und Innovation dienen. {{< /fa-solid-li >}}
{{< fa-solid-li icon=\"ticket-simple\" >}} **Kundenservice verbessern:** Analysieren Sie die Stimmung in Kundenanfragen und Support-Tickets, um den Service gezielt zu optimieren. Durch die automatische Stimmungsbewertung können kritische Fälle priorisiert und schneller gelöst werden. {{< /fa-solid-li >}}
{{< /fa-ul >}}

## Methoden der Sentimentanalyse

Um die Vorteile der Sentiment-Analyse zu nutzen, gibt es zwei bewährte Ansätze: die lexikonbasierte Methode und die machine-learning-basierte Methode. Beide haben spezifische Stärken und Schwächen, die im Folgenden beleuchtet werden:

### Lexikonbasierte Sentimentanalyse

Die lexikonbasierte Sentimentanalyse ist die traditionelle Form des Verfahrens, bei der vorab definierte Wörterlisten, sogenannte Sentimentlexika, verwendet werden, um die Stimmung eines Textes zu bestimmen.

#### Funktionsweise

Diese Lexika enthalten Wörter, die mit positiven oder negativen Gefühlen assoziiert sind, oft mit einem entsprechenden Gewicht, das die Stärke des Ausdrucks angibt.

Zur Bewertung werden die Wörter des Textes mit den Einträgen des Lexikons (bspw. SentiWS oder German Polarity Clues) abgeglichen. Die aggregierten Gewichte der Wörter aus dem Lexikon geben schließlich die Gesamtstimmung des Textes wieder.

{{< div class=\"grid mb-4\" >}} {{< div class=\"g-col-12 g-col-md-8 g-start-md-3\" >}}

<img src="img/dict_senti.svg" style="width:100.0%" />

{{< /div >}} {{< /div >}}

#### Vor- und Nachteile

{{< fa-ul >}}
{{< fa-solid-li icon=\"thumbs-up\" color=\"#39b185\" >}} Die lexikonbasierte Sentimentanalyse ist aufgrund ihrer einfachen Implementierung und des geringen Bedarfs an Rechen- und Speicherkapazität besonders für kleine Unternehmen mit begrenzten Ressourcen attraktiv. {{< /fa-solid-li >}}
{{< fa-solid-li icon=\"thumbs-down\" color=\"#cf597e\" >}} Allerdings stößt sie in komplexen Szenarien schnell an ihre Grenzen, da sie Schwierigkeiten hat, den Kontext und die Mehrdeutigkeit von Wörtern korrekt zu erfassen. Eine Phrase wie „nicht schlecht" kann beispielsweise fälschlicherweise als negativ interpretiert werden, obwohl sie im Kontext positiv gemeint ist. {{< /fa-solid-li >}}
{{< /fa-ul >}}

#### Ausprobieren

<div id="loader-c944c404" class="d-flex justify-content-center justify-content-center align-items-center" style="width: 100%; height: 4rem;">
<div class="spinner-border text-primary" role="status">
<span class="sr-only">Loading...</span>
</div>
</div>
<iframe id="iframe-c944c404" scrolling="no" loading="lazy" style="width: 100%; height: 0;"></iframe>
<script>$(document).ready(function(){
  $('#iframe-c944c404').attr('src', 'https://shiny.dsjlu.wirtschaft.uni-giessen.de/senti_dict/');
  $('#iframe-c944c404').on('load', function() {
     $('#loader-c944c404').remove();
  });
});</script>
<script>var domains = ['https://shiny.dsjlu.wirtschaft.uni-giessen.de'];
iframeResize(
  {waitForLoad: false, license: 'GPLv3', checkOrigin: domains}, 
  '#iframe-c944c404'
);</script>

{{< div class=\"pb-4\" >}} {{< /div >}}

### Machine-Learning-Basierte Sentimentanalyse

Im Gegensatz zu lexikonbasierten Ansätzen bieten vortrainierte Modelle, die auf allgemeinen Sprachmodellen wie BERT (Bidirectional Encoder Representations from Transformers) basieren, eine fortschrittliche Möglichkeit zur Sentimentanalyse.

#### Funktionsweise

Diese Modelle lernen aus einer Vielzahl von Beispielen und liefern auch in unbekannten Domänen oder bei komplexen sprachlichen Strukturen, wie Sarkasmus, verlässlichere Ergebnisse. Sie sind nicht auf spezifische Lexika angewiesen und können durch Fine-Tuning flexibel an unterschiedliche Anwendungsfälle angepasst werden, was sie besonders leistungsstark und vielseitig macht.

{{< div class=\"grid mb-4\" >}} {{< div class=\"g-col-12 g-col-md-6 g-start-md-4\" >}}

<img src="img/ml_senti.svg" style="width:100.0%" />

{{< /div >}} {{< /div >}}

#### Vor- und Nachteile

{{< fa-ul >}}
{{< fa-solid-li icon=\"thumbs-up\" color=\"#39b185\" >}} Große Sprachmodelle sind besser darin, die Stimmung eines Textes im Gesamtkontext zu erfassen, anstatt sich nur auf einzelne Begriffe zu stützen. Dadurch liefern sie häufig genauere Ergebnisse. {{< /fa-solid-li >}}
{{< fa-solid-li icon=\"thumbs-down\" color=\"#cf597e\" >}} Die Anwendung dieser Methode erfordert jedoch deutlich mehr Rechenkapazität, was besonders bei großen Datenmengen zu Herausforderungen führen kann. {{< /fa-solid-li >}}
{{< /fa-ul >}}

#### Ausprobieren

<div id="loader-de8fe906" class="d-flex justify-content-center justify-content-center align-items-center" style="width: 100%; height: 4rem;">
<div class="spinner-border text-primary" role="status">
<span class="sr-only">Loading...</span>
</div>
</div>
<iframe id="iframe-de8fe906" scrolling="no" loading="lazy" style="width: 100%; height: 0;"></iframe>
<script>$(document).ready(function(){
  $('#iframe-de8fe906').attr('src', 'https://shiny.dsjlu.wirtschaft.uni-giessen.de/senti_trans/');
  $('#iframe-de8fe906').on('load', function() {
     $('#loader-de8fe906').remove();
  });
});</script>
<script>var domains = ['https://shiny.dsjlu.wirtschaft.uni-giessen.de'];
iframeResize(
  {waitForLoad: false, license: 'GPLv3', checkOrigin: domains}, 
  '#iframe-de8fe906'
);</script>
