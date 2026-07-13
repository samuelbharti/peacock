#' Initialize a project from a GitHub template repository
#'
#' Downloads a template repository from GitHub and unpacks it into `path`. The
#' template can be a built-in name (see [peacock_templates()]) or any GitHub
#' repository given as `"owner/repo"` or `"owner/repo@ref"`.
#'
#' @param template_name A built-in template name (e.g. `"shiny"`, `"cgds"`), or a
#'   GitHub repository as `"owner/repo"` / `"owner/repo@ref"`. Defaults to `"shiny"`.
#' @param path Path where the project template will be created.
#' @param ref Optional branch, tag, or commit to download. Overrides an `@ref`
#'   given in `template_name`. Defaults to the template's registry ref, or the
#'   repository's default branch (`HEAD`).
#' @param registry Optional path to a custom registry file (DCF or YAML); see
#'   [peacock_templates()]. Defaults to the registry bundled with peacock.
#' @param confirm Logical. If TRUE, prompts for confirmation before creating the
#'   template (interactive sessions only).
#'
#' @return Invisibly, the `path` the template was created in.
#' @importFrom utils download.file unzip
#' @export
#'
#' @examples
#' \dontrun{
#' init_template("shiny")
#' init_template("owner/repo@dev", path = tempdir())
#' }
init_template <- function(
  template_name = "shiny",
  path = getwd(),
  ref = NULL,
  registry = NULL,
  confirm = TRUE
) {
  resolved <- resolve_template(template_name, ref = ref, registry = registry)

  # Display a message before the prompt
  cat("Your current working directory will be:\n")
  cat(path)

  if (confirm && interactive()) {
    user_input <- tolower(
      readline(
        prompt = "Do you wish to create a project template here? (y/yes to confirm): "
      )
    )
  } else {
    user_input <- "y"
  }

  if (user_input %in% c("y", "yes")) {
    dest_dir <- path

    # Build the GitHub archive URL for the resolved repo and ref.
    zip_url <- paste0(
      "https://github.com/",
      resolved$repo,
      "/archive/",
      resolved$ref,
      ".zip"
    )

    # Define the path where the ZIP file will be saved
    temp_dir <- file.path(paste0(dest_dir, "/temp_dir"))
    dir.create(temp_dir, showWarnings = FALSE)
    # Always clean up the temporary download directory when the function exits
    on.exit(unlink(temp_dir, recursive = TRUE), add = TRUE)

    zip_dest <- file.path(temp_dir, "repo.zip") # Save ZIP file in a temporary directory

    # Download the ZIP file
    tryCatch(
      download.file(
        url = zip_url,
        destfile = zip_dest,
        mode = "wb",
        quiet = TRUE
      ),
      error = function(e) {
        stop(
          "Failed to download template from ",
          zip_url,
          ": ",
          conditionMessage(e),
          call. = FALSE
        )
      }
    )

    # Extract the ZIP file into a temporary directory
    unzip(zip_dest, exdir = temp_dir)

    # Get the name of the unzipped folder (it usually contains "-main" or "-master" at the end)
    unzipped_folder <- list.dirs(temp_dir, recursive = FALSE)[1] # Assuming the first folder is the repo

    # Copy the contents from the unzipped folder to the destination directory
    file.copy(
      list.files(
        unzipped_folder,
        full.names = TRUE,
        include.dirs = TRUE,
        all.files = TRUE,
        no.. = TRUE
      ),
      to = dest_dir,
      recursive = TRUE
    )

    cat("Project initialized.\n")
    cat("Please see documentation at: \n")
    cat(resolved$doc_url)
  } else {
    cat("Project initialization canceled.\n")
  }

  invisible(path)
}
