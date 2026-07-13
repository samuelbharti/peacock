test_that("init_shiny() writes a Dockerfile with a valid CMD (no backtick quoting)", {
  dir <- file.path(tempdir(), "peacock-shiny-docker")
  dir.create(dir, showWarnings = FALSE)
  on.exit(unlink(dir, recursive = TRUE), add = TRUE)

  init_shiny(path = dir, confirm = FALSE)

  dockerfile <- readLines(file.path(dir, "Dockerfile"))
  cmd <- grep("^CMD", dockerfile, value = TRUE)

  expect_length(cmd, 1)
  # Backticks would make R try to evaluate `/home/my_app` as a name.
  expect_no_match(cmd, "`", fixed = TRUE)
  expect_match(cmd, "/home/my_app", fixed = TRUE)
})
