#' Initialize a template repository from GitHub Templates
#'
#' @param template_name Name of template. "shiny", "cgds"
#' @param path Path where project template will be created.
#'
#' @return Return project structure from selected github template at path specified.
#' @export
#'
#' @examples
init_template <- function(template_name, path) {

  # Display a message before the prompt
  cat("You current working directory will be:\n")
  cat(path)

  user_input <- tolower(
    readline(
      prompt = "Do you wish to create a project template here? (y/yes to confirm): "
    )
  )

  if (user_input %in% c("y", "yes")) {

  dest_dir = path

  if(template_name == "shiny"){
    repo_url = "https://github.com/samuelbharti/RShiny_template"
    doc_url = "https://www.samuelbharti.com/posts/r-shiny-template/"
  }else if(template_name == "cgds"){
    repo_url = "https://github.com/uab-cgds-worthey/cgds_repo_template"
    doc_url = repo_url
  }

  # Modify the GitHub repo URL to point to the ZIP file
  zip_url <- paste0(repo_url, "/archive/refs/heads/main.zip")

  # Define the path where the ZIP file will be saved
  temp_dir <- file.path(paste0(dest_dir,"/temp_dir"))
  dir.create(temp_dir)

  zip_dest <- file.path(temp_dir, "repo.zip")  # Save ZIP file in a temporary directory

  # Download the ZIP file
  download.file(url =  zip_url, destfile =  zip_dest, mode = "wb", quiet = TRUE)

  # Extract the ZIP file into a temporary directory
  unzip(zip_dest, exdir = temp_dir)

  # Get the name of the unzipped folder (it usually contains "-main" or "-master" at the end)
  unzipped_folder <- list.dirs(temp_dir, recursive = FALSE)[1]  # Assuming the first folder is the repo

  # Copy the contents from the unzipped folder to the destination directory
  file.copy(list.files(unzipped_folder,
                       full.names = TRUE,
                       include.dirs = TRUE,
                       all.files = TRUE, no.. = TRUE),
            to = dest_dir,
            recursive = TRUE)

  # Remove the ZIP file after extraction
  unlink(temp_dir, recursive = TRUE)

  cat("Project initialized.\n")
  cat("Please see documentation at: \n")
  cat(doc_url)

  } else {
    cat("Project initialization canceled.\n")
  }


}
