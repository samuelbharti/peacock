# Initialize a Quarto project

Scaffolds a starter [Quarto](https://quarto.org) project: a website, a
book, or a manuscript, with a `_quarto.yml` and starter documents.

## Usage

``` r
init_quarto(
  path = getwd(),
  type = c("website", "book", "manuscript"),
  confirm = TRUE
)
```

## Arguments

- path:

  Path where the project is created.

- type:

  Project type: one of `"website"`, `"book"`, or `"manuscript"`.

- confirm:

  Logical. If TRUE, prompts for confirmation before creating the project
  (interactive sessions only).

## Value

Invisibly, the `path` the project was created in.

## Examples

``` r
init_quarto(path = tempdir(), confirm = FALSE)
#> Your current working directory will be:
#> /tmp/RtmpFYnuk4Quarto website project initialized.
```
