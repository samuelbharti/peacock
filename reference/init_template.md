# Initialize a project from a GitHub template repository

Downloads a template repository from GitHub and unpacks it into `path`.
The template can be a built-in name (see
[`peacock_templates()`](http://www.samuelbharti.com/peacock/reference/peacock_templates.md))
or any GitHub repository given as `"owner/repo"` or `"owner/repo@ref"`.

## Usage

``` r
init_template(
  template_name = "shiny",
  path = getwd(),
  ref = NULL,
  registry = NULL,
  confirm = TRUE
)
```

## Arguments

- template_name:

  A built-in template name (e.g. `"shiny"`, `"cgds"`), or a GitHub
  repository as `"owner/repo"` / `"owner/repo@ref"`. Defaults to
  `"shiny"`.

- path:

  Path where the project template will be created.

- ref:

  Optional branch, tag, or commit to download. Overrides an `@ref` given
  in `template_name`. Defaults to the template's registry ref, or the
  repository's default branch (`HEAD`).

- registry:

  Optional path to a custom registry file (DCF or YAML); see
  [`peacock_templates()`](http://www.samuelbharti.com/peacock/reference/peacock_templates.md).
  Defaults to the registry bundled with peacock.

- confirm:

  Logical. If TRUE, prompts for confirmation before creating the
  template (interactive sessions only).

## Value

Invisibly, the `path` the template was created in.

## Examples

``` r
if (FALSE) { # \dontrun{
init_template("shiny")
init_template("owner/repo@dev", path = tempdir())
} # }
```
