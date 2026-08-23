# peacock 0.3.0

## New features

* `init_package()` scaffolds a full R package with DESCRIPTION, NAMESPACE,
  starter function, testthat tests, R-CMD-check workflow, air.toml, pkgdown
  config, and agent files.

## Other

* Restructured to monorepo layout: R package lives in `pkg-r/`, Python CLI
  in `pkg-py/`, shared template registry in `shared/`.

* Added `peacock-init` Python CLI companion (`pip install peacock-init`).

* Added shared template registry with sync tooling and drift CI.

# peacock 0.2.0

## New features

* `init_template()` now accepts **any** GitHub repository as `"owner/repo"` or
  `"owner/repo@ref"` (branch, tag, or commit), in addition to the built-in names.
  Templates are defined in a data-file registry, and the download targets the
  repository's default branch (`HEAD`) instead of a hardcoded `main`.

* `peacock_templates()` lists the built-in templates. A custom registry (DCF or
  YAML) can be supplied via the `registry` argument.

* `init_analysis()` scaffolds a reproducible analysis project (raw/processed data,
  analysis notebooks, reusable functions, and outputs).

* `init_quarto()` scaffolds a Quarto `website`, `book`, or `manuscript`.

* `init_python()` emits a modern Python project (src layout, `pyproject.toml` with
  ruff and pytest). peacock stays an R package.

* Every project scaffold - `init_shiny()`, `init_analysis()`, `init_quarto()`,
  `init_python()`, and `tool_review_template()` - now also writes `AGENTS.md` and
  `CLAUDE.md` so AI coding assistants are productive immediately.

## Reliability

* Added a `testthat` (edition 3) test suite and a cross-platform `R CMD check`
  GitHub Actions workflow (Ubuntu, Windows, macOS).

* Adopted the [Air](https://posit-dev.github.io/air/) formatter, enforced in CI.

## Bug fixes

* `init_template()` validates its template argument and fails fast with a clear
  message for unknown names; the download is wrapped with error handling and
  always cleans up its temporary directory.

* `tool_review_template()` uses `seq_along()` (previously errored on an empty
  `tool_name`) and now populates new *and* empty `src/` scripts.

* The Shiny `Dockerfile` `CMD` uses valid quoting (previously backticks).

* Confirmation prompts are shown only in interactive sessions, so scripted use no
  longer silently cancels.

## Other

* peacock is now released under the MIT license (previously GPL-3).

* Added a package hex-sticker logo (in an Indian folk-art style), a companion
  overview graphic, and browser-tab favicons for the documentation site.

* The `init_*` scaffolding functions now return the created `path` invisibly.

# peacock 0.1.0

Initial release of peacock.

## Features

* `init_shiny()` - Initialize a complete Shiny application structure with organized folders for modules, UI components, data, and static assets. Includes Dockerfile for deployment.

* `init_template()` - Download and set up project templates from GitHub repositories. Currently supports "shiny" and "cgds" templates.

* `init_changelog_md()` - Create a CHANGELOG.md file with a simple format for tracking project progress and changes.

* `tool_review_template()` - Set up an organized structure for comparing multiple tools or methods, with dedicated folders for each tool's data, scripts, and outputs.

## Notes

* All functions include a confirmation prompt by default. Set `confirm = FALSE` to skip prompts in automated workflows.

* Templates create standard directory structures that can be modified after creation to fit specific needs.

* Package includes built-in error handling and user-friendly messages for setup workflows.
