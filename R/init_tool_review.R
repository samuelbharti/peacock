#' Initialize a project directory structure for tool review
#'
#' @param tool_name A vector of tool names
#' @param tool_url A vector of corresponding tool URLs
#' @param path Path to initial project directory
#' @param confirm User confirmation enable for setup
#' @param ...
#'
#' @return Return project structure in specified directory
#' @export
#'
#' @examples
#' tool_review_template("abc","www.abc.com")
tool_review_template <- function(tool_name, tool_url, path = getwd(),
                                 confirm = TRUE, ...){

  cat("You current working directory will be:\n")
  cat(path)

  if(confirm){
    user_input <- tolower(
      readline(
        prompt = "Do you wish to create a project template here? (y/yes to confirm): "
      )
    )
  }else{
    user_input <- "y"
  }

  if (user_input %in% c("y", "yes")) {


    if(length(tool_name) != length(tool_url)){
      print("Please provide URL or Empty qoutes for Each tool")
      break;
    }

    base_dir <- c("src","data","notebooks","configs","out","docs")
    data_dir <- c("shared","preprocessed","other","")


    script_comment <- function(x_name, x_url){
      t_name <- paste0("# Tool name: ", x_name)
      t_url <- paste0("# Tool URL: ", x_url)
      t_comment <- c("########",
                     t_name,
                     t_url,
                     "########")
      return(t_comment)
    }

    wd_path <- path

    sapply(base_dir, function(x) {

      aa <- file.path(wd_path,x)
      dir.create(aa, recursive = TRUE, showWarnings = FALSE)

      if(x == "data"){
        sapply(data_dir, function(x) {

          bb <- file.path(aa,x)
          dir.create(bb, recursive = TRUE, showWarnings = FALSE)

          if(x == "preprocessed"){
            sapply(tool_name, function(x){

              cc <- file.path(bb, x)
              dir.create(cc, recursive = TRUE, showWarnings = FALSE)

            })
          }

        })
      }

      if(x == "out"){
        sapply(tool_name, function(x){

          bb <- file.path(aa, x)
          dir.create(bb, recursive = TRUE, showWarnings = FALSE)

        })

      }

      if(x == "src"){
        sapply(1:length(tool_name), function(x){

          bb <- file.path(aa, paste0(tool_name[x],".R"))
          if(file.exists(bb)){
            file_info <- file.info(bb)
            if(is.na(file_info$size) || file_info$size == 0){
              # fileConn <- file(bb)
              # writeLines(
              #   script_comment(tool_name[x], tool_url[x]),
              #   fileConn
              # )
              # close(fileConn)
              cat("The file is empty. No changes made.\n")
            }else {
              cat("The file is not empty. No changes made.\n")
            }
          }else{
            file.create(bb, showWarnings = FALSE)
            fileConn <- file(bb)
            writeLines(
              script_comment(tool_name[x], tool_url[x]),
              fileConn
            )
            close(fileConn)
          }
        })
      }
    })
  } else {
    cat("Project initialization canceled.\n")
  }
}


