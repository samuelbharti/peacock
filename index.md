# peacock

The goal of peacock is to provide functions for project initialization
and workflows using pre-build templates. Templates available for R and R
Shiny projects.

## Installation

You can install the development version of peacock from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("samuelbharti/peacock")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(peacock)
## Initialize shiny project structure
init_shiny(confirm = FALSE)
#> Project initialized.
```
