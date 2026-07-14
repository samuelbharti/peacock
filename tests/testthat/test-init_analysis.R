test_that("init_analysis() scaffolds the expected structure", {
  dir <- file.path(tempdir(), "peacock-analysis")
  dir.create(dir, showWarnings = FALSE)
  on.exit(unlink(dir, recursive = TRUE), add = TRUE)

  result <- init_analysis(path = dir, confirm = FALSE)

  # returns the path invisibly
  expect_identical(result, dir)

  expect_true(dir.exists(file.path(dir, "data", "raw")))
  expect_true(dir.exists(file.path(dir, "data", "processed")))
  expect_true(dir.exists(file.path(dir, "output", "figures")))
  expect_true(dir.exists(file.path(dir, "output", "tables")))

  expect_true(file.exists(file.path(dir, "README.md")))
  expect_true(file.exists(file.path(dir, ".gitignore")))
  expect_true(file.exists(file.path(dir, "R", "functions.R")))
  expect_true(file.exists(file.path(dir, "analysis", "notebook.qmd")))
  expect_true(file.exists(file.path(dir, "data", "raw", ".gitkeep")))

  # AI-native: agent guidance files
  expect_true(file.exists(file.path(dir, "AGENTS.md")))
  expect_true(file.exists(file.path(dir, "CLAUDE.md")))
  expect_match(
    paste(readLines(file.path(dir, "AGENTS.md")), collapse = "\n"),
    "agent guide"
  )
})
