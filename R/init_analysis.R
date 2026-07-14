#' Initialize a reproducible analysis project
#'
#' Scaffolds a tidy directory layout for a data-analysis / research project:
#' raw and processed data, analysis notebooks, reusable R functions, and outputs.
#'
#' @param path Path where the project is created.
#' @param confirm Logical. If TRUE, prompts for confirmation before creating the
#'   project (interactive sessions only).
#'
#' @return Invisibly, the `path` the project was created in.
#' @export
#'
#' @examples
#' init_analysis(path = tempdir(), confirm = FALSE)
init_analysis <- function(path = getwd(), confirm = TRUE) {
  cat("Your current working directory will be:\n")
  cat(path)

  if (confirm && interactive()) {
    user_input <- tolower(
      readline(
        prompt = "Do you wish to create an analysis project here? (y/yes to confirm): "
      )
    )
  } else {
    user_input <- "y"
  }

  if (!user_input %in% c("y", "yes")) {
    cat("Project initialization canceled.\n")
    return(invisible(path))
  }

  dirs <- c(
    "data/raw",
    "data/processed",
    "R",
    "analysis",
    "output/figures",
    "output/tables"
  )
  for (d in dirs) {
    dir.create(file.path(path, d), recursive = TRUE, showWarnings = FALSE)
  }

  # Keep otherwise-empty data/output folders in version control.
  keep_dirs <- c(
    "data/raw",
    "data/processed",
    "output/figures",
    "output/tables"
  )
  for (d in keep_dirs) {
    file.create(file.path(path, d, ".gitkeep"), showWarnings = FALSE)
  }

  write_file <- function(rel, lines) {
    con <- file(file.path(path, rel))
    writeLines(lines, con)
    close(con)
  }

  write_file(
    "README.md",
    c(
      "# Analysis project",
      "",
      "Reproducible analysis scaffold created with peacock.",
      "",
      "## Layout",
      "",
      "- `data/raw/` - original, read-only inputs",
      "- `data/processed/` - cleaned / derived data",
      "- `R/` - reusable functions",
      "- `analysis/` - notebooks that tell the story",
      "- `output/figures/`, `output/tables/` - generated results"
    )
  )

  write_file(
    ".gitignore",
    c(
      ".Rproj.user",
      ".Rhistory",
      ".RData",
      ".Ruserdata",
      "*_cache/",
      "/*.html"
    )
  )

  write_file(
    "R/functions.R",
    c(
      "# Reusable functions for this project.",
      "# Source from a notebook with: source(\"R/functions.R\")"
    )
  )

  write_file(
    "analysis/notebook.qmd",
    c(
      "---",
      "title: \"Analysis\"",
      "format: html",
      "---",
      "",
      "```{r setup}",
      "# source(\"../R/functions.R\")",
      "```",
      "",
      "## Overview",
      "",
      "Describe the question, data, and approach here."
    )
  )

  cat("Analysis project initialized.\n")
  invisible(path)
}
