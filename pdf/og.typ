// Immagine di anteprima per i link condivisi (WhatsApp, Telegram, social): 1200×630.
#let navy = rgb("#0b1b3a")
#let cyan = rgb("#7fd1ff")
#let pink = rgb("#ff7eb6")
#let violet = rgb("#c39bff")
#let soft = rgb("#c3cbd8")
#let serif = "Fraunces"

#set page(width: 1200pt, height: 630pt, margin: 0pt, fill: navy)
#set text(font: "Inter", fill: white)

#let glow(dx, dy, r, color, a) = place(top + left, dx: dx, dy: dy,
  circle(radius: r, fill: gradient.radial(color.transparentize(a), navy.transparentize(100%))))

#glow(640pt, -120pt, 420pt, pink, 78%)
#glow(-200pt, 260pt, 420pt, cyan, 82%)
#glow(820pt, 330pt, 300pt, violet, 84%)

#place(top + right, dx: -70pt, dy: 95pt, image("../src/assets/hero.svg", width: 440pt))

#place(top + left, dx: 80pt, dy: 60pt)[
  #box(baseline: 18%)[
    #text(font: serif, weight: 800, size: 44pt, tracking: -0.03em)[CERN]
    #h(8pt)
    #box(height: 46pt, image("mark.svg"))
  ]
]

#place(bottom + left, dx: 80pt, dy: -70pt, block(width: 640pt)[
  #par(leading: 0.3em, text(font: serif, weight: 800, size: 88pt)[50 anni\ al CERN])
  #v(22pt)
  #v(6pt)
  #box(inset: (x: 18pt, y: 9pt), radius: 99pt, stroke: 1.5pt + cyan.transparentize(30%), fill: cyan.transparentize(88%),
    text(size: 24pt, weight: 600, fill: cyan)[Ginevra · 30 gennaio – 1 febbraio 2027])
  #v(10pt)
  #text(size: 24pt, fill: soft)[Video e spiegazioni per tutta la famiglia.]
])
