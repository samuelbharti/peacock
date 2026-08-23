test_that("tool_review_template() handles zero tools without error", {
  # With `1:length(tool_name)` an empty `tool_name` produced `1:0` (c(1, 0)),
  # which errored on the zero-length index. `seq_along()` yields integer(0),
  # so no per-tool scripts are attempted.
  dir <- file.path(tempdir(), "peacock-toolrev-empty")
  dir.create(dir, showWarnings = FALSE)
  on.exit(unlink(dir, recursive = TRUE), add = TRUE)

  expect_no_error(
    tool_review_template(
      character(0),
      character(0),
      path = dir,
      confirm = FALSE
    )
  )
  expect_length(list.files(file.path(dir, "src"), pattern = "\\.R$"), 0)
})

test_that("tool_review_template() creates a src script with the tool header", {
  dir <- file.path(tempdir(), "peacock-toolrev-new")
  dir.create(dir, showWarnings = FALSE)
  on.exit(unlink(dir, recursive = TRUE), add = TRUE)

  tool_review_template(
    "toolA",
    "https://a.example",
    path = dir,
    confirm = FALSE
  )

  lines <- readLines(file.path(dir, "src", "toolA.R"))
  expect_true(any(grepl("Tool name: toolA", lines, fixed = TRUE)))
  expect_true(any(grepl("https://a.example", lines, fixed = TRUE)))

  # AI-native: agent guidance files
  expect_true(file.exists(file.path(dir, "AGENTS.md")))
  expect_true(file.exists(file.path(dir, "CLAUDE.md")))
})

test_that("tool_review_template() populates an empty existing src script", {
  dir <- file.path(tempdir(), "peacock-toolrev-emptysrc")
  dir.create(file.path(dir, "src"), recursive = TRUE, showWarnings = FALSE)
  on.exit(unlink(dir, recursive = TRUE), add = TRUE)
  file.create(file.path(dir, "src", "toolB.R")) # empty file

  tool_review_template(
    "toolB",
    "https://b.example",
    path = dir,
    confirm = FALSE
  )

  lines <- readLines(file.path(dir, "src", "toolB.R"))
  expect_true(any(grepl("Tool name: toolB", lines, fixed = TRUE)))
})

test_that("tool_review_template() leaves a non-empty src script unchanged", {
  dir <- file.path(tempdir(), "peacock-toolrev-nonempty")
  dir.create(file.path(dir, "src"), recursive = TRUE, showWarnings = FALSE)
  on.exit(unlink(dir, recursive = TRUE), add = TRUE)
  existing <- "# my own code"
  writeLines(existing, file.path(dir, "src", "toolC.R"))

  tool_review_template("toolC", "", path = dir, confirm = FALSE)

  expect_identical(readLines(file.path(dir, "src", "toolC.R")), existing)
})
