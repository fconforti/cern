// 50 anni al CERN: il piano del weekend, con il branding del sito.
// Si genera con pdf/build.py.

#let navy = rgb("#0b1b3a")
#let panel = rgb("#132544")
#let cyan = rgb("#7fd1ff")
#let pink = rgb("#ff7eb6")
#let orange = rgb("#ffb347")
#let green = rgb("#7ee2a8")
#let violet = rgb("#c39bff")
#let ink = rgb("#e8edf5")
#let soft = rgb("#c3cbd8")
#let muted = rgb("#8e9bb0")

#let serif = "Fraunces"
#let sans = "Inter"

#set document(title: "50 anni al CERN", author: "Filippo")
#set text(font: sans, size: 10pt, fill: ink, lang: "it")
#set par(leading: 0.62em, spacing: 0.9em)
#show strong: set text(fill: white, weight: 600)

// --- Pezzi del marchio -------------------------------------------------------

#let brand(size) = box(baseline: 18%)[
  #text(font: serif, weight: 800, size: size, fill: white, tracking: -0.03em)[CERN]
  #h(size * 0.18)
  #box(height: size * 1.05, image("mark.svg"))
]

#let glow(dx: 0mm, dy: 0mm, r: 70mm, color: cyan, a: 82%) = place(
  top + left, dx: dx, dy: dy,
  circle(radius: r, fill: gradient.radial(color.transparentize(a), navy.transparentize(100%))),
)

#let eyebrow(color: cyan, body) = text(size: 7.5pt, weight: 700, tracking: 0.14em, fill: color, upper(body))

#let title(body, color: cyan, kicker: none) = {
  if kicker != none { eyebrow(color: color, kicker); v(-4pt) }
  text(font: serif, weight: 800, size: 26pt, fill: white, body)
  v(2pt)
  box(width: 34mm, height: 2pt, radius: 1pt, fill: gradient.linear(color, color.transparentize(100%)))
  v(6pt)
}

#let card(color: cyan, inset: 11pt, height: auto, body) = block(
  width: 100%, height: height, fill: panel, radius: 10pt, inset: inset,
  stroke: 0.8pt + color.transparentize(55%), body,
)

#let tile(color, label, heading, height: auto, body) = card(color: color, height: height)[
  #eyebrow(color: color, label)
  #v(-5pt)
  #text(font: serif, weight: 800, size: 12pt, fill: white, heading)
  #v(-3pt)
  #text(size: 8.8pt, fill: soft, body)
]

#let note(label: "Da sapere", body) = card(color: cyan)[
  #eyebrow(label)
  #v(-4pt)
  #text(size: 9pt, fill: soft, body)
]

#let slot(time, color: cyan, body) = grid(
  columns: (20mm, 1fr), column-gutter: 3mm,
  align(right, text(font: serif, weight: 800, size: 12.5pt, fill: color, time)),
  block(stroke: (left: 1.5pt + color.transparentize(55%)), inset: (left: 4mm, bottom: 2mm), body),
)

#let check(body) = grid(
  columns: (11pt, 1fr), column-gutter: 6pt,
  box(width: 9pt, height: 9pt, radius: 2pt, stroke: 1pt + cyan, baseline: -1pt),
  text(fill: soft, body),
)

#let pill(color, body) = box(
  inset: (x: 7pt, y: 3.5pt), radius: 99pt, stroke: 0.8pt + color.transparentize(30%),
  fill: color.transparentize(88%), text(size: 9pt, weight: 600, fill: color, body),
)

// --- Pagina ------------------------------------------------------------------

#set page(
  paper: "a4",
  fill: navy,
  margin: (x: 17mm, top: 24mm, bottom: 18mm),
  header: context {
    if counter(page).get().first() > 1 {
      grid(columns: (1fr, auto), align: (left + horizon, right + horizon),
        brand(13pt),
        text(size: 8pt, fill: muted, tracking: 0.08em, upper[Ginevra · 30 gen – 1 feb 2027]),
      )
    }
  },
  footer: context {
    if counter(page).get().first() > 1 {
      grid(columns: (1fr, auto),
        text(size: 8pt, fill: muted)[fconforti.github.io/cern],
        text(size: 8pt, fill: muted, counter(page).display()),
      )
    }
  },
)

// --- Copertina ---------------------------------------------------------------

#glow(dx: 70mm, dy: -40mm, r: 95mm, color: pink, a: 80%)
#glow(dx: -60mm, dy: 60mm, r: 90mm, color: cyan, a: 82%)
#glow(dx: 40mm, dy: 170mm, r: 80mm, color: violet, a: 86%)

#brand(30pt)

#v(10mm)
#align(center, image("../src/assets/hero.svg", width: 82mm))
#v(8mm)

#text(font: serif, weight: 800, size: 46pt, fill: white)[50 anni al CERN]

#v(-2mm)
#text(size: 13pt, fill: soft)[Un weekend in famiglia a Ginevra, tra particelle subatomiche, sauna sul porto e un tuffo nel lago.]

#v(4mm)
#pill(cyan)[Sabato 30 gennaio – Lunedì 1 febbraio 2027]

#v(1fr)
#grid(columns: (1fr, auto), column-gutter: 8mm, align: (left + bottom, right + bottom),
  [
    #text(font: serif, style: "italic", weight: 500, size: 12pt, fill: ink)[«Dal più piccolo granello di sabbia alle stelle più lontane, tutto ciò che ci circonda è fatto di particelle fondamentali.»]
    #v(4mm)
    #text(size: 9pt, fill: muted)[Preparati al viaggio sul sito, con video e spiegazioni per tutte le età:]
    #linebreak()
    #text(size: 10pt, weight: 600, fill: cyan)[fconforti.github.io/cern]
  ],
  box(width: 30mm, card(color: cyan, inset: 7pt, image(".qr.svg", width: 100%))),
)

#pagebreak()

// --- Perché il CERN ----------------------------------------------------------

#glow(dx: 90mm, dy: -50mm, r: 80mm, color: cyan, a: 88%)

#title(kicker: "Il posto dove si capisce di cosa è fatto tutto")[Perché il CERN]

Alle porte di Ginevra, cento metri sotto terra, c'è un anello di 27 chilometri in cui i protoni corrono quasi alla velocità della luce e si scontrano per ricreare le condizioni di un istante dopo il Big Bang. È il laboratorio di fisica più grande del mondo, e dal 2023 ha un centro visitatori progettato da Renzo Piano, lo *Science Gateway*: mostre interattive, laboratori dove si fanno esperimenti veri, spettacoli scientifici e visite guidate da fisici e ingegneri che raccontano in prima persona cosa fanno lì dentro.

Per i miei 50 anni mi sembrava il posto giusto: un compleanno dedicato alla curiosità, in un luogo che non assomiglia a nessun altro. E già che siamo a Ginevra, aggiungiamo un rito locale che merita: la sauna sul lago con tuffo nel Lemano.

#v(4mm)
#eyebrow[Chi viene]
#v(-2pt)
#{
  let names = ("Filippo", "Erika", "Diego", "Leonardo", "Simone", "Barbara", "Chiara", "Sofia")
  let colors = (cyan, pink, orange, green, violet, cyan, pink, orange)
  names.zip(colors).map(((n, c)) => pill(c, n)).join(h(5pt))
}
#v(1mm)
#text(size: 9pt, fill: muted)[Otto in tutto: al CERN entriamo come famiglia, senza prenotazione di gruppo.]

#v(6mm)
#eyebrow[Il viaggio in breve]
#v(-2pt)
#grid(columns: (1fr, 1fr, 1fr), column-gutter: 4mm,
  tile(cyan, "Sabato 30", height: 33mm, "Arrivo e lago")[Treno Firenze – Milano – Ginevra. Passeggiata sul lago e in città vecchia, fonduta sul molo ai Bains des Pâquis.],
  tile(pink, "Domenica 31", height: 33mm, "Il CERN")[Giornata allo Science Gateway. Poi sauna e tuffo nel lago, e pizza di compleanno ai Pâquis.],
  tile(orange, "Lunedì 1", height: 33mm, "Rientro")[Treno con partenza comoda, arrivo a Firenze nel tardo pomeriggio.],
)

#pagebreak()

// --- Sabato ------------------------------------------------------------------

#glow(dx: -70mm, dy: 120mm, r: 85mm, color: cyan, a: 88%)

#title(kicker: "Sabato 30 gennaio")[Arrivo, lago e fonduta]

#slot("10:00")[Partenza da *Firenze Santa Maria Novella* con il Frecciarossa. Arrivo a Milano Centrale verso le 11:50: un'ora e mezza per un pranzo veloce in stazione prima dell'EuroCity.]
#slot("13:20")[*EuroCity Milano – Ginevra*: quattro ore senza cambi attraverso il tunnel del Sempione e poi lungo il Lago Lemano da Montreux a Losanna. *Sedetevi a sinistra*: è uno dei tratti ferroviari più belli d'Europa.]
#slot("17:20")[Arrivo a *Genève-Cornavin*. L'hotel, l'Auteuil Manotel (rue de Lausanne 33), è a quattro minuti a piedi dalla stazione, nel quartiere dei Pâquis: due camere familiari comunicanti, una per famiglia. All'arrivo ci danno la *Geneva Transport Card*: tram, bus e battelli gratis per tutto il soggiorno.]
#slot("18:00")[Passeggiata: il quai du Mont-Blanc fino al *Jet d'eau* (il getto d'acqua alto 140 metri, simbolo della città), il ponte sul Rodano, poi su per la città vecchia fino alla cattedrale di Saint-Pierre e place du Bourg-de-Four.]
#slot("19:30", color: pink)[Fonduta alla buvette dei *Bains des Pâquis*, nella sala sul lago con le luci di Ginevra sull'acqua. La classica è la «moitié-moitié», metà Gruyère e metà Vacherin. Zero pretese, vista impagabile, e intanto vediamo dove torneremo domani per la sauna. In otto conviene chiamare per un tavolo.]

#v(4mm)
#note(label: "Treni")[I biglietti Firenze – Milano e Milano – Ginevra sono separati, per questo partiamo con un'ora e mezza di margine a Milano: anche con un ritardo l'EuroCity delle 13:20 non si perde.]

#pagebreak()

// --- Domenica ----------------------------------------------------------------

#glow(dx: 80mm, dy: -40mm, r: 85mm, color: pink, a: 86%)

#title(kicker: "Domenica 31 gennaio", color: pink)[Particelle, sauna, pizza]

#slot("8:30")[Colazione e *tram 18* dalla fermata Môle, a un minuto dall'hotel: in 25 minuti porta al capolinea «Meyrin, CERN», davanti allo Science Gateway, al confine con la Francia.]
#slot("9:00")[Arrivo all'apertura. Check-in e, dal telefono, prenotazione di visita guidata e laboratorio. *Si prenotano solo sul posto*: la visita due ore prima dell'inizio, il laboratorio un'ora prima, 24 posti in ordine di arrivo. Per questo arriviamo presto.]
#slot("Mattina")[Le tre mostre permanenti: *Discover CERN* (come funziona l'acceleratore, con un piccolo acceleratore vero in funzione), *Our Universe* (da cosa è fatto tutto) e *Quantum World* (la meccanica quantistica, spiegata in modo da capirci qualcosa). Tutto si tocca e si prova.]
#slot("Pranzo")[Al *Big Bang Café* dello Science Gateway, oppure nella mensa del CERN dove mangiano i fisici.]
#slot("Pomer.")[Visita guidata per chi ha almeno 12 anni, laboratorio o science show nell'auditorium per i più piccoli. Verso le 15 abbiamo visto tutto.]
#slot("17:00", color: pink)[*Bains des Pâquis*: i bagni pubblici del 1932 sul molo davanti al Jet d'eau. D'inverno diventano una spa popolare: due saune in legno con vetrata sul lago, un bagno turco e due hammam. Il rito è sauna, poi giù dalla scaletta nel Lemano (a fine gennaio l'acqua è a 6-7 gradi), poi di nuovo in sauna. Tre giri e si rinasce. Chi preferisce fa la doccia fredda. Ingresso 22 CHF, ultimo ingresso alle 20:30.]
#slot("19:30", color: orange)[Pizza di compleanno da *Luigia*, in rue Adhémar-Fabri, a due passi dall'hotel: napoletana verace, rumorosa, piena di famiglie. Dopo il tuffo nel lago non c'è niente di meglio. Prenotare per otto.]

#v(3mm)
#note[Tutto il CERN è gratuito, incluse visite guidate e laboratori, ma conviene *registrarsi online* su visit.cern fino a un mese prima: garantisce l'ingresso. Mostre consigliate dagli 8 anni, visite guidate dai *12*, laboratori dai 5 in su a seconda del tema. Sotto i 16 anni sempre con un adulto. Per la visita guidata serve il *documento*: alcuni percorsi passano in Francia. Sauna e hammam dei Bains sono misti (costume obbligatorio); la domenica aprono alle 8 ed è il giorno più affollato.]

#pagebreak()

// --- Lunedì e logistica ------------------------------------------------------

#glow(dx: -60mm, dy: -30mm, r: 80mm, color: violet, a: 88%)

#title(kicker: "Lunedì 1 febbraio", color: orange)[Rientro con calma]

#slot("Mattina", color: orange)[Colazione lenta. Chi vuole fa un'ultima passeggiata sul lago o un salto al mercato coperto di Plainpalais.]
#slot("11:39", color: orange)[*EuroCity Ginevra – Milano*. Arrivo a Milano Centrale verso le 15:40. Stavolta il lago è sulla *destra*.]
#slot("16:10", color: orange)[*Frecciarossa Milano – Firenze*. A casa per le 18.]

#v(5mm)
#title(kicker: "Cose da sapere", color: green)[Logistica]

#grid(columns: (1fr, 1fr), column-gutter: 4mm, row-gutter: 4mm,
  tile(cyan, "Dormiamo", "Hotel Auteuil Manotel", height: 33mm)[Rue de Lausanne 33, quattro stelle, 4 minuti dalla stazione e 10 dal lago. Camere familiari comunicanti. Colazione 7-11 nel weekend; la sera niente ristorante, ma il quartiere ne è pieno.],
  tile(pink, "Ci muoviamo", "A piedi, e tram gratis", height: 33mm)[Tutto è a piedi. Il CERN con il tram 18 dalla fermata Môle, a un minuto dall'hotel. Tram, bus e battelli gratis con la Geneva Transport Card.],
  tile(orange, "Treni", "Orari indicativi", height: 33mm)[Quelli del 2027 escono a dicembre: li ricontrolliamo prima di comprare.],
  tile(violet, "Meteo", "2-6 gradi, vento", height: 33mm)[Ginevra d'inverno: vento sul lago. Strati e cappello.],
  tile(green, "Lingua", "Francese", height: 33mm)[Ma al CERN si parla di tutto, italiano compreso.],
  tile(cyan, "Documenti", "Carta d'identità", height: 33mm)[La Svizzera è fuori dall'UE ma in Schengen: basta la carta d'identità.],
)

#pagebreak()

// --- Valigia e saluto --------------------------------------------------------

#glow(dx: 60mm, dy: 120mm, r: 95mm, color: cyan, a: 84%)
#glow(dx: -40mm, dy: 170mm, r: 80mm, color: pink, a: 88%)

#title(kicker: "Prima di partire")[Da mettere in valigia]

#grid(columns: (1fr, 1fr), column-gutter: 8mm, row-gutter: 3.2mm,
  check[*Costume da bagno* per la sauna e il lago (gli asciugamani li noleggiamo lì)],
  check[*Ciabatte di gomma* per il molo],
  check[*Scarpe comode e giacca calda*: si cammina molto e a fine gennaio sul lago tira vento],
  check[*Carta d'identità*, anche per la visita guidata al CERN],
  check[*Telefono carico*: visite e laboratori si prenotano dal telefono],
  check[*Carta o franchi svizzeri*: il CERN è gratis, la sauna no],
  check[*Un quaderno piccolo* per la caccia al tesoro],
)

#v(5mm)
#eyebrow[Da fare prima]
#v(-1pt)
#grid(columns: (1fr, 1fr), column-gutter: 8mm, row-gutter: 3.2mm,
  check[Registrazione online allo Science Gateway su visit.cern],
  check[Tavolo per otto ai Bains des Pâquis e da Luigia],
  check[Biglietti del treno sul telefono],
  check[Il quiz sul sito, fatto almeno una volta],
)

#v(1fr)
#block(width: 100%, radius: 18pt, inset: (x: 14mm, y: 11mm),
  stroke: 1pt + cyan.transparentize(50%),
  fill: gradient.linear(panel, navy, angle: 90deg),
)[
  #align(center)[
    #box(height: 22mm, image("mark.svg"))
    #v(3mm)
    #text(font: serif, weight: 800, size: 30pt, fill: white)[Grazie di venire!]
    #v(1mm)
    #text(font: serif, style: "italic", weight: 500, size: 17pt, fill: pink)[— Filippo]
    #v(1mm)
    #text(size: 8pt, weight: 700, tracking: 0.14em, fill: muted)[GINEVRA · 31 GENNAIO 2027]
  ]
]
