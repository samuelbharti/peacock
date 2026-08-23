# Initialize a reproducible analysis project

Scaffolds a tidy directory layout for a data-analysis / research
project: raw and processed data, analysis notebooks, reusable R
functions, and outputs.

## Usage

``` r
init_analysis(path = getwd(), confirm = TRUE)
```

## Arguments

- path:

  Path where the project is created.

- confirm:

  Logical. If TRUE, prompts for confirmation before creating the project
  (interactive sessions only).

## Value

Invisibly, the `path` the project was created in.

## Examples

``` r
init_analysis(path = tempdir(), confirm = FALSE)
#> Your current working directory will be:
#> /tmp/RtmprRceU7Analysis project initialized.
```
