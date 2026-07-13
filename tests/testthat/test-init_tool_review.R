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
