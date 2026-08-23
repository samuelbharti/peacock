#' Initialize a Python project
#'
#' Scaffolds a modern Python project (src layout) with a `pyproject.toml`
#' configured for ruff and pytest, a starter package and test, and agent
#' guidance. peacock stays an R package; this simply emits Python project files.
#'
#' @param path Path where the project is created. The project name is taken from
#'   the final path component; the importable module name is derived from it.
#' @param confirm Logical. If TRUE, prompts for confirmation before creating the
#'   project (interactive sessions only).
#'
#' @return Invisibly, the `path` the project was created in.
#' @export
#'
#' @examples
#' init_python(path = file.path(tempdir(), "my_pkg"), confirm = FALSE)
init_python <- function(path = getwd(), confirm = TRUE) {
  cat("Your current working directory will be:\n")
  cat(path)

  if (confirm && interactive()) {
    user_input <- tolower(
      readline(
        prompt = "Do you wish to create a Python project here? (y/yes to confirm): "
      )
    )
  } else {
    user_input <- "y"
  }

  if (!user_input %in% c("y", "yes")) {
    cat("Project initialization canceled.\n")
    return(invisible(path))
  }

  project <- basename(sub("[/\\]+$", "", path))
  module <- tolower(gsub("[^A-Za-z0-9]+", "_", project))
  if (grepl("^[0-9]", module)) {
    module <- paste0("pkg_", module)
  }

  dir.create(
    file.path(path, "src", module),
    recursive = TRUE,
    showWarnings = FALSE
  )
  dir.create(file.path(path, "tests"), recursive = TRUE, showWarnings = FALSE)

  write_file <- function(rel, lines) {
    con <- file(file.path(path, rel))
    writeLines(lines, con)
    close(con)
  }

  write_file(
    "pyproject.toml",
    c(
      "[project]",
      paste0("name = \"", project, "\""),
      "version = \"0.0.1\"",
      "description = \"A Python project scaffolded with peacock.\"",
      "requires-python = \">=3.9\"",
      "dependencies = []",
      "",
      "[project.optional-dependencies]",
      "dev = [\"pytest\", \"ruff\"]",
      "",
      "[build-system]",
      "requires = [\"hatchling\"]",
      "build-backend = \"hatchling.build\"",
      "",
      "[tool.hatch.build.targets.wheel]",
      paste0("packages = [\"src/", module, "\"]"),
      "",
      "[tool.ruff]",
      "line-length = 88",
      "",
      "[tool.pytest.ini_options]",
      "testpaths = [\"tests\"]",
      "pythonpath = [\"src\"]"
    )
  )

  write_file(
    file.path("src", module, "__init__.py"),
    c(
      paste0("\"\"\"", project, " package.\"\"\""),
      "",
      "__version__ = \"0.0.1\"",
      "",
      "",
      "def hello() -> str:",
      "    \"\"\"Return a friendly greeting.\"\"\"",
      paste0("    return \"Hello from ", project, "!\"")
    )
  )

  write_file(
    "tests/test_basic.py",
    c(
      paste0("from ", module, " import hello"),
      "",
      "",
      "def test_hello():",
      "    assert \"Hello\" in hello()"
    )
  )

  write_file(
    ".gitignore",
    c(
      "__pycache__/",
      "*.py[cod]",
      ".venv/",
      ".pytest_cache/",
      ".ruff_cache/",
      "dist/",
      "build/",
      "*.egg-info/"
    )
  )

  write_file(
    "README.md",
    c(
      paste0("# ", project),
      "",
      "A Python project scaffolded with peacock.",
      "",
      "## Setup",
      "",
      "```sh",
      "python -m venv .venv",
      ". .venv/bin/activate  # Windows: .venv\\Scripts\\activate",
      "pip install -e \".[dev]\"",
      "```",
      "",
      "## Test and lint",
      "",
      "```sh",
      "pytest",
      "ruff check .",
      "```"
    )
  )

  write_agent_files(
    path,
    c(
      "# Python project - agent guide",
      "",
      "A Python project scaffolded with peacock (src layout).",
      "",
      "## Setup",
      "",
      "- `python -m venv .venv` then activate it.",
      "- `pip install -e \".[dev]\"` installs the package plus dev tools.",
      "",
      "## Test and lint",
      "",
      "- `pytest` runs tests (configured via `pythonpath = [\"src\"]`).",
      "- `ruff check .` lints; `ruff format .` formats.",
      "",
      "## Layout",
      "",
      paste0("- `src/", module, "/` - the importable package."),
      "- `tests/` - pytest tests.",
      "- `pyproject.toml` - project metadata, build, ruff, and pytest config."
    )
  )

  cat("Python project initialized.\n")
  invisible(path)
}
