test_that("init_quarto() scaffolds a website by default", {
  dir <- file.path(tempdir(), "peacock-quarto-web")
  on.exit(unlink(dir, recursive = TRUE), add = TRUE)

  result <- init_quarto(path = dir, confirm = FALSE)

  expect_identical(result, dir)
  expect_true(file.exists(file.path(dir, "_quarto.yml")))
  expect_true(file.exists(file.path(dir, "index.qmd")))
  expect_true(file.exists(file.path(dir, "about.qmd")))
  expect_match(
    paste(readLines(file.path(dir, "_quarto.yml")), collapse = "\n"),
    "type: website"
  )
})

test_that("init_quarto() scaffolds a book with a bibliography", {
  dir <- file.path(tempdir(), "peacock-quarto-book")
  on.exit(unlink(dir, recursive = TRUE), add = TRUE)

  init_quarto(path = dir, type = "book", confirm = FALSE)

  expect_true(file.exists(file.path(dir, "references.bib")))
  expect_true(file.exists(file.path(dir, "intro.qmd")))
  expect_match(
    paste(readLines(file.path(dir, "_quarto.yml")), collapse = "\n"),
    "type: book"
  )
})

test_that("init_quarto() scaffolds a manuscript", {
  dir <- file.path(tempdir(), "peacock-quarto-ms")
  on.exit(unlink(dir, recursive = TRUE), add = TRUE)

  init_quarto(path = dir, type = "manuscript", confirm = FALSE)

  expect_match(
    paste(readLines(file.path(dir, "_quarto.yml")), collapse = "\n"),
    "type: manuscript"
  )
})

test_that("init_quarto() rejects an unknown type", {
  expect_error(
    init_quarto(path = tempdir(), type = "blog", confirm = FALSE),
    "should be one of"
  )
})
