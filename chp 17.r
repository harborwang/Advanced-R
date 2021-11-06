
# chp 17  -----------------------------------------------------------------

library(rlang)
library(lobstr)

expr(mean(x, na.rm = TRUE))

capture_it <- function(x){
  expr(x)
}
capture_it(x)

capture_it_input <- function(x){
  enexpr(x)
}

capture_it_input(a+b+c)

f <- expr(f(x = 1, y = 2))

f

f$z <- 3

f[[2]] <- NULL
f
f[[3]]

attributes(f)
typeof(f)
str(f)
lobstr::ast(f(x = 1, y = 2))


# 17.7 --------------------------------------------------------------------

df <- data.frame(x = 1:5, y = sample(5))
eval_tidy(expr(x + y), df)

