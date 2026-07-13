test_that("init_changelog_md() writes a non-empty CHANGELOG.md at the given path", {
  dir <- file.path(tempdir(), "peacock-changelog-test")
  dir.create(dir, showWarnings = FALSE)
  on.exit(unlink(dir, recursive = TRUE), add = TRUE)

  init_changelog_md(path = dir, confirm = FALSE)

  changelog <- file.path(dir, "CHANGELOG.md")
  expect_true(file.exists(changelog))
  expect_gt(file.size(changelog), 0)
})
