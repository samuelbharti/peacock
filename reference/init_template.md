# Initialize a template repository from GitHub Templates

Initialize a template repository from GitHub Templates

## Usage

``` r
init_template(template_name = c("shiny", "cgds"), path = getwd(), confirm = TRUE)
```

## Arguments

- template_name:

  Name of template, one of "shiny" or "cgds". Defaults to "shiny".

- path:

  Path where project template will be created.

- confirm:

  Logical. If TRUE, prompts user for confirmation before creating
  template.

## Value

Return project structure from selected github template at path
specified.

## Examples

``` r
if (FALSE) { # \dontrun{
init_template("shiny",getwd())
} # }
```
