# A changelog markdown template to document project progress

A changelog markdown template to document project progress

## Usage

``` r
init_changelog_md(path = getwd(), confirm = TRUE)
```

## Arguments

- path:

  Path where markdown file is created

- confirm:

  Confirm path; logical input.

## Value

Return markdown file in specified or current working directory

## Examples

``` r
init_changelog_md(path = tempdir(), confirm = FALSE)
#> Your current working directory will be:
#> /tmp/RtmpHhxE0p
```
