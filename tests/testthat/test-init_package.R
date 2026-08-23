test_that("init_package() scaffolds a standard R package", {
  dir <- file.path(tempdir(), "mypkg")
  on.exit(unlink(dir, recursive = TRUE), add = TRUE)

  result <- init_package(path = dir, confirm = FALSE)

  expect_identical(result, dir)
  expect_true(file.exists(file.path(dir, "DESCRIPTION")))
  expect_true(file.exists(file.path(dir, "NAMESPACE")))
  expect_true(file.exists(file.path(dir, "R", "hello.R")))
  expect_true(file.exists(file.path(dir, "tests", "testthat.R")))
  expect_true(file.exists(file.path(dir, "tests", "testthat", "test-hello.R")))
  expect_true(file.exists(file.path(dir, "air.toml")))
  expect_true(file.exists(file.path(dir, "AGENTS.md")))
  expect_true(file.exists(file.path(dir, "CLAUDE.md")))

  desc <- paste(readLines(file.path(dir, "DESCRIPTION")), collapse = "\n")
  expect_match(desc, "Package: mypkg", fixed = TRUE)
})

test_that("init_package() uses the custom title", {
  dir <- file.path(tempdir(), "fancypkg")
  on.exit(unlink(dir, recursive = TRUE), add = TRUE)

  init_package(path = dir, title = "Do Fancy Things", confirm = FALSE)

  desc <- paste(readLines(file.path(dir, "DESCRIPTION")), collapse = "\n")
  expect_match(desc, "Title: Do Fancy Things", fixed = TRUE)
})
