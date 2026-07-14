# Figure sources

Generators for the package artwork in `man/figures/`. Not part of the build
(this directory is listed in `.Rbuildignore`).

The peacock is drawn in an Indian folk-art style (Madhubani/Mughal ornament,
a kolam dotted border, a lotus pedestal). Geometry is computed with trig so the
fan stays symmetric; the scripts have no third-party Python dependencies.

## Files

- `logo.py` — the hex mascot. Variants: `indigo` (shipped), `maroon`, `cream`.
- `overview.py` — the "command → scaffolded project" overview banner.
- `raster.js` — optional SVG → PNG helper (Node).

## Regenerate

```sh
# SVG (Python 3, standard library only)
python logo.py indigo ../../man/figures/logo.svg
python overview.py    ../../man/figures/overview.svg

# PNG — pick any SVG rasteriser, e.g. resvg-js:
npm install @resvg/resvg-js
node raster.js ../../man/figures/logo.svg     ../../man/figures/logo.png      560
node raster.js ../../man/figures/overview.svg ../../man/figures/overview.png  1600
```

`rsvg-convert -w 560 logo.svg -o logo.png` or Inkscape work equally well.

## Favicons (optional)

Run once in R to generate the pkgdown favicon set from `man/figures/logo.png`:

```r
pkgdown::build_favicons(overwrite = TRUE)
```
