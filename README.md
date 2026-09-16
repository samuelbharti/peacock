# peacock

<!-- badges: start -->
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![r-universe](https://samuelbharti.r-universe.dev/badges/peacock)](https://samuelbharti.r-universe.dev/peacock)
[![R-CMD-check](https://github.com/samuelbharti/peacock/actions/workflows/r.yaml/badge.svg)](https://github.com/samuelbharti/peacock/actions/workflows/r.yaml)
[![DOI](https://img.shields.io/badge/DOI-10.5281%2Fzenodo.21350436-1682D4)](https://doi.org/10.5281/zenodo.21350436)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://github.com/samuelbharti/peacock/blob/main/LICENSE)
<!-- badges: end -->

Project scaffolding for R and Python. One function (or CLI command) sets up
a ready-to-work directory with the right layout, config files, and agent
guidance.

## Packages

| Package | Language | Install | Docs |
|---------|----------|---------|------|
| [peacock](pkg-r/) | R | `pak::pak("samuelbharti/peacock/pkg-r")` | [samuelbharti.com/peacock/r](https://www.samuelbharti.com/peacock/r/) |
| [peacock-init](pkg-py/) | Python | `pip install "peacock-init @ git+https://github.com/samuelbharti/peacock#subdirectory=pkg-py"` | [pkg-py/README.md](pkg-py/README.md) |

## Repository layout

```
pkg-r/     R package (r-universe)
pkg-py/    Python CLI (PyPI)
shared/    Template registry (source of truth for both packages)
tools/     Sync and version-check scripts
```

## License

MIT
