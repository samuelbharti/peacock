test_that("peacock_templates() lists the built-in templates", {
  tmpl <- peacock_templates()
  expect_s3_class(tmpl, "data.frame")
  expect_true(all(c("shiny", "cgds") %in% tmpl$Name))
})

test_that("resolve_template() resolves a built-in registry name", {
  r <- resolve_template("shiny")
  expect_equal(r$repo, "samuelbharti/RShiny_template")
  expect_equal(r$ref, "HEAD")
})

test_that("resolve_template() accepts an arbitrary owner/repo", {
  r <- resolve_template("someone/their-template")
  expect_equal(r$repo, "someone/their-template")
  expect_equal(r$ref, "HEAD")
  expect_match(r$doc_url, "github.com/someone/their-template", fixed = TRUE)
})

test_that("resolve_template() parses an @ref suffix", {
  r <- resolve_template("someone/repo@dev")
  expect_equal(r$repo, "someone/repo")
  expect_equal(r$ref, "dev")
})

test_that("resolve_template() lets an explicit ref override @ref", {
  r <- resolve_template("someone/repo@dev", ref = "v2.0")
  expect_equal(r$ref, "v2.0")
})

test_that("resolve_template() errors on an unknown bare name", {
  expect_error(resolve_template("nope"), "Unknown template")
})

test_that("read_registry() reads a YAML registry when yaml is available", {
  skip_if_not_installed("yaml")
  yml <- tempfile(fileext = ".yaml")
  on.exit(unlink(yml), add = TRUE)
  yaml::write_yaml(
    list(list(Name = "demo", Repo = "o/r", Ref = "HEAD", Description = "d")),
    yml
  )

  reg <- read_registry(yml)
  expect_true("demo" %in% reg$Name)
  expect_equal(reg$Repo[reg$Name == "demo"], "o/r")
})
