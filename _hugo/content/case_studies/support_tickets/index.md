---
title: Analyse von Support-Tickets
subtitle: >-
  Wie maschinelles Lernen hilft, dringende Kundenanliegen frühzeitig zu
  erkennen.
figtitle: 📩
date: '2024-11-25T14:25:49+01:00'
draft: false
toc_show: true
execute:
  echo: false
  message: false
  cache: false
---


Täglich erreichen Unternehmen zahlreiche Anfragen, Beschwerden oder sonstige Mitteilungen. Um diese effizient zu verwalten, kommen Support-Systeme zum Einsatz, die Kundenanliegen strukturieren und kategorisieren. Doch selbst mit diesen Systemen vergeht oftmals wertvolle Zeit, bis dringende Kundenanliegen an die richtige Stelle gelangen, mit längeren Ausfallzeiten und sinkender Kundenzufriedenheit als mögliche Folgen.

In diesem Fallbeispiel zeigen wir, wie sich Methoden der Textanalyse und des maschinellen Lernens nutzen lassen, um Support-Tickets automatisiert nach ihrer Dringlichkeit zu klassifizieren. Ziel ist es, besonders wichtige Anfragen frühzeitig zu erkennen und die Kundenzufriedenheit gezielt zu steigern.

Dabei konzentrieren wir uns bewusst vor allem auf textbasierte Variablen, um zu demonstrieren, dass bereits auf dieser Basis leistungsfähige Klassifikationsmodelle entwickelt werden können.

### Laden des Datensatzes

Der Datensatz umfasst 8.867 deutschsprachige Support-Tickets eines Unternehmens. Dabei enthält jede Beobachtung strukturierte Informationen über, Betreff, Nachrichtentext der Kundenanfrage, Fachbereich (z.B. IT-Support) und der Dringlichkeitsstufe des Tickets (kategorisiert als "gering" oder "hoch").

Diese Datenstruktur ermöglicht es, sowohl den Inhalt der Anfragen als auch deren Priorisierung zu analysieren. Für die nachfolgende Textanalyse mittels Machine Learning-Verfahren werden die Textdaten zunächst in ein maschinenlesbares Format transformieren. Dieser Prozess, wird im nächsten Abschnitt detailliert erläutert.

<div id="nd-3c69ffa0ed2fee42a29a4c58aa03a449555eb256" class="glide nd-glide">
<div class="glide__controls card d-flex flex-row align-middle mb-2" data-glide-el="controls">
<button data-glide-dir="&lt;" class="glide__btn-left btn text-primary">
<i class="fa-solid fa-angles-left"></i>
</button>
<div class="flex-fill text-center px-2 d-flex align-items-center justify-content-center">Beispielbeobachtungen aus dem Rohdatensatz</div>
<button data-glide-dir="&gt;" class="glide__btn-right btn text-primary">
<i class="fa-solid fa-angles-right"></i>
</button>
</div>
<div class="glide__track py-1" data-glide-el="track">
<div class="glide__slides">
<div class="glide__slide">
<div class="card" style="width: 100%;">
<ul class="list-group list-group-flush">
<li class="list-group-item">
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical;">
<code>Betreff:</code>
Aktueller Bericht enthält ungenaue Angaben
</div>
</li>
<li class="list-group-item">
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical;">
<code>Nachricht:</code>
Bitte melden Sie, dass der kürzlich erstellte Bericht zur Investitionsoptimierung Ungenauigkeiten aufweist, möglicherweise aufgrund veralteter Datenquellen. Versuche, die Datensätze zu aktualisieren, waren erfolglos. Wir schätzen Ihre Unterstützung bei der Lösung des Problems, um die Genauigkeit zukünftiger Berichte sicherzustellen. Teilen Sie bitte die nächsten Schritte mit, um die Situation zu beheben. Wir freuen uns auf Ihre Rückmeldung.
</div>
</li>
<li class="list-group-item">
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical;">
<code>Bereich:</code>
Rückgaben und Umtausch
</div>
</li>
<li class="list-group-item">
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical;">
<code>Sprache:</code>
de
</div>
</li>
<li class="list-group-item">
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical;">
<code>Dringlichkeit:</code>
hoch
</div>
</li>
</ul>
</div>
</div>
<div class="glide__slide">
<div class="card" style="width: 100%;">
<ul class="list-group list-group-flush">
<li class="list-group-item">
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical;">
<code>Betreff:</code>
Sofortige Implementierung neuer Online-Datenanalysefunktionen erforderlich
</div>
</li>
<li class="list-group-item">
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical;">
<code>Nachricht:</code>
Sehr geehrtes Kundensupport-Team, ich möchte die Einführung neuer Datenanalysefunktionen beantragen, um die Optimierung unserer Investitionsstrategien zu verbessern, ohne die bestehenden Produkte zu beeinträchtigen. Diese dringende Anfrage ist notwendig, da unsere aktuellen Analysefähigkeiten veraltet sind und die Fähigkeit, fundierte Investitionsentscheidungen zu treffen, erheblich einschränken. Die neuen Funktionen sollten Echtzeit-Datenüberwachung, prädiktive Modellierung und anpassbare Dashboards umfassen. Es ist wesentlich, dass diese Funktionen nahtlos in die bestehenden Systeme integriert werden, um Unterbrechungen im Geschäftsbetrieb zu vermeiden. Ich würde es begrüßen, wenn Sie den Zeitplan für die Umsetzung dieser Funktionen mitteilen könnten. Für weitere Informationen stehe ich gerne zur Verfügung.
</div>
</li>
<li class="list-group-item">
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical;">
<code>Bereich:</code>
Produktsupport
</div>
</li>
<li class="list-group-item">
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical;">
<code>Sprache:</code>
de
</div>
</li>
<li class="list-group-item">
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical;">
<code>Dringlichkeit:</code>
gering
</div>
</li>
</ul>
</div>
</div>
<div class="glide__slide">
<div class="card" style="width: 100%;">
<ul class="list-group list-group-flush">
<li class="list-group-item">
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical;">
<code>Betreff:</code>
Sicherheitswarnung für das Gesundheitsprovider-System
</div>
</li>
<li class="list-group-item">
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical;">
<code>Nachricht:</code>
Bitte berichtigen Sie den Fehler.
</div>
</li>
<li class="list-group-item">
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical;">
<code>Bereich:</code>
Technischer Support
</div>
</li>
<li class="list-group-item">
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical;">
<code>Sprache:</code>
de
</div>
</li>
<li class="list-group-item">
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical;">
<code>Dringlichkeit:</code>
hoch
</div>
</li>
</ul>
</div>
</div>
<div class="glide__slide">
<div class="card" style="width: 100%;">
<ul class="list-group list-group-flush">
<li class="list-group-item">
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical;">
<code>Betreff:</code>
Fehler im Datenanalyse-System gemeldet
</div>
</li>
<li class="list-group-item">
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical;">
<code>Nachricht:</code>
Das System funktioniert korrekt.
</div>
</li>
<li class="list-group-item">
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical;">
<code>Bereich:</code>
IT-Support
</div>
</li>
<li class="list-group-item">
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical;">
<code>Sprache:</code>
de
</div>
</li>
<li class="list-group-item">
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical;">
<code>Dringlichkeit:</code>
hoch
</div>
</li>
</ul>
</div>
</div>
<div class="glide__slide">
<div class="card" style="width: 100%;">
<ul class="list-group list-group-flush">
<li class="list-group-item">
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical;">
<code>Betreff:</code>
Problem mit der Daten-Synchronisation
</div>
</li>
<li class="list-group-item">
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical;">
<code>Nachricht:</code>
Erfahrungen mit Datenverzögerungen und Analyseproblemen bei Anlagen, verursacht durch Synchronisationsprobleme zwischen SQL Server und MySQL.
</div>
</li>
<li class="list-group-item">
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical;">
<code>Bereich:</code>
IT-Support
</div>
</li>
<li class="list-group-item">
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical;">
<code>Sprache:</code>
de
</div>
</li>
<li class="list-group-item">
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical;">
<code>Dringlichkeit:</code>
hoch
</div>
</li>
</ul>
</div>
</div>
<div class="glide__slide">
<div class="card" style="width: 100%;">
<ul class="list-group list-group-flush">
<li class="list-group-item">
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical;">
<code>Betreff:</code>
Bericht über Datensicherheitsunfall
</div>
</li>
<li class="list-group-item">
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical;">
<code>Nachricht:</code>
Es wurde ein Datensicherheitsunfall gemeldet, bei dem unautorisierte Zugriff auf medizinische Daten stattgefunden hat. Dies scheint auf möglicherweise fehlerhafte Firewall-Einstellungen zurückzuführen sein. Das Team hat bereits dringende Maßnahmen ergriffen, um die Zugriffssteuerungen zu verschärfen und die Benutzerrechte zu überprüfen, um zukünftige Vorfälle zu vermeiden. Wir arbeiten intensiv daran, den Unfall zu beseitigen und die Sicherheit unserer Systeme zu gewährleisten. Wir bedanken uns für Ihre Aufmerksamkeit bezüglich dieses Problems und freuen uns auf Ihre Unterstützung bei der Lösung der Angelegenheit.
</div>
</li>
<li class="list-group-item">
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical;">
<code>Bereich:</code>
Technischer Support
</div>
</li>
<li class="list-group-item">
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical;">
<code>Sprache:</code>
de
</div>
</li>
<li class="list-group-item">
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical;">
<code>Dringlichkeit:</code>
hoch
</div>
</li>
</ul>
</div>
</div>
<div class="glide__slide">
<div class="card" style="width: 100%;">
<ul class="list-group list-group-flush">
<li class="list-group-item">
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical;">
<code>Betreff:</code>
Update der Server-Konfiguration
</div>
</li>
<li class="list-group-item">
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical;">
<code>Nachricht:</code>
Betreff: Antrag auf Aktualisierung der Server-Konfiguration\n\nSehr geehrte Kundenservice,\n\nich möchte Sie auf die Notwendigkeit hinweisen, unsere Server-Konfiguration zu aktualisieren, um die Leistung während Spitzenzeiten zu verbessern. Derzeitige Server-Setup-Parameter führen zu verlangsamen Loadzeiten und beeinträchtigen die Benutzererfahrung. Es wäre ratsam, die Serverressourcen zu erhöhen, um hohe Verkehrspeaken zu verkraften. Vorschläge für die Aktualisierung sind RAM und CPU zu aktualisieren sowie mehr Server in einen Clustergesamtzusammenhang hinzuzufügen. Ich schätze, dass die Aktualisierung die bestehenden Dienste beeinflussen könnte. Bitte geben Sie bekannt, sobald die nächsten Schritte bestimmt wurden.\n\nMit freundlichen Grüßen
</div>
</li>
<li class="list-group-item">
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical;">
<code>Bereich:</code>
Wartung und Störungen
</div>
</li>
<li class="list-group-item">
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical;">
<code>Sprache:</code>
de
</div>
</li>
<li class="list-group-item">
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical;">
<code>Dringlichkeit:</code>
gering
</div>
</li>
</ul>
</div>
</div>
<div class="glide__slide">
<div class="card" style="width: 100%;">
<ul class="list-group list-group-flush">
<li class="list-group-item">
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical;">
<code>Betreff:</code>
Fehlerhafte Abonnement-Rechnung
</div>
</li>
<li class="list-group-item">
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical;">
<code>Nachricht:</code>
Habe eine falsche Rechnung erhalten, die aufgrund eines Rechnungsstellungsfehlers entstanden ist. Versuche, die Gebühren zu korrigieren, und habe Support kontaktiert. Erwartet, dass bald eine korrigierte Rechnung bereitgestellt wird.
</div>
</li>
<li class="list-group-item">
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical;">
<code>Bereich:</code>
Abrechnung und Zahlungen
</div>
</li>
<li class="list-group-item">
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical;">
<code>Sprache:</code>
de
</div>
</li>
<li class="list-group-item">
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical;">
<code>Dringlichkeit:</code>
hoch
</div>
</li>
</ul>
</div>
</div>
<div class="glide__slide">
<div class="card" style="width: 100%;">
<ul class="list-group list-group-flush">
<li class="list-group-item">
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical;">
<code>Betreff:</code>
Unterstützung bei Plattformstörungen
</div>
</li>
<li class="list-group-item">
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical;">
<code>Nachricht:</code>
Die kürzlichen Störungen auf der Plattform unserer digitalen Strategien Marketingagentur haben mehrere Produkte betroffen und behindern das Markenwachstum. Die Probleme scheinen auf eine fehlerhafte Integration oder Konfiguration zurückzuführen zu sein. Unsere Versuche, das Problem durch Neustart der Geräte und Software-Updates zu beheben, waren erfolglos. Wir haben die Systemprotokolle geprüft und Rücksprache mit dem Entwicklungsteam gehalten, konnten die Ursache jedoch noch nicht eindeutig bestimmen. Wir schätzen Ihre Unterstützung und Hinweise, um das Problem zu lösen und die Plattform wieder in den Normalzustand zu versetzen. Bitte um Ihre Unterstützung.
</div>
</li>
<li class="list-group-item">
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical;">
<code>Bereich:</code>
Technischer Support
</div>
</li>
<li class="list-group-item">
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical;">
<code>Sprache:</code>
de
</div>
</li>
<li class="list-group-item">
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical;">
<code>Dringlichkeit:</code>
hoch
</div>
</li>
</ul>
</div>
</div>
<div class="glide__slide">
<div class="card" style="width: 100%;">
<ul class="list-group list-group-flush">
<li class="list-group-item">
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical;">
<code>Betreff:</code>
Probleme bei dem Krankenhaus-IT-System
</div>
</li>
<li class="list-group-item">
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical;">
<code>Nachricht:</code>
Es wurde eine potenzielle Datensicherheitslücke in dem Krankenhaus-IT-System entdeckt, die durch unautorisierter Zugriff entstanden ist.
</div>
</li>
<li class="list-group-item">
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical;">
<code>Bereich:</code>
IT-Support
</div>
</li>
<li class="list-group-item">
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical;">
<code>Sprache:</code>
de
</div>
</li>
<li class="list-group-item">
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical;">
<code>Dringlichkeit:</code>
hoch
</div>
</li>
</ul>
</div>
</div>
</div>
</div>
</div>
<script>document.addEventListener('DOMContentLoaded', function () {
  new Glide('#nd-3c69ffa0ed2fee42a29a4c58aa03a449555eb256', {
    type: 'carousel',
    perView: 2,
    gap: 24,
    autoplay: 5000,
    breakpoints: {
      576: { perView: 1 }
    }
  }).mount();
})</script>

### Vorverarbeitung

Bevor der Text für weitere Analysen genutzt werden kann, muss er, wie in den {{< crossref path=\"/basics#textdaten-für-analysen-vorbereiten\" label=\"Grundlagen\" >}} beschrieben, in ein geeignetes Format überführt werden.

Dazu entfernen wir unter anderem sogenannte **Stoppwörter**, also sehr häufige Wörter ohne inhaltliche Aussagekraft. Zusätzlich bereinigen wir die Texte um wiederkehrende Formulierungen wie „Sehr geehrtes Support-Team" oder „Sehr geehrter Kundenservice", da auch diese keinen Mehrwert für die inhaltliche Analyse bieten.

Anschließend wird der Text **tokenisiert**, also in einzelne Wörter zerlegt. Dies ist ein grundlegender Schritt, um unstrukturierte Sprache in eine **strukturierte Form** zu bringen, die sich systematisch analysieren lässt, etwa durch das Zählen oder Vergleichen sprachlicher Einheiten, wie Wörtern.

<div class="d-flex flex-column justify-content-center pb-2">
<div class="card p-1" style="background-color: #e9ebe5;">
<p class="py-1 px-2" style="text-indent: 0;">Sehr geehrtes Support-Team,</p>
<p class="py-1 px-2" style="text-indent: 0;">ich möchte einen gravierenden Sicherheitsvorfall melden, der gegenwärtig mehrere Komponenten unserer Infrastruktur betrifft.</p>
</div>
<i class="fa-solid fa-arrow-down my-2"></i>
<div class="d-flex flex-wrap gap-1 mb-0 pb-0">
<span class="token">sehr</span>
<span class="token">geehrtes</span>
<span class="token">support</span>
<span class="token">team</span>
<span class="token">ich</span>
<span class="token">möchte</span>
<span class="token">einen</span>
<span class="token">gravierenden</span>
<span class="token">sicherheitsvorfall</span>
<span class="token">melden</span>
<span class="token">der</span>
<span class="token">gegenwärtig</span>
<span class="token">mehrere</span>
<span class="token">komponenten</span>
<span class="token">unserer</span>
<span class="token">infrastruktur</span>
<span class="token">betrifft</span>
</div>
<style>.token {
  padding: .15rem .4rem;
  margin: .08rem .16rem .08rem 0;
  font-weight: 500;
  font-size: var(--bs-body-font-size);
  font-weight: var(--bs-body-font-weight);
  color: var(--bs-body-color);
  background: #e9ebe5;
  background-clip: border-box;
  border: var(--bs-border-width) solid #cdcfca;
  border-radius: var(--bs-border-radius);
}</style>
<i class="fa-solid fa-arrow-down my-2"></i>
<div class="d-flex flex-wrap gap-1 mb-0 pb-0">
<span class="token">möchte</span>
<span class="token">gravierenden</span>
<span class="token">sicherheitsvorfall</span>
<span class="token">melden</span>
<span class="token">gegenwärtig</span>
<span class="token">mehrere</span>
<span class="token">komponenten</span>
<span class="token">unserer</span>
<span class="token">infrastruktur</span>
<span class="token">betrifft</span>
</div>
<style>.token {
  padding: .15rem .4rem;
  margin: .08rem .16rem .08rem 0;
  font-weight: 500;
  font-size: var(--bs-body-font-size);
  font-weight: var(--bs-body-font-weight);
  color: var(--bs-body-color);
  background: #e9ebe5;
  background-clip: border-box;
  border: var(--bs-border-width) solid #cdcfca;
  border-radius: var(--bs-border-radius);
}</style>
</div>

### Analyse

#### Worthäufigkeiten

Bevor wir mit der Modellierung beginnen, schauen wir uns den Datensatz etwas genauer an, um ein besseres Verständnis für die enthaltenen Texte zu gewinnen. Insbesondere bei textbasierten Daten bietet es sich an, zunächst **Worthäufigkeiten** zu betrachten, um zentrale Begriffe und mögliche Muster zu erkennen.

Die zehn häufigsten Begriffe im Datensatz deuten darauf hin, dass der Kundenservice vor allem bei technischen Problemen oder Fragen zur Software kontaktiert wird.

<img src="index.markdown_strict_files/figure-markdown_strict/unnamed-chunk-8-1.svg" style="width:100.0%" />

Allerdings wird hiermit noch nicht deutlich, welche Begriffe dringendere Nachrichten darstellen. Dazu betrachten wir in der nächsten Abbildung die häufigsten Begriffe nach Dringlichkeit.

<img src="index.markdown_strict_files/figure-markdown_strict/unnamed-chunk-10-1.svg" style="width:100.0%" />

Es lassen sich klare inhaltliche Unterschiede zwischen den Klassen erkennen:

{{< fa-ul >}}
{{< fa-solid-li icon=\"comment-dots\" >}} In weniger dringlichen Nachrichten (links) stehen eher allgemeine oder informative Begriffe im Vordergrund, wie z.B. „informationen", „freue", „integration" oder „unterstützung". Diese Anfragen deuten auf Interesse, Verbesserungsvorschläge oder Rückfragen hin.{{< /fa-solid-li >}}

{{< fa-solid-li icon=\"triangle-exclamation\" >}} In hoch dringlichen Nachrichten (rechts) dominieren dagegen Begriffe wie „problem", „software", „beheben", „lösung" oder „ursache". Diese Begriffe weisen auf technische Schwierigkeiten oder akute Störungen hin, die eine schnelle Reaktion erfordern.{{< /fa-solid-li >}}
{{< /fa-ul >}}

#### Charakteristische Begriffe pro Klasse (TF-IDF)

Neben der Betrachtung der häufigsten Begriffe ist es oft noch aufschlussreicher, charakteristische Wörter pro Klasse zu identifizieren. Die {{< crossref path=\"/basics#tf-idf\" label=\"TF-IDF-Methode\" >}} hebt dabei Begriffe hervor, die besonders typisch für eine Klasse sind, aber in anderen weniger häufig vorkommen. So lassen sich sprachliche Muster erkennen, die beim automatisierten Erkennen der Dringlichkeit besonders hilfreich sind. Die folgende Grafik zeigt die jeweils 10 prägnantesten Begriffe pro Klasse.

<img src="index.markdown_strict_files/figure-markdown_strict/unnamed-chunk-12-1.svg" style="width:100.0%" />

#### Textbasierte Merkmalsextraktion

Um die Dringlichkeit von Nachrichten automatisch einschätzen zu können, müssen aus dem Text sinnvolle **Merkmale** gewonnen werden. Dabei helfen sprachliche Hinweise wie **Ausrufezeichen**, **Fragen** oder die **durchschnittliche Wortlänge**. Solche Merkmale lassen sich mit sogenannten **Regular Expressions** erkennen. Das sind spezielle Suchmuster, mit denen bestimmte Zeichenfolgen im Text gezielt gefunden und gezählt werden können, etwa Ausrufezeichen oder Fragewörter.

Diese Merkmalsextraktion bildet die **Grundlage für das Klassifikationsmodell**: Je präziser die relevanten Muster erkannt werden, desto besser kann das System dringende Anliegen priorisieren und schnell an die richtige Stelle leiten.

<?xml version="1.0" encoding="UTF-8"?>
<div id="sqhonnzqar" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
  <table class="gt_table" data-quarto-disable-processing="true" data-quarto-bootstrap="false" style="-webkit-font-smoothing: antialiased; -moz-osx-font-smoothing: grayscale; font-family: var(--bs-body-font-family); display: table; border-collapse: collapse; line-height: normal; margin-left: auto; margin-right: auto; color: #333333; font-size: var(--bs-body-font-size); font-weight: var(--bs-body-fontweight); font-style: normal; background-color: rgba(255, 255, 255, 0); width: 100%; border-top-style: solid; border-top-width: 2px; border-top-color: #A8A8A8; border-right-style: none; border-right-width: 2px; border-right-color: #D3D3D3; border-bottom-style: solid; border-bottom-width: 2px; border-bottom-color: #A8A8A8; border-left-style: none; border-left-width: 2px; border-left-color: #D3D3D3;" width="100%" bgcolor="rgba(255, 255, 255, 0)">
    <caption>Vergleich sprachlicher Merkmale nach Dringlichkeit</caption>
    <thead style="border-style: none;">
      <tr class="gt_col_headings gt_spanner_row" style="border-style: none; border-top-style: solid; border-top-width: 2px; border-top-color: #D3D3D3; border-bottom-width: 2px; border-bottom-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; border-bottom-style: hidden;">
        <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id="a::stub" style="border-style: none; color: #333333; background-color: rgba(255, 255, 255, 0); font-size: 100%; font-weight: bold; text-transform: inherit; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: bottom; padding-top: 5px; padding-bottom: 6px; padding-left: 5px; padding-right: 5px; overflow-x: hidden; text-align: left;" bgcolor="rgba(255, 255, 255, 0)" valign="bottom" align="left"/>
        <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup" id="Dringlichkeit" style="border-style: none; color: #333333; background-color: rgba(255, 255, 255, 0); font-size: 100%; font-weight: bold; text-transform: inherit; padding-top: 0; padding-bottom: 0; padding-left: 4px; text-align: center; padding-right: 0;" bgcolor="rgba(255, 255, 255, 0)" align="center">
          <div class="gt_column_spanner" style="border-bottom-style: solid; border-bottom-width: 2px; border-bottom-color: #D3D3D3; vertical-align: bottom; padding-top: 5px; padding-bottom: 5px; overflow-x: hidden; display: inline-block; width: 100%;">Dringlichkeit</div>
        </th>
      </tr>
      <tr class="gt_col_headings" style="border-style: none; border-top-style: solid; border-top-width: 2px; border-top-color: #D3D3D3; border-bottom-style: solid; border-bottom-width: 2px; border-bottom-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3;">
        <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="gering" style="border-style: none; color: #333333; background-color: rgba(255, 255, 255, 0); font-size: 100%; font-weight: bold; text-transform: inherit; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: bottom; padding-top: 5px; padding-bottom: 6px; padding-left: 5px; padding-right: 5px; overflow-x: hidden; text-align: right; font-variant-numeric: tabular-nums;" bgcolor="rgba(255, 255, 255, 0)" valign="bottom" align="right">gering</th>
        <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="hoch" style="border-style: none; color: #333333; background-color: rgba(255, 255, 255, 0); font-size: 100%; font-weight: bold; text-transform: inherit; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: bottom; padding-top: 5px; padding-bottom: 6px; padding-left: 5px; padding-right: 5px; overflow-x: hidden; text-align: right; font-variant-numeric: tabular-nums;" bgcolor="rgba(255, 255, 255, 0)" valign="bottom" align="right">hoch</th>
      </tr>
    </thead>
    <tbody class="gt_table_body" style="border-style: none; border-top-style: solid; border-top-width: 2px; border-top-color: #D3D3D3; border-bottom-style: solid; border-bottom-width: 2px; border-bottom-color: #D3D3D3;">
      <tr style="border-style: none;">
        <th id="stub_1_1" scope="row" class="gt_row gt_left gt_stub" style="border-style: none; padding-top: 8px; padding-bottom: 8px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; color: #333333; background-color: rgba(255, 255, 255, 0); font-size: 100%; font-weight: initial; text-transform: inherit; border-right-style: solid; border-right-width: 2px; border-right-color: #D3D3D3; padding-left: 5px; padding-right: 5px; text-align: left;" valign="middle" bgcolor="rgba(255, 255, 255, 0)" align="left">Ø Zeichenanzahl</th>
        <td headers="stub_1_1 gering" class="gt_row gt_right" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: right; font-variant-numeric: tabular-nums;" valign="middle" align="right">331.74 </td>
        <td headers="stub_1_1 hoch" class="gt_row gt_right" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: right; font-variant-numeric: tabular-nums;" valign="middle" align="right">324.75 </td>
      </tr>
      <tr style="border-style: none;">
        <th id="stub_1_2" scope="row" class="gt_row gt_left gt_stub" style="border-style: none; padding-top: 8px; padding-bottom: 8px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; color: #333333; background-color: rgba(255, 255, 255, 0); font-size: 100%; font-weight: initial; text-transform: inherit; border-right-style: solid; border-right-width: 2px; border-right-color: #D3D3D3; padding-left: 5px; padding-right: 5px; text-align: left;" valign="middle" bgcolor="rgba(255, 255, 255, 0)" align="left">Ø Wortanzahl</th>
        <td headers="stub_1_2 gering" class="gt_row gt_right" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: right; font-variant-numeric: tabular-nums;" valign="middle" align="right"> 58.02 </td>
        <td headers="stub_1_2 hoch" class="gt_row gt_right" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: right; font-variant-numeric: tabular-nums;" valign="middle" align="right"> 54.86 </td>
      </tr>
      <tr style="border-style: none;">
        <th id="stub_1_3" scope="row" class="gt_row gt_left gt_stub" style="border-style: none; padding-top: 8px; padding-bottom: 8px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; color: #333333; background-color: rgba(255, 255, 255, 0); font-size: 100%; font-weight: initial; text-transform: inherit; border-right-style: solid; border-right-width: 2px; border-right-color: #D3D3D3; padding-left: 5px; padding-right: 5px; text-align: left;" valign="middle" bgcolor="rgba(255, 255, 255, 0)" align="left">Ø Wortlänge</th>
        <td headers="stub_1_3 gering" class="gt_row gt_right" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: right; font-variant-numeric: tabular-nums;" valign="middle" align="right">  6.82 </td>
        <td headers="stub_1_3 hoch" class="gt_row gt_right" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: right; font-variant-numeric: tabular-nums;" valign="middle" align="right">  7.03 </td>
      </tr>
      <tr style="border-style: none;">
        <th id="stub_1_4" scope="row" class="gt_row gt_left gt_stub" style="border-style: none; padding-top: 8px; padding-bottom: 8px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; color: #333333; background-color: rgba(255, 255, 255, 0); font-size: 100%; font-weight: initial; text-transform: inherit; border-right-style: solid; border-right-width: 2px; border-right-color: #D3D3D3; padding-left: 5px; padding-right: 5px; text-align: left;" valign="middle" bgcolor="rgba(255, 255, 255, 0)" align="left">Ø Ausrufezeichen</th>
        <td headers="stub_1_4 gering" class="gt_row gt_right" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: right; font-variant-numeric: tabular-nums;" valign="middle" align="right">  0.02 </td>
        <td headers="stub_1_4 hoch" class="gt_row gt_right" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: right; font-variant-numeric: tabular-nums;" valign="middle" align="right">  0.00 </td>
      </tr>
      <tr style="border-style: none;">
        <th id="stub_1_5" scope="row" class="gt_row gt_left gt_stub" style="border-style: none; padding-top: 8px; padding-bottom: 8px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; color: #333333; background-color: rgba(255, 255, 255, 0); font-size: 100%; font-weight: initial; text-transform: inherit; border-right-style: solid; border-right-width: 2px; border-right-color: #D3D3D3; padding-left: 5px; padding-right: 5px; text-align: left;" valign="middle" bgcolor="rgba(255, 255, 255, 0)" align="left">Fragenanteil</th>
        <td headers="stub_1_5 gering" class="gt_row gt_right" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: right; font-variant-numeric: tabular-nums;" valign="middle" align="right"> 39.50%</td>
        <td headers="stub_1_5 hoch" class="gt_row gt_right" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: right; font-variant-numeric: tabular-nums;" valign="middle" align="right"> 92.29%</td>
      </tr>
      <tr style="border-style: none;">
        <th id="stub_1_6" scope="row" class="gt_row gt_left gt_stub" style="border-style: none; padding-top: 8px; padding-bottom: 8px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; color: #333333; background-color: rgba(255, 255, 255, 0); font-size: 100%; font-weight: initial; text-transform: inherit; border-right-style: solid; border-right-width: 2px; border-right-color: #D3D3D3; padding-left: 5px; padding-right: 5px; text-align: left;" valign="middle" bgcolor="rgba(255, 255, 255, 0)" align="left">Betreff vorhanden</th>
        <td headers="stub_1_6 gering" class="gt_row gt_right" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: right; font-variant-numeric: tabular-nums;" valign="middle" align="right"> 13.20%</td>
        <td headers="stub_1_6 hoch" class="gt_row gt_right" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: right; font-variant-numeric: tabular-nums;" valign="middle" align="right"> 13.19%</td>
      </tr>
    </tbody>
  </table>
</div>

Ein Vergleich sprachlicher Merkmale zeigt deutliche Unterschiede zwischen dringenden und weniger dringenden Nachrichten. Besonders auffällig ist der Fragenanteil: Während nur etwa 39% der weniger dringenden Nachrichten eine Frage enthalten, liegt dieser Anteil bei dringenden Nachrichten bei über 92%. Auch die durchschnittliche Wortlänge ist bei dringenden Anliegen leicht erhöht.

Andere Merkmale wie Zeichen- und Wortanzahl oder der Einsatz von Ausrufezeichen unterscheiden sich dagegen kaum, und der Anteil an Nachrichten mit Betreff ist nahezu identisch. Diese Erkenntnisse sind für das Klassifikationsmodell entscheidend: Ein hoher Fragenanteil in Kombination mit leicht komplexerer Sprache, erkennbar an der höheren Wortlänge, kann als starker Indikator für Dringlichkeit genutzt werden.

#### Sentimentanalyse

Ein weiteres Merkmal, das für die Modellierung interessant sein könnte, ist die **sprachliche Stimmung (Sentiment):** Ist der Ton der Nachricht eher positiv oder negativ? Dazu führen wir eine einfache **lexikonbasierte Sentimentanalyse** durch. Dabei wird jeder Nachricht ein Wert zugewiesen, der die Summe der positiven und negativen Begriffe widerspiegelt.

<img src="index.markdown_strict_files/figure-markdown_strict/unnamed-chunk-15-1.svg" style="width:100.0%" />

Mit einem Anteil von 55.4% sind die Nachrichten überwiegend sprachlich negativ geladen. Es zeigt sich auch, dass die Nachrichten eher positiv oder negativ sind, denn nur rund 3% der Nachrichten sind sprachlich neutral. Das deutet darauf hin, dass Support-Nachrichten oft emotional aufgeladen sind.

Ein Blick auf den durchschnittlichen Sentimentwert für dringende und weniger dringende Nachrichten zeigt bedeutungsvolle Unterschiede:

<img src="index.markdown_strict_files/figure-markdown_strict/unnamed-chunk-16-1.svg" style="width:100.0%" />

Hoch dringliche Nachrichten enthalten häufiger negativ formulierte Texte, etwa bei Problemen oder Störungen. Weniger dringliche Anfragen sind oft neutral oder positiv, z.B. bei allgemeinen Rückfragen oder Wünschen. Die Stimmung im Text kann also ein guter Hinweis auf die Dringlichkeit sein.

### Klassifikation

Unser finaler Datensatz besteht aus einigen Merkmalen, die nun für das trainieren eines Modelles genutzt werden können, um damit zukünftige Nachrichten anhand des Textes in "dringend" oder "weniger dringend" zu klassifizieren.

<?xml version="1.0" encoding="UTF-8"?>
<div id="rtjjuiswwr" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
  <table class="gt_table" data-quarto-disable-processing="true" data-quarto-bootstrap="false" style="-webkit-font-smoothing: antialiased; -moz-osx-font-smoothing: grayscale; font-family: var(--bs-body-font-family); display: table; border-collapse: collapse; line-height: normal; margin-left: auto; margin-right: auto; color: #333333; font-size: var(--bs-body-font-size); font-weight: var(--bs-body-fontweight); font-style: normal; background-color: rgba(255, 255, 255, 0); width: 100%; border-top-style: solid; border-top-width: 2px; border-top-color: #A8A8A8; border-right-style: none; border-right-width: 2px; border-right-color: #D3D3D3; border-bottom-style: solid; border-bottom-width: 2px; border-bottom-color: #A8A8A8; border-left-style: none; border-left-width: 2px; border-left-color: #D3D3D3;" width="100%" bgcolor="rgba(255, 255, 255, 0)">
    <caption>Variablenbeschreibung des Modell-Datensatzes</caption>
    <thead style="border-style: none;">
      <tr class="gt_col_headings" style="border-style: none; border-top-style: solid; border-top-width: 2px; border-top-color: #D3D3D3; border-bottom-style: solid; border-bottom-width: 2px; border-bottom-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3;">
        <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="Variable" style="border-style: none; color: #333333; background-color: rgba(255, 255, 255, 0); font-size: 100%; font-weight: bold; text-transform: inherit; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: bottom; padding-top: 5px; padding-bottom: 6px; padding-left: 5px; padding-right: 5px; overflow-x: hidden; text-align: left;" bgcolor="rgba(255, 255, 255, 0)" valign="bottom" align="left">Variable</th>
        <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="Typ" style="border-style: none; color: #333333; background-color: rgba(255, 255, 255, 0); font-size: 100%; font-weight: bold; text-transform: inherit; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: bottom; padding-top: 5px; padding-bottom: 6px; padding-left: 5px; padding-right: 5px; overflow-x: hidden; text-align: left;" bgcolor="rgba(255, 255, 255, 0)" valign="bottom" align="left">Datentyp</th>
        <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="Beispiel" style="border-style: none; color: #333333; background-color: rgba(255, 255, 255, 0); font-size: 100%; font-weight: bold; text-transform: inherit; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: bottom; padding-top: 5px; padding-bottom: 6px; padding-left: 5px; padding-right: 5px; overflow-x: hidden; text-align: left;" bgcolor="rgba(255, 255, 255, 0)" valign="bottom" align="left">Beispielwert</th>
      </tr>
    </thead>
    <tbody class="gt_table_body" style="border-style: none; border-top-style: solid; border-top-width: 2px; border-top-color: #D3D3D3; border-bottom-style: solid; border-bottom-width: 2px; border-bottom-color: #D3D3D3;">
      <tr style="border-style: none;">
        <td headers="Variable" class="gt_row gt_left" style="border-style: none; padding-top: 4px; padding-bottom: 4px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left">Dringlichkeit</td>
        <td headers="Typ" class="gt_row gt_left" style="border-style: none; padding-top: 4px; padding-bottom: 4px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left">factor</td>
        <td headers="Beispiel" class="gt_row gt_left" style="border-style: none; padding-top: 4px; padding-bottom: 4px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left">hoch</td>
      </tr>
      <tr style="border-style: none;">
        <td headers="Variable" class="gt_row gt_left" style="border-style: none; padding-top: 4px; padding-bottom: 4px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left">Nachricht</td>
        <td headers="Typ" class="gt_row gt_left" style="border-style: none; padding-top: 4px; padding-bottom: 4px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left">character</td>
        <td headers="Beispiel" class="gt_row gt_left" style="border-style: none; padding-top: 4px; padding-bottom: 4px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left">möchte gravierenden sicherheitsvorfall melden gegenwärtig mehrere komponenten unserer infrastruktur betrifft betroffene geräte umfassen projektoren bildschirme speicherlösungen cloud plattformen grund annahme vorfall potenzielle datenverletzung zusammenhang cyberattacke darstellt erhebliches risiko sensible informationen laufenden geschäftsbetrieb unserer organisation bedeutet initialen untersuchungen ungewöhnliche aktivitäten abweichungen geräten ergeben trotz umsetzung unserer standardisierten behebungs eindämmungsmaßnahmen konnte bedrohung bislang vollständig eliminiert</td>
      </tr>
      <tr style="border-style: none;">
        <td headers="Variable" class="gt_row gt_left" style="border-style: none; padding-top: 4px; padding-bottom: 4px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left">Bereich</td>
        <td headers="Typ" class="gt_row gt_left" style="border-style: none; padding-top: 4px; padding-bottom: 4px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left">factor</td>
        <td headers="Beispiel" class="gt_row gt_left" style="border-style: none; padding-top: 4px; padding-bottom: 4px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left">Technischer Support</td>
      </tr>
      <tr style="border-style: none;">
        <td headers="Variable" class="gt_row gt_left" style="border-style: none; padding-top: 4px; padding-bottom: 4px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left">Sentimentwert</td>
        <td headers="Typ" class="gt_row gt_left" style="border-style: none; padding-top: 4px; padding-bottom: 4px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left">numeric</td>
        <td headers="Beispiel" class="gt_row gt_left" style="border-style: none; padding-top: 4px; padding-bottom: 4px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left">-0.575</td>
      </tr>
      <tr style="border-style: none;">
        <td headers="Variable" class="gt_row gt_left" style="border-style: none; padding-top: 4px; padding-bottom: 4px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left">Wortanzahl</td>
        <td headers="Typ" class="gt_row gt_left" style="border-style: none; padding-top: 4px; padding-bottom: 4px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left">integer</td>
        <td headers="Beispiel" class="gt_row gt_left" style="border-style: none; padding-top: 4px; padding-bottom: 4px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left">88</td>
      </tr>
      <tr style="border-style: none;">
        <td headers="Variable" class="gt_row gt_left" style="border-style: none; padding-top: 4px; padding-bottom: 4px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left">Wortlänge</td>
        <td headers="Typ" class="gt_row gt_left" style="border-style: none; padding-top: 4px; padding-bottom: 4px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left">numeric</td>
        <td headers="Beispiel" class="gt_row gt_left" style="border-style: none; padding-top: 4px; padding-bottom: 4px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left">7.42045454545455</td>
      </tr>
      <tr style="border-style: none;">
        <td headers="Variable" class="gt_row gt_left" style="border-style: none; padding-top: 4px; padding-bottom: 4px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left">Frage</td>
        <td headers="Typ" class="gt_row gt_left" style="border-style: none; padding-top: 4px; padding-bottom: 4px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left">factor</td>
        <td headers="Beispiel" class="gt_row gt_left" style="border-style: none; padding-top: 4px; padding-bottom: 4px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left">FALSE</td>
      </tr>
      <tr style="border-style: none;">
        <td headers="Variable" class="gt_row gt_left" style="border-style: none; padding-top: 4px; padding-bottom: 4px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left">Betreff vorhanden</td>
        <td headers="Typ" class="gt_row gt_left" style="border-style: none; padding-top: 4px; padding-bottom: 4px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left">factor</td>
        <td headers="Beispiel" class="gt_row gt_left" style="border-style: none; padding-top: 4px; padding-bottom: 4px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left">TRUE</td>
      </tr>
      <tr style="border-style: none;">
        <td headers="Variable" class="gt_row gt_left" style="border-style: none; padding-top: 4px; padding-bottom: 4px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left">Zeichenanzahl</td>
        <td headers="Typ" class="gt_row gt_left" style="border-style: none; padding-top: 4px; padding-bottom: 4px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left">integer</td>
        <td headers="Beispiel" class="gt_row gt_left" style="border-style: none; padding-top: 4px; padding-bottom: 4px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left">579</td>
      </tr>
      <tr style="border-style: none;">
        <td headers="Variable" class="gt_row gt_left" style="border-style: none; padding-top: 4px; padding-bottom: 4px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left">Anzahl Ausrufezeichen</td>
        <td headers="Typ" class="gt_row gt_left" style="border-style: none; padding-top: 4px; padding-bottom: 4px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left">integer</td>
        <td headers="Beispiel" class="gt_row gt_left" style="border-style: none; padding-top: 4px; padding-bottom: 4px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left">0</td>
      </tr>
    </tbody>
  </table>
</div>

Um herauszufinden, ob eine Nachricht dringend ist oder nicht, wurde ein **maschinelles Lernmodell (Random Forest)** trainiert. Dabei wurden nicht nur der Inhalt der Nachricht, sondern auch sprachliche Merkmale wie Wortlänge, Anzahl an Ausrufezeichen, das Sentiment oder das Vorhandensein eines Betreffs berücksichtigt.

Das Modell wurde mit 75% der Daten trainiert und auf den verbleibenden 25% getestet. Die folgenden Schritte kamen dabei zum Einsatz:

{{< fa-ul >}}
{{< fa-solid-li icon=\"broom\" >}} **Textvorverarbeitung:** Die Nachrichten wurden in einzelne Wörter zerlegt, Stoppwörter entfernt und sogenannte TF-IDF-Werte berechnet.{{< /fa-solid-li >}}

{{< fa-solid-li icon=\"wrench\" >}} **Merkmalsgenerierung:** Wir haben verschiedene Merkmale extrahiert -- darunter Sentimentwerte, Satzzeichenanzahl, Wortlänge oder auch das Vorhandensein eines Betreffs.{{< /fa-solid-li >}}

{{< fa-solid-li icon=\"network-wired\" >}} **Klassifikation:** Anschließend wurde ein Random-Forest-Modell trainiert, das Nachrichten automatisch in hohe oder geringe Dringlichkeit einordnet.{{< /fa-solid-li >}}

{{< fa-solid-li icon=\"chart-line\" >}} **Modellbewertung:** Um die Qualität des Modells zu beurteilen, wurden die Genauigkeit des Modells berechnet und anhand einer Konfusionsmatrix visualisiert. {{< /fa-solid-li >}}
{{< /fa-ul >}}

<?xml version="1.0" encoding="UTF-8"?>
<div id="rlluxdtwje" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
  <table class="gt_table" data-quarto-disable-processing="true" data-quarto-bootstrap="false" style="-webkit-font-smoothing: antialiased; -moz-osx-font-smoothing: grayscale; font-family: var(--bs-body-font-family); display: table; border-collapse: collapse; line-height: normal; margin-left: auto; margin-right: auto; color: #333333; font-size: var(--bs-body-font-size); font-weight: var(--bs-body-fontweight); font-style: normal; background-color: rgba(255, 255, 255, 0); width: 60%; border-top-style: solid; border-top-width: 2px; border-top-color: #A8A8A8; border-right-style: none; border-right-width: 2px; border-right-color: #D3D3D3; border-bottom-style: solid; border-bottom-width: 2px; border-bottom-color: #A8A8A8; border-left-style: none; border-left-width: 2px; border-left-color: #D3D3D3;" width="60%" bgcolor="rgba(255, 255, 255, 0)">
    <caption>Bewertung des Klassifikationsmodells</caption>
    <thead style="border-style: none;">
      <tr class="gt_col_headings" style="border-style: none; border-top-style: solid; border-top-width: 2px; border-top-color: #D3D3D3; border-bottom-style: solid; border-bottom-width: 2px; border-bottom-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3;">
        <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="a.metric" style="border-style: none; color: #333333; background-color: rgba(255, 255, 255, 0); font-size: 100%; font-weight: bold; text-transform: inherit; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: bottom; padding-top: 5px; padding-bottom: 6px; padding-left: 5px; padding-right: 5px; overflow-x: hidden; text-align: left;" bgcolor="rgba(255, 255, 255, 0)" valign="bottom" align="left">Metrik</th>
        <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="a.estimate" style="border-style: none; color: #333333; background-color: rgba(255, 255, 255, 0); font-size: 100%; font-weight: bold; text-transform: inherit; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: bottom; padding-top: 5px; padding-bottom: 6px; padding-left: 5px; padding-right: 5px; overflow-x: hidden; text-align: right; font-variant-numeric: tabular-nums;" bgcolor="rgba(255, 255, 255, 0)" valign="bottom" align="right">Wert</th>
      </tr>
    </thead>
    <tbody class="gt_table_body" style="border-style: none; border-top-style: solid; border-top-width: 2px; border-top-color: #D3D3D3; border-bottom-style: solid; border-bottom-width: 2px; border-bottom-color: #D3D3D3;">
      <tr style="border-style: none;">
        <td headers=".metric" class="gt_row gt_left" style="border-style: none; padding-top: 4px; padding-bottom: 4px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left">Genauigkeit</td>
        <td headers=".estimate" class="gt_row gt_right" style="border-style: none; padding-top: 4px; padding-bottom: 4px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: right; font-variant-numeric: tabular-nums;" valign="middle" align="right">97.9%</td>
      </tr>
    </tbody>
  </table>
</div>

Das trainierte Klassifikationsmodell erzielt eine Genauigkeit von 97,9% auf den Testdaten. Dies bedeutet, dass nahezu alle Nachrichten korrekt als "hoch" oder "gering" dringlich eingestuft wurden.

Die Konfusionsmatrix visualisiert diese Leistung im Detail:

{{< fa-ul >}}
{{< fa-solid-li icon=\"thumbs-up\" >}}Das Modell erkennt den Großteil der Nachrichten korrekt: 1254 hoch dringliche und 916 gering dringliche Anfragen wurden richtig klassifiziert.{{< /fa-solid-li >}}

{{< fa-solid-li icon=\"thumbs-down\" >}}Fehlklassifikationen traten nur in 23 Fällen pro Klasse auf.{{< /fa-solid-li >}}
{{< /fa-ul >}}

<img src="index.markdown_strict_files/figure-markdown_strict/unnamed-chunk-19-1.svg" style="width:100.0%" />

Damit das Modell im Alltag akzeptiert wird, ist es wichtig, seine **Entscheidungsgrundlagen transparent und nachvollziehbar darzustellen**. Wenn Mitarbeitende erkennen können, warum ein Ticket als dringend eingestuft wurde, könnte die Bereitschaft steigen, die Empfehlungen des Systems als sinnvolle Unterstützung zu nutzen.

Um diese Transparenz zu schaffen, haben wir die **zentralen Textmerkmale** aus dem Random-Forest-Modell extrahiert und direkt in den Originalnachrichten hervorgehoben.

<div id="nd-04007031e41a31bc4765305abf2aeb9ed1626fd2" class="glide nd-glide">
<div class="glide__controls card d-flex flex-row align-middle mb-2" data-glide-el="controls">
<button data-glide-dir="&lt;" class="glide__btn-left btn text-primary">
<i class="fa-solid fa-angles-left"></i>
</button>
<div class="flex-fill text-center px-2 d-flex align-items-center justify-content-center">Dringlichkeits-Hinweise des Klassifikationsmodells</div>
<button data-glide-dir="&gt;" class="glide__btn-right btn text-primary">
<i class="fa-solid fa-angles-right"></i>
</button>
</div>
<div class="glide__track py-1" data-glide-el="track">
<div class="glide__slides">
<div class="glide__slide">
<div class="card" style="width: 100%;">
<ul class="list-group list-group-flush">
<li class="list-group-item">
<code>Betreff: </code>
Sicherheit von medizinischen Daten
</li>
<li class="list-group-item">
<code>Bereich: </code>
Technischer Support
</li>
<li class="list-group-item">
<code>Dringlichkeit: </code>
<span class="badge" style="background-color:#39b185;">gering</span>
</li>
<li class="list-group-item">
<code>Legende: </code>
<div>
<span>Legende: </span>
<span style="font-weight:600;">Fett</span>
 = RF-Signal (wichtiges Token); 
<span style="color:#cf597e;">Rot</span>
 = negatives Sentiment; 
<span style="font-weight:600;color:#cf597e;">Fett + Rot</span>
 = beides
</div>
</li>
<li class="list-group-item">
<code>Nachricht:</code>
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical; font-size: 0.95rem;"><b>Könnten</b> Sie <b>Details</b> zur Sicherung <b>medizinischer</b> Daten für unsere Hub Smart-Thermometer Produkte <b>bereitstellen</b>? Wir danken Ihnen im <b>Voraus</b>.</div>
</li>
</ul>
</div>
</div>
<div class="glide__slide">
<div class="card" style="width: 100%;">
<ul class="list-group list-group-flush">
<li class="list-group-item">
<code>Betreff: </code>
Plötzliche Ausfälle mehrerer Integrationen heute
</li>
<li class="list-group-item">
<code>Bereich: </code>
Kundenservice
</li>
<li class="list-group-item">
<code>Dringlichkeit: </code>
<span class="badge" style="background-color:#cf597e;">hoch</span>
</li>
<li class="list-group-item">
<code>Legende: </code>
<div>
<span>Legende: </span>
<span style="font-weight:600;">Fett</span>
 = RF-Signal (wichtiges Token); 
<span style="color:#cf597e;">Rot</span>
 = negatives Sentiment; 
<span style="font-weight:600;color:#cf597e;">Fett + Rot</span>
 = beides
</div>
</li>
<li class="list-group-item">
<code>Nachricht:</code>
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical; font-size: 0.95rem;"><b><span style='color:#cf597e'>Problem</span></b>: Zahlreiche Produktintegrationen sind heute <span style='color:#cf597e'>unerwartet</span> <span style='color:#cf597e'>ausgefallen</span>, was zu systemweiten <span style='color:#cf597e'>Störungen</span> führt. <b>Möglicherweise</b> liegt dies an Inkompatibilitäten nach kürzlichen Software-<b>Updates</b>. Es <b>wurden</b> <b>Versuche</b> <b>unternommen</b>, die Dienste <b>neu</b> zu <b>starten</b> und ein Rollback durchzuführen, <b>jedoch</b> ohne Erfolg. Das <b><span style='color:#cf597e'>Problem</span></b> <b>besteht</b> <b>weiterhin</b>, und wir <b>benötigen</b> <b>dringend</b> Unterstützung, um eine <b>Lösung</b> zu finden.</div>
</li>
</ul>
</div>
</div>
<div class="glide__slide">
<div class="card" style="width: 100%;">
<ul class="list-group list-group-flush">
<li class="list-group-item">
<code>Betreff: </code>
Probleme mit der Software-Kompatibilität
</li>
<li class="list-group-item">
<code>Bereich: </code>
IT-Support
</li>
<li class="list-group-item">
<code>Dringlichkeit: </code>
<span class="badge" style="background-color:#cf597e;">hoch</span>
</li>
<li class="list-group-item">
<code>Legende: </code>
<div>
<span>Legende: </span>
<span style="font-weight:600;">Fett</span>
 = RF-Signal (wichtiges Token); 
<span style="color:#cf597e;">Rot</span>
 = negatives Sentiment; 
<span style="font-weight:600;color:#cf597e;">Fett + Rot</span>
 = beides
</div>
</li>
<li class="list-group-item">
<code>Nachricht:</code>
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical; font-size: 0.95rem;">Die Marketing-Agentur <b>erlebt</b> <b><span style='color:#cf597e'>Probleme</span></b> mit der Software-Kompatibilität. Es <b>scheint</b>, dass die letzten Systemänderungen und <b>Updates</b> die <b>Ursache</b> sein <b>könnten</b>. <b>Versuche</b>, Geräte <b>neu</b> zu <b>starten</b> und <b>Anwendungen</b> zu reinstallieren, haben das <b><span style='color:#cf597e'>Problem</span></b> nicht <b>gelöst</b>.</div>
</li>
</ul>
</div>
</div>
<div class="glide__slide">
<div class="card" style="width: 100%;">
<ul class="list-group list-group-flush">
<li class="list-group-item">
<code>Betreff: </code>
Hilfe beim Einbinden von Projektmanagementfunktionen in verschiedene Softwareprodukte
</li>
<li class="list-group-item">
<code>Bereich: </code>
Produktsupport
</li>
<li class="list-group-item">
<code>Dringlichkeit: </code>
<span class="badge" style="background-color:#cf597e;">hoch</span>
</li>
<li class="list-group-item">
<code>Legende: </code>
<div>
<span>Legende: </span>
<span style="font-weight:600;">Fett</span>
 = RF-Signal (wichtiges Token); 
<span style="color:#cf597e;">Rot</span>
 = negatives Sentiment; 
<span style="font-weight:600;color:#cf597e;">Fett + Rot</span>
 = beides
</div>
</li>
<li class="list-group-item">
<code>Nachricht:</code>
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical; font-size: 0.95rem;">Ich habe <b><span style='color:#cf597e'>Probleme</span></b>, verschiedene Softwareprodukte für die Projektmanagementfunktionen einzubinden. Es <b>scheint</b>, dass Kompatibilitätskonflikte die <b>Ursache</b> sind. Ich habe <b>bereits</b> <b>versucht</b>, das <b><span style='color:#cf597e'>Problem</span></b> durch die bereitgestellte Dokumentation und das Support-Forum zu klären, aber <b><span style='color:#cf597e'>leider</span></b> ohne Erfolg. Ich würde mich <b>freuen</b>, wenn Sie mir irgendeine Hilfe oder <b>Anleitung</b> <b>geben</b> <b>könnten</b>, um die <span style='color:#cf597e'>Herausforderung</span> zu unterstützen.</div>
</li>
</ul>
</div>
</div>
<div class="glide__slide">
<div class="card" style="width: 100%;">
<ul class="list-group list-group-flush">
<li class="list-group-item">
<code>Betreff: </code>
(ohne Betreff)
</li>
<li class="list-group-item">
<code>Bereich: </code>
Kundenservice
</li>
<li class="list-group-item">
<code>Dringlichkeit: </code>
<span class="badge" style="background-color:#cf597e;">hoch</span>
</li>
<li class="list-group-item">
<code>Legende: </code>
<div>
<span>Legende: </span>
<span style="font-weight:600;">Fett</span>
 = RF-Signal (wichtiges Token); 
<span style="color:#cf597e;">Rot</span>
 = negatives Sentiment; 
<span style="font-weight:600;color:#cf597e;">Fett + Rot</span>
 = beides
</div>
</li>
<li class="list-group-item">
<code>Nachricht:</code>
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical; font-size: 0.95rem;">Sehr <b>geehrte</b> Kundenservice-Team, Ich <b>schreibe</b> an, da ein <span style='color:#cf597e'>kritisches</span> <b><span style='color:#cf597e'>Problem</span></b> mit unserem Datenanalyse-Tool aufgetreten ist. Das Tool versagt und führt zu <span style='color:#cf597e'>ungenauen</span> Investitionsoptimierungsresultaten. <b>Trotz</b> der <b>Bemühungen</b> der Teammitglieder, das Softwareprogramm <b>neu</b> zu installieren und die Daten zu validieren, <b>besteht</b> das <b><span style='color:#cf597e'>Problem</span></b> <b>weiterhin</b>. Mögliche <b>Ursachen</b> <b>könnten</b> Softwarefehler oder Datenschnittstellungsprobleme sein. Wir haben <b>versucht</b>, das <b><span style='color:#cf597e'>Problem</span></b> zu <b>beheben</b>, <b><span style='color:#cf597e'>leider</span></b> <b>konnten</b> wir es <b>jedoch</b> nicht <b>lösen</b>. Ich <b>freue</b> mich, wenn wir das <b><span style='color:#cf597e'>Problem</span></b> schnell <span style='color:#cf597e'>auseinandersetzen</span> und eine <b>Lösung</b> besprechen können. <b>Bitte</b> helfen Sie uns dabei, die <span style='color:#cf597e'>ungenauen</span> Ergebnisse zu <b>beheben</b>.</div>
</li>
</ul>
</div>
</div>
<div class="glide__slide">
<div class="card" style="width: 100%;">
<ul class="list-group list-group-flush">
<li class="list-group-item">
<code>Betreff: </code>
Probleme bei der Integrationsfunktion auf MacBook
</li>
<li class="list-group-item">
<code>Bereich: </code>
Technischer Support
</li>
<li class="list-group-item">
<code>Dringlichkeit: </code>
<span class="badge" style="background-color:#cf597e;">hoch</span>
</li>
<li class="list-group-item">
<code>Legende: </code>
<div>
<span>Legende: </span>
<span style="font-weight:600;">Fett</span>
 = RF-Signal (wichtiges Token); 
<span style="color:#cf597e;">Rot</span>
 = negatives Sentiment; 
<span style="font-weight:600;color:#cf597e;">Fett + Rot</span>
 = beides
</div>
</li>
<li class="list-group-item">
<code>Nachricht:</code>
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical; font-size: 0.95rem;">Bewerbte Kundensupport, ich habe <b><span style='color:#cf597e'>Schwierigkeiten</span></b> mit der Integrationsfunktion verschiedener Plattformen (Adobe Sign, ActiveCampaign, Airtable) auf meinem Apple MacBook Air. Die <b><span style='color:#cf597e'>Probleme</span></b> <b>könnten</b> Kompatibilitätskonflikte mit neueren Software-<b>Updates</b> <b>verursacht</b> haben. Ich habe <b>bereits</b> <b>versucht</b>, mein Gerät <b>neu</b> zu <b>starten</b>, die betroffenen <b>Anwendungen</b> zu <span style='color:#cf597e'>deinstallieren</span> und <b>neu</b> zu installieren, aber das <b><span style='color:#cf597e'>Problem</span></b> <b>behält</b> seinen Bestand. Ich schätze es, wenn Sie einen Lösungsansatz schnell zur <b>Verfügung</b> <b>stellen</b> <b>könnten</b>. <b>Bitte</b> lassen Sie mich wissen, wenn Sie <b>weitere</b> <b>Informationen</b> <b>benötigen</b>. <b>Vielen</b> <b>Dank</b>.</div>
</li>
</ul>
</div>
</div>
<div class="glide__slide">
<div class="card" style="width: 100%;">
<ul class="list-group list-group-flush">
<li class="list-group-item">
<code>Betreff: </code>
Fachlicher Hilfeanfrage
</li>
<li class="list-group-item">
<code>Bereich: </code>
Produktsupport
</li>
<li class="list-group-item">
<code>Dringlichkeit: </code>
<span class="badge" style="background-color:#cf597e;">hoch</span>
</li>
<li class="list-group-item">
<code>Legende: </code>
<div>
<span>Legende: </span>
<span style="font-weight:600;">Fett</span>
 = RF-Signal (wichtiges Token); 
<span style="color:#cf597e;">Rot</span>
 = negatives Sentiment; 
<span style="font-weight:600;color:#cf597e;">Fett + Rot</span>
 = beides
</div>
</li>
<li class="list-group-item">
<code>Nachricht:</code>
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical; font-size: 0.95rem;">Es gibt Verbindungsprobleme mit der Software QNAP TS-453D (NAS). Es könnte sein, dass die neuesten Softwareupdates oder Änderungen der Netzwerkkonfiguration die Kommunikation mit verbundenen Peripheriegeräten beeinflusst haben. Nachdem die NAS <b>neu</b> <b>gestartet</b>, das <b>Cache</b> geleert und die Netzwerkeinstellungen <b>überprüft</b> <b>wurden</b>, <b>wurde</b> das <b><span style='color:#cf597e'>Problem</span></b> nicht <b>gelöst</b>. Ich schätze eine <b>weitere</b> <b>Anleitung</b> zur <b>Lösung</b> dieses <b><span style='color:#cf597e'>Problems</span></b>.</div>
</li>
</ul>
</div>
</div>
<div class="glide__slide">
<div class="card" style="width: 100%;">
<ul class="list-group list-group-flush">
<li class="list-group-item">
<code>Betreff: </code>
Update des Abrechnungssystems
</li>
<li class="list-group-item">
<code>Bereich: </code>
Abrechnung und Zahlungen
</li>
<li class="list-group-item">
<code>Dringlichkeit: </code>
<span class="badge" style="background-color:#39b185;">gering</span>
</li>
<li class="list-group-item">
<code>Legende: </code>
<div>
<span>Legende: </span>
<span style="font-weight:600;">Fett</span>
 = RF-Signal (wichtiges Token); 
<span style="color:#cf597e;">Rot</span>
 = negatives Sentiment; 
<span style="font-weight:600;color:#cf597e;">Fett + Rot</span>
 = beides
</div>
</li>
<li class="list-group-item">
<code>Nachricht:</code>
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical; font-size: 0.95rem;">Sehr geehrter Kundenservice, ich <b>möchte</b> die Aktualisierung des Abrechnungssystems beantragen, um die Unterstützung für verschiedene Zahlungsmethoden bei betroffenen Produkten zu gewährleisten. Es ist wichtig, Sicherheits- und Funktionsverbesserungen mit hoher Priorität umzusetzen. Das derzeitige <b>System</b> ist <span style='color:#cf597e'>veraltet</span> und benötigt ein Upgrade. Wir hoffen auf eine zügige Bearbeitung unseres Anliegens und danken im <b>Voraus</b> für Ihre Unterstützung. Wir <b>freuen</b> uns auf eine <b>baldige</b> <b>Rückmeldung</b>.</div>
</li>
</ul>
</div>
</div>
<div class="glide__slide">
<div class="card" style="width: 100%;">
<ul class="list-group list-group-flush">
<li class="list-group-item">
<code>Betreff: </code>
Data Analysis Inquiry
</li>
<li class="list-group-item">
<code>Bereich: </code>
Kundenservice
</li>
<li class="list-group-item">
<code>Dringlichkeit: </code>
<span class="badge" style="background-color:#39b185;">gering</span>
</li>
<li class="list-group-item">
<code>Legende: </code>
<div>
<span>Legende: </span>
<span style="font-weight:600;">Fett</span>
 = RF-Signal (wichtiges Token); 
<span style="color:#cf597e;">Rot</span>
 = negatives Sentiment; 
<span style="font-weight:600;color:#cf597e;">Fett + Rot</span>
 = beides
</div>
</li>
<li class="list-group-item">
<code>Nachricht:</code>
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical; font-size: 0.95rem;">Sehr geehrter Kundenservice, ich <b>möchte</b> mich <b>erkundigen</b>, ob Sie Lösungen im Bereich Datenanalyse zur <b>Optimierung</b> von Anlagestrategien anbieten. Können Sie <b>detaillierte</b> <b>Informationen</b> zu den <b>verfügbaren</b> <b>Tools</b> und <b>Dienstleistungen</b> <b>bereitstellen</b>? <b>Besonders</b> <b>interessiert</b> mich, wie Ihre Lösungen dabei helfen können, fundierte Entscheidungen zu <b>treffen</b> und das Anlageportfolio zu <b>verbessern</b>. Ich <b>möchte</b> <b>mehr</b> über die Arten der Daten <b>erfahren</b>, die analysiert werden, <b>sowie</b> über die verwendeten Methoden und Analyseverfahren, um daraus Erkenntnisse zu gewinnen. Zudem schätze ich <b>Informationen</b> zu Ihrem Implementierungsprozess, den Preisen <b>sowie</b> Fallstudien und Kundenreferenzen. Ich suche nach...</div>
</li>
</ul>
</div>
</div>
<div class="glide__slide">
<div class="card" style="width: 100%;">
<ul class="list-group list-group-flush">
<li class="list-group-item">
<code>Betreff: </code>
(ohne Betreff)
</li>
<li class="list-group-item">
<code>Bereich: </code>
Kundenservice
</li>
<li class="list-group-item">
<code>Dringlichkeit: </code>
<span class="badge" style="background-color:#39b185;">gering</span>
</li>
<li class="list-group-item">
<code>Legende: </code>
<div>
<span>Legende: </span>
<span style="font-weight:600;">Fett</span>
 = RF-Signal (wichtiges Token); 
<span style="color:#cf597e;">Rot</span>
 = negatives Sentiment; 
<span style="font-weight:600;color:#cf597e;">Fett + Rot</span>
 = beides
</div>
</li>
<li class="list-group-item">
<code>Nachricht:</code>
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical; font-size: 0.95rem;"><b>geehrte</b> Kundensupport, ich <b>schreibe</b>, um <b>mehr</b> <b>Informationen</b> zu <b>erhalten</b> über die Skalierbarkeitsfunktionen und Preismodelle für Projekte mit erhöhtem Traffic. <b>Könnten</b> Sie mir <b>mehr</b> <b>Details</b> <b>geben</b>, wie die Nutzung des Projekts auf erhöhten Traffic reagiert und welche Funktionen die verschiedenen Preismodelle beinhalten? Zudem <b>wäre</b> es hilfreich, wenn Sie mir <b>detaillierte</b> <b>Dokumentationen</b> und <b>Ressourcen</b> zur <b>Verfügung</b> <b>stellen</b> <b>könnten</b>. <b>Vielen</b> <b>Dank</b> für Ihre Unterstützung und ich <b>freue</b> mich auf Ihre <b>baldige</b> <b>Rückmeldung</b>.</div>
</li>
</ul>
</div>
</div>
<div class="glide__slide">
<div class="card" style="width: 100%;">
<ul class="list-group list-group-flush">
<li class="list-group-item">
<code>Betreff: </code>
(ohne Betreff)
</li>
<li class="list-group-item">
<code>Bereich: </code>
Produktsupport
</li>
<li class="list-group-item">
<code>Dringlichkeit: </code>
<span class="badge" style="background-color:#cf597e;">hoch</span>
</li>
<li class="list-group-item">
<code>Legende: </code>
<div>
<span>Legende: </span>
<span style="font-weight:600;">Fett</span>
 = RF-Signal (wichtiges Token); 
<span style="color:#cf597e;">Rot</span>
 = negatives Sentiment; 
<span style="font-weight:600;color:#cf597e;">Fett + Rot</span>
 = beides
</div>
</li>
<li class="list-group-item">
<code>Nachricht:</code>
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical; font-size: 0.95rem;">Sehr geehrter Kundenservice, ich <b>möchte</b> ein <b><span style='color:#cf597e'>Problem</span></b> <b>melden</b>, das den Zugriff auf gesicherte medizinische Daten des Gesundheitsdienstleisters betrifft. Nach einem kürzlichen Software-Update hat das Team Login-<b><span style='color:#cf597e'>Probleme</span></b> im <b>System</b> <b>erlebt</b>, wodurch der Zugriff auf wichtige Patientendaten verhindert wird. <b>Trotz</b> Versuchen, die <b>Passwörter</b> zurückzusetzen und die Systeme <b>neu</b> zu <b>starten</b>, <b>besteht</b> das <b><span style='color:#cf597e'>Problem</span></b> <b>weiterhin</b>. Ich <b>bitte</b> um freundliche Unterstützung, um eine schnelle <b>Lösung</b> zu finden und <span style='color:#cf597e'>Störungen</span> unserer Dienste zu minimieren. <b>Bitte</b> informieren Sie mich, falls <b>weitere</b> Schritte erforderlich sind oder Sie zusätzliche <b>Informationen</b> <b>benötigen</b>. <b>Vielen</b> <b>Dank</b> im <b>Voraus</b>.</div>
</li>
</ul>
</div>
</div>
<div class="glide__slide">
<div class="card" style="width: 100%;">
<ul class="list-group list-group-flush">
<li class="list-group-item">
<code>Betreff: </code>
Verbesserungen der Sicherheit bei medizinischem Datenschutz
</li>
<li class="list-group-item">
<code>Bereich: </code>
IT-Support
</li>
<li class="list-group-item">
<code>Dringlichkeit: </code>
<span class="badge" style="background-color:#39b185;">gering</span>
</li>
<li class="list-group-item">
<code>Legende: </code>
<div>
<span>Legende: </span>
<span style="font-weight:600;">Fett</span>
 = RF-Signal (wichtiges Token); 
<span style="color:#cf597e;">Rot</span>
 = negatives Sentiment; 
<span style="font-weight:600;color:#cf597e;">Fett + Rot</span>
 = beides
</div>
</li>
<li class="list-group-item">
<code>Nachricht:</code>
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical; font-size: 0.95rem;">Lieber Kundensupport, ich <b>möchte</b> nachfragen, ob Sie über die Implementierung von Sicherheitsverbesserungen im <b>Schutz</b> <b>medizinischer</b> Daten in IT-Systemen und verwandten Softwareprodukten in Kliniken informiert sind. Da der <b>Schutz</b> sensibler <b>medizinischer</b> <b>Informationen</b> von größter Bedeutung ist, <b>glaube</b> ich, dass es notwendig ist, die erforderlichen Maßnahmen zu ergreifen, um Datenbrände und <span style='color:#cf597e'>unbefugten</span> Zugriff zu verhindern. Ich würde mich <b>freuen</b>, <b>Informationen</b> zu den aktuellen Sicherheitsprotokollen <b>sowie</b> zu den zukünftigen Verbesserungen zu <b>erhalten</b>. <b>Insbesondere</b> <b>interessiert</b> mich die Verwendung von Verschlüsselungsmethoden, Zugriffskontrollen und Notfallplänen. Ich schätze eine <b>Anleitung</b> oder Empfehlung sehr. <b>Vielen</b> <b>Dank</b> für Ihre Beachtung.</div>
</li>
</ul>
</div>
</div>
<div class="glide__slide">
<div class="card" style="width: 100%;">
<ul class="list-group list-group-flush">
<li class="list-group-item">
<code>Betreff: </code>
Eingereichte Vorfallmeldung
</li>
<li class="list-group-item">
<code>Bereich: </code>
Technischer Support
</li>
<li class="list-group-item">
<code>Dringlichkeit: </code>
<span class="badge" style="background-color:#cf597e;">hoch</span>
</li>
<li class="list-group-item">
<code>Legende: </code>
<div>
<span>Legende: </span>
<span style="font-weight:600;">Fett</span>
 = RF-Signal (wichtiges Token); 
<span style="color:#cf597e;">Rot</span>
 = negatives Sentiment; 
<span style="font-weight:600;color:#cf597e;">Fett + Rot</span>
 = beides
</div>
</li>
<li class="list-group-item">
<code>Nachricht:</code>
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical; font-size: 0.95rem;">Das Krankenhaus hat einen unautorisierten Zugriff auf seine IT-Systeme <b>festgestellt</b>, was <b>möglicherweise</b> mit einem Phishing-<span style='color:#cf597e'>Angriff</span> in Verbindung steht. Die initialen Maßnahmen <b>umfassten</b> die Aktualisierung der <b>Firewall</b>-Regeln <b>sowie</b> die Durchführung von Antivirus-Scans. Für eine genauere Analyse und um die Quelle des <span style='color:#cf597e'>Verstoßes</span> zu ermitteln <b>sowie</b> die vollständige <b>Integrität</b> unserer Systeme sicherzustellen, ist eine weitergehende <b>Untersuchung</b> notwendig. Wir nehmen den Vorfall ernst und werden Sie über <b>weitere</b> Entwicklungen informieren, sobald zusätzliche <b>Informationen</b> vorliegen.</div>
</li>
</ul>
</div>
</div>
<div class="glide__slide">
<div class="card" style="width: 100%;">
<ul class="list-group list-group-flush">
<li class="list-group-item">
<code>Betreff: </code>
Vollständiges Scheitern der Digitalen Strategien
</li>
<li class="list-group-item">
<code>Bereich: </code>
Personalabteilung
</li>
<li class="list-group-item">
<code>Dringlichkeit: </code>
<span class="badge" style="background-color:#cf597e;">hoch</span>
</li>
<li class="list-group-item">
<code>Legende: </code>
<div>
<span>Legende: </span>
<span style="font-weight:600;">Fett</span>
 = RF-Signal (wichtiges Token); 
<span style="color:#cf597e;">Rot</span>
 = negatives Sentiment; 
<span style="font-weight:600;color:#cf597e;">Fett + Rot</span>
 = beides
</div>
</li>
<li class="list-group-item">
<code>Nachricht:</code>
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical; font-size: 0.95rem;">Die digitalen Marketingstrategien einer Agentur <b>konnten</b> das Marktwachstum nicht vorantreiben, <b>möglicherweise</b> <b>aufgrund</b> einer ineffektiven Ansprache der Zielgruppe. Die <b>Versuche</b> <b>umfassten</b> Kampagnenanpassungen, doch die Ergebnisse blieben unverändert. <b>Obwohl</b> die Online-Präsenz der Marke verbessert <b>wurde</b>, sind die Engagement-Raten <b>weiterhin</b> <span style='color:#cf597e'>niedrig</span>. Es ist unerlässlich, den Zielgruppenansatz <b>neu</b> zu bewerten und alternative <b>Strategien</b> in Betracht zu ziehen, um die gewünschte Zielgruppe zu erreichen. Eine <b>detaillierte</b> Analyse der Kampagnenleistung <b>sowie</b> eine Überarbeitung des Aktionsplans sind notwendig, um die angestrebten Ziele zu erreichen und die digitale Präsenz der Marke zu stärken.</div>
</li>
</ul>
</div>
</div>
<div class="glide__slide">
<div class="card" style="width: 100%;">
<ul class="list-group list-group-flush">
<li class="list-group-item">
<code>Betreff: </code>
(ohne Betreff)
</li>
<li class="list-group-item">
<code>Bereich: </code>
Technischer Support
</li>
<li class="list-group-item">
<code>Dringlichkeit: </code>
<span class="badge" style="background-color:#39b185;">gering</span>
</li>
<li class="list-group-item">
<code>Legende: </code>
<div>
<span>Legende: </span>
<span style="font-weight:600;">Fett</span>
 = RF-Signal (wichtiges Token); 
<span style="color:#cf597e;">Rot</span>
 = negatives Sentiment; 
<span style="font-weight:600;color:#cf597e;">Fett + Rot</span>
 = beides
</div>
</li>
<li class="list-group-item">
<code>Nachricht:</code>
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical; font-size: 0.95rem;"><b>Bitte</b> eine <b>detaillierte</b> <b>Anleitung</b> zur <b>Integration</b> von Malwarebytes in Wix <b>bereitstellen</b>.</div>
</li>
</ul>
</div>
</div>
<div class="glide__slide">
<div class="card" style="width: 100%;">
<ul class="list-group list-group-flush">
<li class="list-group-item">
<code>Betreff: </code>
Fachliche Unterstützung für die Integration von Smartsheet mit Docker-Projektplanung erforderlich
</li>
<li class="list-group-item">
<code>Bereich: </code>
Produktsupport
</li>
<li class="list-group-item">
<code>Dringlichkeit: </code>
<span class="badge" style="background-color:#39b185;">gering</span>
</li>
<li class="list-group-item">
<code>Legende: </code>
<div>
<span>Legende: </span>
<span style="font-weight:600;">Fett</span>
 = RF-Signal (wichtiges Token); 
<span style="color:#cf597e;">Rot</span>
 = negatives Sentiment; 
<span style="font-weight:600;color:#cf597e;">Fett + Rot</span>
 = beides
</div>
</li>
<li class="list-group-item">
<code>Nachricht:</code>
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical; font-size: 0.95rem;">Können Sie uns Ratschläge <b>geben</b>, wie wir Smartsheet und Docker für Projektplanung integrieren können? Wir suchen eine glatte <b>Integration</b>, um die Workflowprozesse zu vereinfachen.</div>
</li>
</ul>
</div>
</div>
<div class="glide__slide">
<div class="card" style="width: 100%;">
<ul class="list-group list-group-flush">
<li class="list-group-item">
<code>Betreff: </code>
Sichere Datenverwaltungslösungen
</li>
<li class="list-group-item">
<code>Bereich: </code>
Personalabteilung
</li>
<li class="list-group-item">
<code>Dringlichkeit: </code>
<span class="badge" style="background-color:#39b185;">gering</span>
</li>
<li class="list-group-item">
<code>Legende: </code>
<div>
<span>Legende: </span>
<span style="font-weight:600;">Fett</span>
 = RF-Signal (wichtiges Token); 
<span style="color:#cf597e;">Rot</span>
 = negatives Sentiment; 
<span style="font-weight:600;color:#cf597e;">Fett + Rot</span>
 = beides
</div>
</li>
<li class="list-group-item">
<code>Nachricht:</code>
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical; font-size: 0.95rem;">Können Sie <b>Informationen</b> zu den Sicherheitslösungen für die Datenverwaltung für Krankenhäuser <b>bereitstellen</b>? Ich <b>danke</b> Ihnen im <b>Voraus</b>.</div>
</li>
</ul>
</div>
</div>
<div class="glide__slide">
<div class="card" style="width: 100%;">
<ul class="list-group list-group-flush">
<li class="list-group-item">
<code>Betreff: </code>
Datensperrverletzung in den Krankenhaus-IT-Systemen wurde kürzlich festgestellt
</li>
<li class="list-group-item">
<code>Bereich: </code>
Technischer Support
</li>
<li class="list-group-item">
<code>Dringlichkeit: </code>
<span class="badge" style="background-color:#cf597e;">hoch</span>
</li>
<li class="list-group-item">
<code>Legende: </code>
<div>
<span>Legende: </span>
<span style="font-weight:600;">Fett</span>
 = RF-Signal (wichtiges Token); 
<span style="color:#cf597e;">Rot</span>
 = negatives Sentiment; 
<span style="font-weight:600;color:#cf597e;">Fett + Rot</span>
 = beides
</div>
</li>
<li class="list-group-item">
<code>Nachricht:</code>
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical; font-size: 0.95rem;">Es <b>wurde</b> <b>festgestellt</b>, dass in den Krankenhaus-IT-Systemen eine Datensperrverletzung vorliegt, die durch <b><span style='color:#cf597e'>veraltete</span></b> Software die medizinischen Patientenakten <b><span style='color:#cf597e'>gefährdet</span></b> hat. <b>Bereits</b> <b>durchgeführt</b> <b>wurden</b> <b>Updates</b> und Malware-Suchungen.</div>
</li>
</ul>
</div>
</div>
<div class="glide__slide">
<div class="card" style="width: 100%;">
<ul class="list-group list-group-flush">
<li class="list-group-item">
<code>Betreff: </code>
Support für Integration von Monday.com mit Xcode
</li>
<li class="list-group-item">
<code>Bereich: </code>
Kundenservice
</li>
<li class="list-group-item">
<code>Dringlichkeit: </code>
<span class="badge" style="background-color:#39b185;">gering</span>
</li>
<li class="list-group-item">
<code>Legende: </code>
<div>
<span>Legende: </span>
<span style="font-weight:600;">Fett</span>
 = RF-Signal (wichtiges Token); 
<span style="color:#cf597e;">Rot</span>
 = negatives Sentiment; 
<span style="font-weight:600;color:#cf597e;">Fett + Rot</span>
 = beides
</div>
</li>
<li class="list-group-item">
<code>Nachricht:</code>
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical; font-size: 0.95rem;"><b>Könnten</b> Sie <b>bitte</b> <b>detaillierte</b> Richtlinien für die <b>Integration</b> von Monday.com mit Apple Xcode 12.5 und Android 12 <b>bereitstellen</b>? Ich benötige eine <b>Schritt</b>-für-<b>Schritt</b>-<b>Anleitung</b>, um die <b>Integration</b> erfolgreich einzurichten, einschließlich der erforderlichen APIs und Softwareentwicklungskits. Es <b>wäre</b> hilfreich, wenn Sie Beispiel-Screenshots hinzufügen <b>könnten</b>, um den Prozess zu veranschaulichen.</div>
</li>
</ul>
</div>
</div>
<div class="glide__slide">
<div class="card" style="width: 100%;">
<ul class="list-group list-group-flush">
<li class="list-group-item">
<code>Betreff: </code>
Verfahren zur Sicherung medizinischer Daten
</li>
<li class="list-group-item">
<code>Bereich: </code>
Kundenservice
</li>
<li class="list-group-item">
<code>Dringlichkeit: </code>
<span class="badge" style="background-color:#39b185;">gering</span>
</li>
<li class="list-group-item">
<code>Legende: </code>
<div>
<span>Legende: </span>
<span style="font-weight:600;">Fett</span>
 = RF-Signal (wichtiges Token); 
<span style="color:#cf597e;">Rot</span>
 = negatives Sentiment; 
<span style="font-weight:600;color:#cf597e;">Fett + Rot</span>
 = beides
</div>
</li>
<li class="list-group-item">
<code>Nachricht:</code>
<div style="overflow: hidden; width: 100%; display: -webkit-box; -webkit-line-clamp: 8; -webkit-box-orient: vertical; font-size: 0.95rem;">Brauche <b>detaillierte</b> <b>Anleitungen</b> für die Sicherung <b>medizinischer</b> Daten, einschließlich Smart-Thermometer und Oracle Database 19c. <b>Möchte</b> <b>mehr</b> <b>Informationen</b> über erforderliche Schritte, Protokolle und Maßnahmen zur Gewährleistung von <b>Vertraulichkeit</b> und <b>Integrität</b> <b>erhalten</b>?</div>
</li>
</ul>
</div>
</div>
</div>
</div>
</div>
<script>document.addEventListener('DOMContentLoaded', function () {
  new Glide('#nd-04007031e41a31bc4765305abf2aeb9ed1626fd2', {
    type: 'carousel',
    perView: 2,
    gap: 24,
    autoplay: 5000,
    breakpoints: {
      576: { perView: 1 }
    }
  }).mount();
})</script>

Damit wird sichtbar, dass das Modell z. B. bei Formulierungen wie „Fehler", „Problem" oder „Schwierigkeiten" eher zu einer hohen Dringlichkeit tendiert. Tickets mit neutraleren oder allgemeineren Formulierungen landen dagegen häufiger in der gering dringlich-Kategorie.

### Fazit

In dieser Fallstudie haben wir gezeigt, wie sich Support-Tickets allein anhand der Nachricht automatisiert nach Dringlichkeit klassifizieren lassen. Schon **einfache sprachliche Merkmale** wie Wortwahl, Fragen oder Stimmung liefern ausreichend Informationen, um ein leistungsfähiges Modell zu trainieren. Dadurch können Unternehmen **kritische Anliegen schneller identifizieren**, **Bearbeitungszeiten verkürzen** und die **Kundenzufriedenheit gezielt steigern**. Zudem schafft die Hervorhebung wichtiger Textsignale **Transparenz** und erleichtert die **Akzeptanz** solcher Systeme im Arbeitsalltag.
