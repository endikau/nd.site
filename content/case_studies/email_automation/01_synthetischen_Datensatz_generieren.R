library(ellmer)
readRenviron(".renviron")
Sys.getenv("OPENAI_API_KEY")

`%s+%` <- stringi::`%s+%`

base_url <- "https://api.hrz.uni-giessen.de/v1"

# Verfügbare Modelle (optional)
models_openai(base_url = base_url)[["id"]]

# -----------------------------
# System-Prompt für ENDI-Datensatz (strukturiert, kein CSV)
# -----------------------------
system_prompt <- "
Du bist ein erfahrener Customer-Support-Mitarbeiter eines Industrieunternehmens.

Gegeben sei ein fiktives Industrieunternehmen namens ENDI, das Maschinen und industrielle Lösungen vertreibt.
ENDI erhält täglich sehr viele Kundenanfragen, die bisher manuell beantwortet wurden.

Deine Aufgabe ist es, hochwertige Trainingsdaten für einen KI-Agenten zu erzeugen.

CONTEXT
Die Kundenanfragen stammen aus folgenden Bereichen:
- Onlineshop & Versand
- Technische Probleme mit Maschinen und Anlagen
- Garantie- und Reklamationsfälle
- Ersatzteile, Wartung und Service
- Schulungen, Inbetriebnahme und Support
- Lob und allgemeines Feedback

QUALITÄTSANFORDERUNGEN (SEHR WICHTIG)
- Jede Anfrage ist realistisch, konkret und fachlich plausibel.
- Jede Antwort passt inhaltlich exakt und eindeutig zur jeweiligen Anfrage.
- Verwende einen professionellen, höflichen B2B-Support-Ton.
- Antworte ruhig, sachlich und lösungsorientiert.
- Keine Marketing-Floskeln, keine Werbesprache.
- Keine Platzhalter, keine Zufallstexte, keine widersprüchlichen Inhalte.
- Keine Annahmen über Identität oder Sicherheitskontext.
- Antworten dürfen konkrete nächste Schritte enthalten (z. B. Seriennummer anfordern, Fotos erbitten, Support-Hinweis).

AUSGABEFORMAT
- Gib die Daten strukturiert aus
- Die konkrete Struktur (z. B. Array von Objekten) wird in der jeweiligen Nutzeranweisung vorgegeben.
- Gib ausschließlich die angeforderten strukturierten Daten zurück, ohne erklärenden Text.

WEITERE REGELN
- Jede Antwort darf sich nur auf ihre zugehörige Anfrage beziehen.
- Keine generischen oder wiederholten Inhalte.
- Jede Anfrage und jede Antwort ist individuell formuliert.
- Stil, Länge und fachlicher Detailgrad sind konsistent.
- Schreibe ausschließlich auf Deutsch.
"

chat <- chat_openai_compatible(
  model = "gwdg/gemma-3-27b-it",
  base_url = base_url,
  system_prompt = system_prompt
)

# -----------------------------
# Struktur: ARRAY von OBJEKTEN
#   - customer_request: String
#   - answer: String
# -----------------------------
type_dataset <- type_array(
  items = type_object(
    customer_request = type_string(),
    answer           = type_string()
  )
)

# -----------------------------
# Generierung des ENDI-Datensatzes
# -----------------------------
df_endi <- chat$chat_structured(
  "
Du bist ein erfahrener Customer-Support-Mitarbeiter des fiktiven Industrieunternehmens ENDI.

Aufgabe:
Generiere GENAU 500 unterschiedliche, realistische Kundenanfragen (B2B-Kontext)
und jeweils eine fachlich präzise, passende Antwort.

Inhaltliche Schwerpunkte:
- Industrieprodukte und Maschinen
- Technische Fragen und Störungen
- Lieferung, Versand und Bestellung
- Ersatzteile, Wartung und Service
- Schulungen, Inbetriebnahme und Support
- Lob, Zufriedenheit und allgemeines Feedback

Qualitätsanforderungen:
- Jede Kundenanfrage ist konkret, praxisnah und technisch plausibel.
- Jede Antwort bezieht sich ausschließlich auf die jeweilige Anfrage.
- Professioneller, sachlicher und höflicher Support-Ton.
- Lösungsorientiert, ohne Marketing- oder Werbesprache.
- Keine Platzhalter, keine Wiederholungen, keine generischen Aussagen.
- Antworten dürfen konkrete nächste Schritte enthalten (z. B. Seriennummer anfragen, Fotos anfordern).

Ausgabe:
- Liefere ausschließlich ein ARRAY von OBJEKTEN
- Jedes Objekt enthält exakt:
  - customer_request (String)
  - answer (String)
- Schreibe ausschließlich auf Deutsch.
",
  type = type_dataset
)

print(df_endi)

write.csv(df_endi,"endi_kundenanfragen.csv", row.names = FALSE)
