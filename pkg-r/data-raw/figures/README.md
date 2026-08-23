# Figure sources

Generators for the package artwork in `man/figures/`. Not part of the build
(this directory is listed in `.Rbuildignore`).

The peacock is drawn in an Indian folk-art style (Madhubani/Mughal ornament,
a kolam dotted border, a lotus pedestal). Geometry is computed with trig so the
fan stays symmetric; the scripts have no third-party Python dependencies.

## Files

- `logo.py` — the hex mascot. Variants: `indigo` (shipped), `maroon`, `cream`.
  A `simple` argument drops the fine detail for legible small favicons.
- `overview.py` — the "command → scaffolded project" overview banner.
- `raster.js` — optional SVG → PNG helper (Node).
- `favicon_square.py` — centre the hex on a square canvas (for favicons).
- `pack_ico.py` — pack PNGs into a multi-size `favicon.ico`.

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

## Favicons

The set in `pkgdown/favicon/` is generated directly from the vector logo, so it
needs no external service. pkgdown copies that directory into the site and links
it in every page's `<head>` automatically.

```sh
python favicon_square.py ../../man/figures/logo.svg square.svg   # full, on a square canvas
python logo.py indigo simple.svg simple                          # simplified mark
python favicon_square.py simple.svg simple_sq.svg

# simplified mark for the tiny sizes
node raster.js simple_sq.svg ../../pkgdown/favicon/favicon-16x16.png 16
node raster.js simple_sq.svg ../../pkgdown/favicon/favicon-32x32.png 32

# full ornate logo for the apple-touch sizes
for s in 60 76 120 152 180; do
  node raster.js square.svg ../../pkgdown/favicon/apple-touch-icon-${s}x${s}.png $s
done
cp ../../pkgdown/favicon/apple-touch-icon-180x180.png ../../pkgdown/favicon/apple-touch-icon.png

# favicon.ico (16/32/48, simplified)
node raster.js simple_sq.svg s48.png 48
python pack_ico.py ../../pkgdown/favicon/favicon.ico favicon-16x16.png favicon-32x32.png s48.png
```

`pkgdown::build_favicons()` (needs R + the RealFaviconGenerator web service) is
the standard alternative.
