#' Initialize a Quarto project
#'
#' Scaffolds a starter [Quarto](https://quarto.org) project: a website, a book,
#' or a manuscript, with a `_quarto.yml` and starter documents.
#'
#' @param path Path where the project is created.
#' @param type Project type: one of `"website"`, `"book"`, or `"manuscript"`.
#' @param confirm Logical. If TRUE, prompts for confirmation before creating the
#'   project (interactive sessions only).
#'
#' @return Invisibly, the `path` the project was created in.
#' @export
#'
#' @examples
#' init_quarto(path = tempdir(), confirm = FALSE)
init_quarto <- function(
  path = getwd(),
  type = c("website", "book", "manuscript"),
  confirm = TRUE
) {
  type <- match.arg(type)

  cat("Your current working directory will be:\n")
  cat(path)

  if (confirm && interactive()) {
    user_input <- tolower(
      readline(
        prompt = "Do you wish to create a Quarto project here? (y/yes to confirm): "
      )
    )
  } else {
    user_input <- "y"
  }

  if (!user_input %in% c("y", "yes")) {
    cat("Project initialization canceled.\n")
    return(invisible(path))
  }

  dir.create(path, recursive = TRUE, showWarnings = FALSE)

  write_file <- function(rel, lines) {
    con <- file(file.path(path, rel))
    writeLines(lines, con)
    close(con)
  }

  write_file(
    ".gitignore",
    c("/.quarto/", "/_site/", "/_book/", "/_manuscript/")
  )

  if (type == "website") {
    write_file(
      "_quarto.yml",
      c(
        "project:",
        "  type: website",
        "",
        "website:",
        "  title: \"My project\"",
        "  navbar:",
        "    left:",
        "      - href: index.qmd",
        "        text: Home",
        "      - href: about.qmd",
        "        text: About",
        "",
        "format:",
        "  html:",
        "    theme: cosmo",
        "    css: styles.css"
      )
    )
    write_file(
      "index.qmd",
      c(
        "---",
        "title: \"My project\"",
        "---",
        "",
        "Welcome. Edit `index.qmd` to change this page."
      )
    )
    write_file(
      "about.qmd",
      c(
        "---",
        "title: \"About\"",
        "---",
        "",
        "About this project."
      )
    )
    write_file("styles.css", c("/* Custom styles */"))
  } else if (type == "book") {
    write_file(
      "_quarto.yml",
      c(
        "project:",
        "  type: book",
        "",
        "book:",
        "  title: \"My book\"",
        "  author: \"Author Name\"",
        "  chapters:",
        "    - index.qmd",
        "    - intro.qmd",
        "    - summary.qmd",
        "",
        "bibliography: references.bib",
        "",
        "format:",
        "  html:",
        "    theme: cosmo",
        "  pdf:",
        "    documentclass: scrbook"
      )
    )
    write_file(
      "index.qmd",
      c(
        "---",
        "title: \"Preface\"",
        "---",
        "",
        "# Preface {.unnumbered}",
        "",
        "This is a Quarto book."
      )
    )
    write_file("intro.qmd", c("# Introduction", "", "Your first chapter."))
    write_file("summary.qmd", c("# Summary", "", "Wrap up here."))
    write_file("references.bib", bib_stub())
  } else if (type == "manuscript") {
    write_file(
      "_quarto.yml",
      c(
        "project:",
        "  type: manuscript",
        "",
        "manuscript:",
        "  article: index.qmd",
        "",
        "bibliography: references.bib",
        "",
        "format:",
        "  html: default"
      )
    )
    write_file(
      "index.qmd",
      c(
        "---",
        "title: \"My manuscript\"",
        "author: \"Author Name\"",
        "abstract: |",
        "  A short abstract.",
        "---",
        "",
        "## Introduction",
        "",
        "Write your manuscript here."
      )
    )
    write_file("references.bib", bib_stub())
  }

  write_agent_files(
    path,
    c(
      paste0("# Quarto ", type, " - agent guide"),
      "",
      paste0("A Quarto ", type, " scaffolded with peacock."),
      "",
      "## Build",
      "",
      "- `quarto preview` for a live preview; `quarto render` to build.",
      "",
      "## Layout",
      "",
      "- `_quarto.yml` - project and format configuration.",
      "- `index.qmd` - the entry document.",
      "- Add pages or chapters as `.qmd` files and register them in `_quarto.yml`."
    )
  )

  cat("Quarto", type, "project initialized.\n")
  invisible(path)
}

# Starter bibliography entry shared by the book/manuscript types.
bib_stub <- function() {
  c(
    "@article{example2024,",
    "  title = {An example reference},",
    "  author = {Doe, Jane},",
    "  year = {2024},",
    "  journal = {Journal of Examples}",
    "}"
  )
}
