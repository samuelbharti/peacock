# Initialize a Python project

Scaffolds a modern Python project (src layout) with a `pyproject.toml`
configured for ruff and pytest, a starter package and test, and agent
guidance. peacock stays an R package; this simply emits Python project
files.

## Usage

``` r
init_python(path = getwd(), confirm = TRUE)
```

## Arguments

- path:

  Path where the project is created. The project name is taken from the
  final path component; the importable module name is derived from it.

- confirm:

  Logical. If TRUE, prompts for confirmation before creating the project
  (interactive sessions only).

## Value

Invisibly, the `path` the project was created in.

## Examples

``` r
init_python(path = file.path(tempdir(), "my_pkg"), confirm = FALSE)
#> Your current working directory will be:
#> /tmp/RtmpUGexTt/my_pkgPython project initialized.
```
