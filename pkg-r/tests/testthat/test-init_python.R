test_that("init_python() scaffolds a modern src-layout project", {
  dir <- file.path(tempdir(), "my_pkg")
  on.exit(unlink(dir, recursive = TRUE), add = TRUE)

  result <- init_python(path = dir, confirm = FALSE)

  expect_identical(result, dir)
  expect_true(file.exists(file.path(dir, "pyproject.toml")))
  expect_true(file.exists(file.path(dir, "src", "my_pkg", "__init__.py")))
  expect_true(file.exists(file.path(dir, "tests", "test_basic.py")))
  expect_true(file.exists(file.path(dir, "AGENTS.md")))

  pyproject <- paste(
    readLines(file.path(dir, "pyproject.toml")),
    collapse = "\n"
  )
  expect_match(pyproject, "name = \"my_pkg\"", fixed = TRUE)
  expect_match(pyproject, "pythonpath = [\"src\"]", fixed = TRUE)
})

test_that("init_python() derives a valid module name from a hyphenated dir", {
  dir <- file.path(tempdir(), "my-cool-lib")
  on.exit(unlink(dir, recursive = TRUE), add = TRUE)

  init_python(path = dir, confirm = FALSE)

  # hyphens become underscores in the importable module directory
  expect_true(dir.exists(file.path(dir, "src", "my_cool_lib")))
})
