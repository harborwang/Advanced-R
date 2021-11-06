
# chp 19 ------------------------------------------------------------------

library(rlang)
library(purrr)

library(MASS)

MASS

library(MASS, character.only = TRUE)  # error


# 19.3.6 Exercises --------------------------------------------------------

f1 <- function(x, y) {
  exprs(x = x, y = y)
}
f2 <- function(x, y) {
  enexprs(x = x, y = y)
}
f1(a + b, c + d)
f2(a + b, c + d)


# 19.4 --------------------------------------------------------------------

x <- expr(-1)
expr(f(!!x, y))
#> f(-1, y)

x <- expr("a")
expr(f(x, y))

## create a mean function with na.rm = TRUE.
mean_rm <- function(var) {
  var <- ensym(var)
  expr(mean(!!var, na.rm = TRUE))
}
expr(!!mean_rm(x) + !!mean_rm(y))
#> mean(x, na.rm = TRUE) + mean(y, na.rm = TRUE)


# 19.4.8 exercise ---------------------------------------------------------

xy <- expr(x + y)
xz <- expr(x + z)
yz <- expr(y + z)
abc <- exprs(a, b, c)

expr(!!xy/!!xz)
#> (x + y) / (y + z)

expr(-(!!xy)^(!!yz))
#> -(x + z) ^ (y + z)

expr(((!!xy)) + !!yz - !!xy)
#> (x + y) + (y + z) - (x + y)

expr(atan2(!!xy, !!yz))
#> atan2(x + y, y + z)

expr(sum(!!xy, !!xy, !!yz))
#> sum(x + y, x + y, y + z)

expr(sum(!!!abc))
#> sum(a, b, c)

expr(mean(c(!!!abc), na.rum = TRUE))
#> mean(c(a, b, c), na.rm = TRUE)

expr(foo(a = !!xy, b=!!yz))
#> foo(a = x + y, b = y + z)


# 19.6.3 ------------------------------------------------------------------

# Can easily move x to first entry:
tibble::tibble(
  y = 1:5,
  z = 3:-1,
  x = 5:1,
)

tibble::tibble(
  x = 5:1,
  y = 1:5,
  z = 3:-1,  # no error

)

# Need to remove comma from z and add comma to x
data.frame(
  y = 1:5,
  z = 3:-1,
  x = 5:1
)

data.frame(  
  x = 5:1    # error
  y = 1:5,
  z = 3:-1,

)





