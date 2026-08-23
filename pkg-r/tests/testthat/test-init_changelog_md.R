test_that("init_changelog_md() writes a non-empty CHANGELOG.md at the given path", {
  dir <- file.path(tempdir(), "peacock-changelog-test")
  dir.create(dir, showWarnings = FALSE)
  on.exit(unlink(dir, recursive = TRUE), add = TRUE)

  init_changelog_md(path = dir, confirm = FALSE)

  changelog <- file.path(dir, "CHANGELOG.md")
  expect_true(file.exists(changelog))
  expect_gt(file.size(changelog), 0)
})

test_that("init_changelog_md() proceeds without prompting in non-interactive use", {
  # With confirm = TRUE in a non-interactive session, readline() previously
  # returned "" and the function silently cancelled. The interactive() guard
  # makes it proceed instead. testthat runs non-interactively.
  skip_if(interactive())

  dir <- file.path(tempdir(), "peacock-changelog-noninteractive")
  dir.create(dir, showWarnings = FALSE)
  on.exit(unlink(dir, recursive = TRUE), add = TRUE)

  init_changelog_md(path = dir, confirm = TRUE)

  expect_true(file.exists(file.path(dir, "CHANGELOG.md")))
})
