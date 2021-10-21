
# 6.1 ---------------------------------------------------------------------


x <- 10
f1 <- function(x) {
  function() {
    x + 10
  }
}
f1(1)()


f2 <- function(a, b) {
  a * 10
}
f2(10, stop("This is an error!"))


# 6.2 ---------------------------------------------------------------------

f02 <- function(x, y) {
  # A comment
  x + y
}

formals(f02)
#> $x
#> 
#> 
#> $y

body(f02)
#> {
#>     x + y
#> }

environment(f02)
#> <environment: R_GlobalEnv>

## print the source code of a function: use the attr "srcref" - Source Reference.
attr(f02, "srcref")
#> function(x, y) {
#>   # A comment
#>   x + y
#> }

# 6.2.3 First-class functions

lapply(mtcars, function(x) length(unique(x)))
Filter(function(x) !is.numeric(x), mtcars)
integrate(function(x) sin(x) ^ 2, 0, pi)

# 6.2.5 Exercise

# code to get all the functions in base. 
objs <- mget(ls("package:base", all = TRUE), inherits = TRUE)
funs <- Filter(is.function, objs)

library(purrr)

n_args <- funs %>% 
  map(formals) %>%
  map_int(length)

n_args %>% 
  sort(decreasing = TRUE) %>%
  head()
#> scan format.default source
#> 22 16 16
#> formatC library merge.data.frame
#> 15 13 13




x <- 1
g04 <- function() {
  y <- 2
  i <- function() {
    z <- 3
    c(x, y, z)
  }
  i()
}
g04()

c <- 10
c(c = c)

# operator &
x_ok <- function(x) {
  print(x)
  print(x>0)
  print(!is.null(x))
  print(length(x))
  print(length(x)==1)
  !is.null(x) & length(x) == 1 & x > 0
}

x_ok(NULL)
#> logical(0)
x_ok(1)
#> [1] TRUE
x_ok(1:3)
#> [1] FALSE FALSE FALSE

# Not sure what the code below does!!!
cleanup <- function(dir, code) {
  old_dir <- setwd(dir)
  
  setwd("~/Documents")
  browser()
  getwd()
  on.exit(setwd(old_dir), add = TRUE)
  
  old_opt <- options(stringsAsFactors = FALSE)
  on.exit(options(old_opt), add = TRUE)
}

cleanup(dir = "~/Documents/GitHub", code = "chp 4.r")

