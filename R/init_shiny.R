#' Initialize Shiny Project using this function
#'
#' @param path  Path where shiny project template is created
#'
#' @return Return shiny project file and directory template in current working directory.
#' @examples
#' #proj_shiny_init()
#'
#' @export
init_shiny <- function(path = getwd(), confirm = TRUE){


  # Display a message before the prompt
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


  # Check if the user input is 'y' or 'yes'
  if (user_input %in% c("y", "yes")) {
    wd_path <- path
    dir.create(file.path(wd_path), recursive = TRUE,
               showWarnings = FALSE)
    shiny_dir_comp <- c("www","data","modules",
                        "userInterface","R","dev")

    shiny_file_comp <- c("ui.R","server.R",
                         "global.R", "Dockerfile",
                         "modules/test_mod.R",
                         "userInterface/home_ui.R",
                         "userInterface/other_ui.R",
                         "R/load_components.R",
                         "dev/dev.R",
                         ".gitignore", ".Renviron")

    #www_path <- file.path(wd_path,"www")
    www_contents <- c("css","img","js")

    global_con <- c("# Load libraries/ Source Files",
                    "library(shiny)",
                    " ",
                    "# Load data/connections",
                    " ",
                    "# Preprocess small data",
                    " "
    )
    ui_con <- c("navbarPage(",
                "     'My app',",
                "     tabPanel('Home', home_page),",
                "     tabPanel('Other', other_page),",
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

    load_components <- c("# Load modules",
                         "sapply(list.files('modules', full.names = TRUE), function(x) source(x))",
                         "# Load user interface",
                         "sapply(list.files('userInterface', full.names = TRUE), function(x) source(x))",
                         " "
                         )

    home_userInterface <- c("home_page <- fluidPage(",
                            "# Page title",
                            "titlePanel('Home Page'),",
                            "hr(),",
                            "fluidRow(",
                            "   column(6,h2('Column size 3')),",
                            "   column(6,h2('Column size 6'))",
                            " )",
                            ")"
                            )

    other_userInterface <- c("other_page <- fluidPage(",
                            "# Page title",
                            "titlePanel('Other Page'),",
                            "hr(),",
                            "fluidRow(",
                            "   column(6,h2('Column size 3')),",
                            "   column(6,h2('Column size 6'))",
                            " )",
                            ")"
    )

    dev_r <- c("# Use this script to test code blocks for app dev.",
               "# Make sure to add this 'dev' directory",
               "# in your gitignore after template initialization."
               )

    Renviron <- c("Delete this line and enter variables with secret keys/tokens etc.")
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

      # print("In file write function")
      # print(aa)
      # Write to file
      if(file.exists(aa)){
        fileConn <- file(aa)

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
        }else if(x == "userInterface/home_ui.R"){
          y <- home_userInterface
        }else if(x == "userInterface/other_ui.R"){
          y <- other_userInterface
        }else if(x == "R/load_components.R"){
          y <- load_components
        }else if(x == "dev/dev.R"){
          y <- dev_r
        }else if(x == ".gitignore"){
          y <- git_ign_con
        }else if(x == ".Renviron"){
          y <- Renviron
        }

        writeLines(
          y,
          fileConn
        )
        close(fileConn)

      }
    }
    )
    cat("Project initialized.\n")
    cat("Please see documentation at:\n")
    cat("https://www.samuelbharti.com/posts/r-shiny-template/")
  }
  else {
    cat("Project initialization canceled.\n")
  }


}
