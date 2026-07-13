test_that("init_template() rejects an unknown template_name with a clear error", {
  # Validation happens via match.arg() before any prompt or network download,
  # so this never touches GitHub. The valid-name path is not tested here because
  # it would download a real template repository.
  expect_error(
    init_template("nope", confirm = FALSE),
    "should be one of"
  )
})
