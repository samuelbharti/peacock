#' A changelog markdown template to document project progress
#'
#' @param path Path where markdown file is created
#' @param confirm Confirm path; logical input.
#'
#' @return Return markdown file in specified or current working directory
#' @export
#'
#' @examples
#' init_changelog_md()
init_changelog_md <- function(path = getwd(), confirm = TRUE){


  # Display a message before the prompt
  cat("You current working directory will be:\n")
  cat(path)

  if(confirm){
    user_input <- tolower(
      readline(
        prompt = "Do you wish to create a Change log MD here? (y/yes to confirm): "
      )
    )
  }else{
    user_input <- "y"
  }


  # Check if the user input is 'y' or 'yes'
  if (user_input %in% c("y", "yes")) {
    wd_path <- path

    markdown_content <- "
# CHANGELOG

``` txt
YYYY-MM-DD  John Doe

* Big Change 1
* Another Change 2
```
    "
    aa <- file.path(wd_path,"CHANGELOG.md")
    file.create(aa, showWarnings = FALSE)

    if(file.exists(aa)){
      fileConn <- file(aa)

      writeLines(
        markdown_content,
        fileConn
      )
      close(fileConn)

    }

  } else {
    cat("Change log MD initialization canceled.\n")
  }

}
