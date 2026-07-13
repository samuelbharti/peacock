test_that("init_template() rejects an unknown template name with a clear error", {
  # Resolution happens before any prompt or network download, so this never
  # touches GitHub. The valid-name / owner-repo paths are not exercised here
  # because they would download a real template repository.
  expect_error(
    init_template("nope", confirm = FALSE),
    "Unknown template"
  )
})
