# Getting Started with peacock

``` r

library(peacock)
```

## Introduction

peacock is a simple package that helps you start new R projects quickly.
Instead of manually creating folders and files every time, peacock sets
them up for you with sensible defaults.

This guide shows you how to use each function in the package.

## Core Philosophy

peacock follows three principles:

1.  **Start fast** - Get a working project structure in seconds
2.  **Stay organized** - Pre-configured folders keep your work tidy
3.  **Work your way** - Modify templates to fit your workflow

## Function Overview

peacock provides four main functions:

- [`init_shiny()`](https://www.samuelbharti.com/peacock/r/reference/init_shiny.md) -
  Create a Shiny app structure
- [`init_template()`](https://www.samuelbharti.com/peacock/r/reference/init_template.md) -
  Pull GitHub project templates
- [`init_changelog_md()`](https://www.samuelbharti.com/peacock/r/reference/init_changelog_md.md) -
  Add a changelog file
- [`tool_review_template()`](https://www.samuelbharti.com/peacock/r/reference/tool_review_template.md) -
  Set up tool comparison projects

## Setting up a Shiny App

The most common use case is starting a new Shiny application.

``` r

# Create a Shiny app in the current directory
init_shiny()

# Create in a specific location
init_shiny(path = "~/projects/my_dashboard")

# Skip confirmation prompt (useful in scripts)
init_shiny(path = "~/projects/my_dashboard", confirm = FALSE)
```

### What gets created?

When you run
[`init_shiny()`](https://www.samuelbharti.com/peacock/r/reference/init_shiny.md),
you get:

**Main files:** - `ui.R` - User interface definition with navbar
structure - `server.R` - Server logic (empty but ready to use) -
`global.R` - Load libraries, data, and shared objects

**Organized folders:** - `modules/` - Modular Shiny components (includes
example module) - `userInterface/` - UI components split by page -
`R/` - Helper functions and utilities - `www/` - Static assets (CSS,
JavaScript, images) - `data/` - Data files - `dev/` - Development
scripts

**Configuration:** - `Dockerfile` - Ready for deployment -
`.gitignore` - Pre-configured for R projects - `.Renviron` - Environment
variables

### Example workflow

``` r

# 1. Initialize your project
init_shiny(path = "~/my_app", confirm = FALSE)

# 2. Change to that directory
setwd("~/my_app")

# 3. Start editing files
# Open ui.R, server.R, global.R and start coding

# 4. Run your app
shiny::runApp()
```

## Using GitHub Templates

If you have complete project templates on GitHub, pull them down with
[`init_template()`](https://www.samuelbharti.com/peacock/r/reference/init_template.md).

``` r

# Use the built-in Shiny template
init_template("shiny", path = "~/projects/new_shiny_app")

# Use the CGDS research template
init_template("cgds", path = "~/research/new_study")
```

This downloads the template, extracts it, and sets it up in your chosen
directory. The function automatically cleans up temporary files.

### Available templates

Currently includes:

- `"shiny"` - Full-featured Shiny application template
- `"cgds"` - Research project template from UAB CGDS

## Tracking Changes

Keep a log of what you’ve done with
[`init_changelog_md()`](https://www.samuelbharti.com/peacock/r/reference/init_changelog_md.md).

``` r

# Add a changelog to your project
init_changelog_md(path = "~/my_project")
```

This creates `CHANGELOG.md` with this structure:

    # CHANGELOG

    ``` txt
    YYYY-MM-DD  John Doe

    * Big Change 1
    * Another Change 2


    Replace the template content with your actual changes. This is helpful for:

    - Documenting what you did and when
    - Sharing progress with collaborators
    - Remembering why you made certain decisions

    ## Comparing Multiple Tools

    When you need to evaluate several tools or methods, `tool_review_template()` creates an organized structure.


    ``` r
    # Compare three bioinformatics tools
    tool_review_template(
      tool_name = c("STAR", "HISAT2", "Salmon"),
      tool_url = c(
        "https://github.com/alexdobin/STAR",
        "http://daehwankimlab.github.io/hisat2/",
        "https://github.com/COMBINE-lab/salmon"
      ),
      path = "~/research/rna_seq_comparison"
    )

### What gets created?

The function builds this structure:

    project/
    ├── src/                    # Scripts for each tool
    │   ├── STAR.R
    │   ├── HISAT2.R
    │   └── Salmon.R
    ├── data/
    │   ├── shared/            # Input data used by all tools
    │   ├── preprocessed/      # One folder per tool
    │   │   ├── STAR/
    │   │   ├── HISAT2/
    │   │   └── Salmon/
    │   └── other/
    ├── notebooks/             # Analysis notebooks
    ├── configs/               # Configuration files
    ├── out/                   # One folder per tool for outputs
    │   ├── STAR/
    │   ├── HISAT2/
    │   └── Salmon/
    └── docs/                  # Documentation and reports

Each R script in `src/` includes comments with the tool name and URL.

### Example use case

``` r

# Set up the comparison
tool_review_template(
  tool_name = c("method_a", "method_b"),
  tool_url = c("", "https://method-b.com"),
  path = "~/comparison",
  confirm = FALSE
)

# Navigate and start working
setwd("~/comparison")

# Put shared data in data/shared/
# Edit scripts in src/
# Run analyses and save outputs to out/method_a/ and out/method_b/
# Document findings in docs/
```

## Tips and Tricks

### Skip confirmations in scripts

All functions have a `confirm` parameter. Set it to `FALSE` when using
peacock in automated scripts:

``` r

init_shiny(path = "auto_project", confirm = FALSE)
```

### Customize after creation

Templates are starting points. After running a peacock function:

- Delete folders you don’t need
- Add new ones that fit your workflow
- Modify the generated files
- Save your own version as a GitHub template

### Use with RStudio Projects

Peacock works great with RStudio Projects:

``` r

# 1. Create the structure
init_shiny(path = "~/my_project", confirm = FALSE)

# 2. Create an RStudio Project
rstudioapi::initializeProject(path = "~/my_project")

# 3. Open it
rstudioapi::openProject("~/my_project")
```

### Combine functions

You can use multiple peacock functions in one project:

``` r

# Initialize with a template
init_template("shiny", path = "~/my_app")

# Add a changelog
init_changelog_md(path = "~/my_app", confirm = FALSE)
```

## Common Questions

**Q: Can I modify the templates?**

Yes. The files created are normal files on your computer. Change them
however you want. If you create a template you like, consider making it
a GitHub repository and using
[`init_template()`](https://www.samuelbharti.com/peacock/r/reference/init_template.md)
to reuse it.

**Q: What if I want different folder names?**

After running a peacock function, rename folders as needed. Or fork the
package and modify the templates to your preferences.

**Q: Do I need to use all the folders created?**

No. Delete what you don’t need. The templates provide structure for
common cases, but your project might not need everything.

**Q: Can I contribute new templates?**

Yes. Open an issue or pull request on GitHub to discuss adding new
templates.

## Next Steps

Now that you know how peacock works:

1.  Try creating a test project with
    [`init_shiny()`](https://www.samuelbharti.com/peacock/r/reference/init_shiny.md)
2.  Look at the generated files to understand the structure
3.  Customize it for your needs
4.  Use peacock to start your next real project

For more examples and updates, visit:
<http://www.samuelbharti.com/peacock/>
