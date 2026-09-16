# peacock-init

<!-- badges: start -->
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![DOI](https://img.shields.io/badge/DOI-10.5281%2Fzenodo.21350436-1682D4)](https://doi.org/10.5281/zenodo.21350436)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://github.com/samuelbharti/peacock/blob/main/LICENSE)
<!-- badges: end -->

Python CLI companion to the [peacock](https://github.com/samuelbharti/peacock)
R package. Scaffold project directories from templates with one command.

## Install

```bash
pip install "peacock-init @ git+https://github.com/samuelbharti/peacock#subdirectory=pkg-py"
```

## Usage

```bash
# Scaffold a Python project
peacock init python my-project

# Scaffold a reproducible analysis
peacock init analysis my-analysis

# Use a GitHub template from the registry
peacock init template shiny my-app

# Use any GitHub repo as a template
peacock init template owner/repo my-project --ref v1.0

# List available templates
peacock templates
```

## Templates

Run `peacock templates` to see the built-in template registry. Templates are
GitHub repositories that get cloned and unpacked into your target directory.

## License

MIT
