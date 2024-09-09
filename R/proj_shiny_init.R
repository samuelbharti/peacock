#' Initialize Shiny Project using this function
#'
#' @param path  Path where shiny project template is created
#'
#' @return Return shiny project file and directory template in current working directory.
#' @examples
#' #proj_shiny_init()
#'
#' @export
proj_shiny_init <- function(path = getwd()){

  # Display a message before the prompt
  cat("You current working directory is:\n")
  cat(path)

  user_input <- tolower(
    readline(
    prompt = "Do you wish to create a project template here? (y/yes to confirm): "
    )
    )

  # Check if the user input is 'y' or 'yes'
  if (user_input %in% c("y", "yes")) {
    wd_path <- path
    shiny_dir_comp <- c("www","data","modules",
                        "userInterface","R")

    shiny_file_comp <- c("ui.R","server.R",
                         "global.R", "Dockerfile",
                         "modules/test_mod.R",
                         ".gitignore")

    #www_path <- file.path(wd_path,"www")
    www_contents <- c("css","img","js")

    global_con <- c("# Load libraries/ Source Files",
                    " ",
                    "# Load data/connections",
                    " ",
                    "# Preprocess small data",
                    " "
    )
    ui_con <- c("navbarPage(",
                "     'My app',",
                "     tabPanel('Home', home_page),",
                "     tabPanel('Other', other_tab),",
                ")"
    )
    server_con <- c("# Shiny Server",
                    "function(input, output, session) {",
                    " ",
                    "}"
    )
    docker_con <- c("# Base R Shiny image",
                    "FROM rocker/shiny",
                    " ",
                    "# Install R dependencies",
                    "RUN R -e 'install.packages()'",
                    " ",
                    "RUN mkdir home/my_app",
                    " ",
                    "# Copy the Shiny app code",
                    "COPY *.R /home/my_app",
                    " ",
                    "# Expose the application port",
                    "EXPOSE 3838",
                    " ",
                    "# Run the R Shiny app",
                    "CMD R -e 'shiny::runApp(`/home/my_app`,port = 3838, host = `0.0.0.0`)'"
    )
    test_mod <- c("# Use shinymod to generate module template")

    git_ign_con <- c(".Rproj.user",
                     ".Rhistory",
                     ".RData",
                     ".Ruserdata"
    )

    # generate shiny project dir
    sapply(shiny_dir_comp, function(x) {

      aa <- file.path(wd_path,x)
      dir.create(aa, recursive = TRUE, showWarnings = FALSE)

      if(x == "www"){
        sapply(www_contents, function(x) {

          bb <- file.path(aa,x)
          dir.create(bb, recursive = TRUE, showWarnings = FALSE)

        })
      }

    })

    # generate shiny project files

    sapply(shiny_file_comp, function(x) {

      aa <- file.path(wd_path,x)
      file.create(aa, showWarnings = FALSE)

      # Write to file
      if(file.exists(x)){
        fileConn <- file(x)

        if(x == "global.R"){
          y <- global_con
        }else if(x == "ui.R"){
          y <- ui_con
        }else if(x == "server.R"){
          y <- server_con
        }else if(x == "modules/test_mod.R"){
          y <- test_mod
        }else if(x == "Dockerfile"){
          y <- docker_con
        }else if(x == ".gitignore"){
          y <- git_ign_con
        }

        writeLines(
          y,
          fileConn
        )
        close(fileConn)

      }
    }
    )
  }
  else {
    cat("Project initialization canceled.\n")
  }


}
