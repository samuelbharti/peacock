# peacock

<!-- badges: start -->
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![r-universe](https://samuelbharti.r-universe.dev/badges/peacock)](https://samuelbharti.r-universe.dev/peacock)
[![R-CMD-check](https://github.com/samuelbharti/peacock/actions/workflows/r.yaml/badge.svg)](https://github.com/samuelbharti/peacock/actions/workflows/r.yaml)
[![DOI](https://img.shields.io/badge/DOI-10.5281%2Fzenodo.21350436-1682D4)](https://doi.org/10.5281/zenodo.21350436)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://github.com/samuelbharti/peacock/blob/main/LICENSE)
<!-- badges: end -->

Project scaffolding for R and Python. One function call, or one shell command,
sets up a ready-to-work directory with the right layout, config files, and agent
guidance.

## Installation

R, from r-universe:

```r
install.packages("peacock", repos = "https://samuelbharti.r-universe.dev")
```

Python, from this repository:

```bash
pip install "peacock-init @ git+https://github.com/samuelbharti/peacock#subdirectory=pkg-py"
```

## A first project

In R:

```r
library(peacock)

# a Shiny app, laid out and ready to run
init_shiny("my-app")

# a reproducible analysis, with no prompt
init_analysis("my-analysis", confirm = FALSE)
```

From the shell:

```bash
peacock init python my-project
peacock init template shiny my-app
peacock templates
```

Every scaffold writes ordinary files. Delete what you do not want and edit the
rest.

## What it makes

| Function | Project |
| --- | --- |
| `init_shiny()` | A Shiny app |
| `init_analysis()` | A reproducible analysis |
| `init_quarto()` | A Quarto project |
| `init_python()` | A Python project |
| `init_template()` | Any GitHub repository, used as a template |
| `tool_review_template()` | A directory for comparing several tools |
| `init_changelog_md()` | A changelog, in Keep a Changelog form |
| `peacock_templates()` | The built-in template registry |

The Python CLI covers three of these: `python`, `analysis` and `template`.

Each scaffold written from scratch carries `AGENTS.md` and `CLAUDE.md`, so a
coding agent picks up the conventions without being told them again.
`init_template()` is the exception, because it clones someone else's repository.

## Packages

| Package | Language | Install | Docs |
|---------|----------|---------|------|
| [peacock](pkg-r/) | R | `pak::pak("samuelbharti/peacock/pkg-r")` | [samuelbharti.com/peacock/r](https://www.samuelbharti.com/peacock/r/) |
| [peacock-init](pkg-py/) | Python | `pip install "peacock-init @ git+https://github.com/samuelbharti/peacock#subdirectory=pkg-py"` | [pkg-py/README.md](pkg-py/README.md) |

`peacock-init` installs from this repository rather than from PyPI. The name is
registered but nothing has published to it yet, which is [#42](https://github.com/samuelbharti/peacock/issues/42).

## Repository layout

```
pkg-r/     R package, distributed through r-universe
pkg-py/    Python CLI
shared/    Template registry, the source of truth for both packages
tools/     Sync and version-check scripts
```

## License

MIT. See [LICENSE](https://github.com/samuelbharti/peacock/blob/main/LICENSE).
