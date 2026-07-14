#' List the built-in project templates
#'
#' Returns the registry of curated templates that [init_template()] understands
#' by short name. You can also pass any GitHub `"owner/repo"` (optionally
#' `"owner/repo@ref"`) to `init_template()` without it being in this registry.
#'
#' @param registry Optional path to a custom registry file. `.dcf` files are read
#'   with base R; `.yaml`/`.yml` files require the \pkg{yaml} package. Defaults to
#'   the registry bundled with peacock.
#'
#' @return A data frame of available templates with columns `Name`, `Repo`, `Ref`,
#'   and `Description`.
#' @export
#'
#' @examples
#' peacock_templates()
peacock_templates <- function(registry = NULL) {
  reg <- read_registry(registry)
  keep <- intersect(c("Name", "Repo", "Ref", "Description"), names(reg))
  reg[, keep, drop = FALSE]
}

#' Read a template registry file (DCF or YAML)
#'
#' @param registry Optional path. `NULL` uses the bundled `inst/templates.dcf`.
#' @return A data frame with at least `Name` and `Repo` columns.
#' @noRd
read_registry <- function(registry = NULL) {
  if (is.null(registry)) {
    registry <- system.file("templates.dcf", package = "peacock")
  }
  if (!nzchar(registry) || !file.exists(registry)) {
    stop("Template registry not found: ", registry, call. = FALSE)
  }

  if (grepl("\\.ya?ml$", registry, ignore.case = TRUE)) {
    if (!requireNamespace("yaml", quietly = TRUE)) {
      stop(
        "Reading a YAML registry requires the 'yaml' package. ",
        "Install it, or use a DCF registry.",
        call. = FALSE
      )
    }
    entries <- yaml::read_yaml(registry)
    rows <- lapply(entries, function(e) {
      data.frame(
        Name = as.character(e[["Name"]] %||% NA_character_),
        Repo = as.character(e[["Repo"]] %||% NA_character_),
        Ref = as.character(e[["Ref"]] %||% "HEAD"),
        DocURL = as.character(e[["DocURL"]] %||% NA_character_),
        Description = as.character(e[["Description"]] %||% NA_character_),
        stringsAsFactors = FALSE
      )
    })
    return(do.call(rbind, rows))
  }

  as.data.frame(read.dcf(registry), stringsAsFactors = FALSE)
}

#' Resolve a template name to a GitHub repo, ref, and doc URL
#'
#' Pure logic (no network): accepts a registry name, a GitHub `"owner/repo"`, or
#' `"owner/repo@ref"`. An explicit `ref` argument wins over an `@ref` suffix,
#' which wins over the registry's `Ref`, which falls back to `"HEAD"` (the repo's
#' default branch).
#'
#' @param template_name Registry name or `"owner/repo"` / `"owner/repo@ref"`.
#' @param ref Optional branch/tag/SHA override.
#' @param registry Optional custom registry path (see `read_registry()`).
#' @return A list with `repo`, `ref`, and `doc_url`.
#' @noRd
resolve_template <- function(template_name, ref = NULL, registry = NULL) {
  if (grepl("@", template_name, fixed = TRUE)) {
    parts <- strsplit(template_name, "@", fixed = TRUE)[[1]]
    template_name <- parts[1]
    if (is.null(ref) && length(parts) > 1) {
      ref <- parts[2]
    }
  }

  if (grepl("/", template_name, fixed = TRUE)) {
    repo <- template_name
    doc_url <- paste0("https://github.com/", repo)
    registry_ref <- NA_character_
  } else {
    reg <- read_registry(registry)
    match_row <- reg[reg$Name == template_name, , drop = FALSE]
    if (nrow(match_row) == 0) {
      stop(
        "Unknown template '",
        template_name,
        "'. Available: ",
        paste(reg$Name, collapse = ", "),
        ". Or pass a GitHub 'owner/repo'.",
        call. = FALSE
      )
    }
    repo <- match_row$Repo[1]
    doc_url <- if ("DocURL" %in% names(match_row)) match_row$DocURL[1] else NA
    registry_ref <- if ("Ref" %in% names(match_row)) match_row$Ref[1] else NA
  }

  if (is.null(ref) || is.na(ref) || !nzchar(ref)) {
    ref <- if (!is.na(registry_ref) && nzchar(registry_ref)) {
      registry_ref
    } else {
      "HEAD"
    }
  }

  list(repo = repo, ref = ref, doc_url = doc_url)
}

# Minimal null-coalescing helper (base R gained %||% only in 4.4.0).
`%||%` <- function(x, y) if (is.null(x)) y else x
