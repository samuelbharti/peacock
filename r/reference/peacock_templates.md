# List the built-in project templates

Returns the registry of curated templates that
[`init_template()`](https://www.samuelbharti.com/peacock/r/reference/init_template.md)
understands by short name. You can also pass any GitHub `"owner/repo"`
(optionally `"owner/repo@ref"`) to
[`init_template()`](https://www.samuelbharti.com/peacock/r/reference/init_template.md)
without it being in this registry.

## Usage

``` r
peacock_templates(registry = NULL)
```

## Arguments

- registry:

  Optional path to a custom registry file. `.dcf` files are read with
  base R; `.yaml`/`.yml` files require the yaml package. Defaults to the
  registry bundled with peacock.

## Value

A data frame of available templates with columns `Name`, `Repo`, `Ref`,
and `Description`.

## Examples

``` r
peacock_templates()
#>    Name                                Repo  Ref
#> 1 shiny        samuelbharti/RShiny_template HEAD
#> 2  cgds uab-cgds-worthey/cgds_repo_template HEAD
#>                                Description
#> 1 Full-featured Shiny application template
#> 2       UAB CGDS research project template
```
