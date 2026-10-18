# 50 anni al CERN

Sito di famiglia per prepararsi al weekend a Ginevra del 30 gennaio - 1 febbraio 2027: cosa andremo a vedere allo Science Gateway del CERN, come funziona l'acceleratore e cosa cercano i fisici. Contenuti e video (YouTube) pensati per ragazzi dagli 8 ai 16 anni.

Costruito con [Astro](https://astro.build) + [Starlight](https://starlight.astro.build), pubblicato su GitHub Pages.

## Sviluppo

```sh
npm install
npm run dev       # http://localhost:4321
npm run build     # output in dist/
```

## Struttura

- `src/content/docs/` — le pagine (Markdown/MDX), una cartella per sezione: `basi`, `cern`, `ricerca`, `visita`.
- `src/components/YouTube.astro` — player YouTube leggero (anteprima, iframe solo al click, sottotitoli in italiano per i video in inglese).
- `src/content/docs/index.mdx` — la home: programma del viaggio, valigia, Ginevra, link al PDF (`public/50-anni-al-CERN.pdf`).
- `src/components/Quiz.astro`, `Countdown.astro`, `StandardModel.astro`, `Checklists.astro` — componenti interattivi.
- `src/components/ThemeProvider.astro` — tema scuro di default.
- `src/styles/custom.css` — tema.
- `astro.config.mjs` — titolo, sidebar, gestione di `base` per GitHub Pages.

## Deploy

Il workflow `.github/workflows/deploy.yml` compila e pubblica su GitHub Pages a ogni push su `main`. Ricava da solo `SITE` e `BASE_PATH` dal nome del repository, quindi funziona con qualsiasi nome. Nelle impostazioni del repository, in **Settings → Pages**, la sorgente deve essere **GitHub Actions**.

## Aggiungere un video

```mdx
import YouTube from '../../../components/YouTube.astro';

<YouTube id="ID_YOUTUBE" title="Titolo" channel="Canale" min="7:51" age="8+" lang="it" note="Facoltativa" />
```

`lang="en"` attiva i sottotitoli in italiano. Gli ID vanno verificati: `https://www.youtube.com/oembed?url=https://www.youtube.com/watch?v=ID&format=json` risponde con titolo e canale se il video esiste ed è incorporabile.

## PDF e immagine di anteprima

Il PDF del piano (`public/50-anni-al-CERN.pdf`) e l'immagine per i link condivisi (`public/og.jpg`, 1200×630) si generano dai sorgenti in `pdf/`: il PDF con [Typst](https://typst.app) da `plan.typ`, l'immagine da `og.svg`.

```sh
uv run --with typst --with segno --with pillow --with resvg-py --with fonttools python pdf/build.py
```

Lo script scarica i font (Fraunces e Inter) in `pdf/.fonts/` e crea il QR code del sito. Dopo una modifica al programma, aggiornare `pdf/plan.typ` e rigenerare.
