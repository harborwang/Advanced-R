
# Chapter 9 ---------------------------------------------------------------

library(purrr)

triple <- function(x) x * 3
map(1:3, triple)

map_dbl(mtcars, function(x) length(unique(x)))

map_dbl(mtcars, ~length(unique(.x)))
as_mapper(~length(unique(.x)))

x <- map(1:3, ~runif(2))
str(x)

x <- map(1:3, function(x) runif(2))
str(x)

runif(1,2)


x <- list(
  list(-1, x = 1, y = c(2), z = "a"),
  list(-2, x = 4, y = c(5, 6), z = "b"),
  list(-3, x = 8, y = c(9, 10, 11))
)

str(x)

# Select by name
map_dbl(x, "x")
#> [1] 1 4 8

map_chr(x, "x")

# Use map_chr, I can see the value in "x" is double.

map_chr(x, 1)

# Or by position
map_dbl(x, 1)
#> [1] -1 -2 -3

# Or by both
map_dbl(x, list("y", 1))
#> [1] 2 5 9

# You'll get an error if a component doesn't exist:
map_chr(x, "z")
#> Error: Result 3 must be a single string, not NULL of length 0

# Unless you supply a .default value
map_chr(x, "z", .default = NA)
#> [1] "a" "b" NA