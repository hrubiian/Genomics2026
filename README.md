# Structural and Functional Genomics

Course website: **https://hrubiian.github.io/Genomics2026/**

## How to publish changes

Edit the `.qmd` files, then publish in **one step**:

**From RStudio's Console**

```r
source("publish.R")   # once per session
publish("week 2 update")
```

**From RStudio's Terminal tab**

```bash
./publish.sh "week 2 update"
```

Either one renders the site into `docs/`, commits everything and pushes.
The live site refreshes about a minute later.

> To preview locally before publishing, use **Build > Render Website** in
> RStudio, or run `quarto preview`.

## How it is wired up

| Piece | Purpose |
|---|---|
| `_quarto.yml` | Site config. `output-dir: docs` is what GitHub Pages serves. |
| `docs/` | Generated output — **never edit by hand**, it is overwritten on every render. |
| `docs/.nojekyll` | Tells GitHub to serve the files as-is instead of running Jekyll over them. |
| `qmd/` | Homework and instruction pages. |
| `styles.css` | Custom CSS, loaded by every page. |

GitHub Pages is set to serve the **`main` branch, `/docs` folder**
(Settings > Pages). Changing that setting will break publishing.
