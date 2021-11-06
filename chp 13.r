
# chp 13 ------------------------------------------------------------------

library(sloop)

f <- factor(c("a", "b", "c"))

typeof(f)
#> [1] "integer"
attributes(f)
#> $levels
#> [1] "a" "b" "c"
#> 
#> $class
#> [1] "factor"

unclass(f)
#> [1] 1 2 3
#> attr(,"levels")
#> [1] "a" "b" "c"

ftype(print)
#> [1] "S3"      "generic"
ftype(str)
#> [1] "S3"      "generic"
ftype(unclass)
#> [1] "primitive"
#> 

print(f)
#> [1] a b c
#> Levels: a b c

# stripping class reverts to integer behaviour
print(unclass(f))
#> [1] 1 2 3
#> attr(,"levels")
#> [1] "a" "b" "c"


# function str() is a generic function
time <- strptime(c("2017-01-01", "2020-05-04 03:21"), "%Y-%m-%d")
time
str(time)
#>  POSIXlt[1:2], format: "2017-01-01" "2020-05-04"

attributes(time)

str(unclass(time))
#> List of 9
#>  $ sec  : num [1:2] 0 0
#>  $ min  : int [1:2] 0 0
#>  $ hour : int [1:2] 0 0
#>  $ mday : int [1:2] 1 4
#>  $ mon  : int [1:2] 0 4
#>  $ year : int [1:2] 117 120
#>  $ wday : int [1:2] 0 1
#>  $ yday : int [1:2] 0 124
#>  $ isdst: int [1:2] 0 0
#>  - attr(*, "tzone")= chr "UTC"

s3_dispatch(print(f))
#> => print.factor
#>  * print.default

s3_dispatch(str(time))
#> => str.POSIXt
#> * str.default

s3_dispatch(str(unclass(time)))

#> str.list
#> => str.default

ftype(t.test)
#> [1] "S3"      "generic"
ftype(t.data.frame)
#> [1] "S3"     "method"

ftype(print.factor)

ftype(str)

ftype(str.POSIXt) # have error.

weighted.mean.Date
#> Error in eval(expr, envir, enclos): object 'weighted.mean.Date' not found

s3_get_method(weighted.mean.Date)
#> function (x, w, ...) 
#> .Date(weighted.mean(unclass(x), w, ...))
#> <bytecode: 0x7f9682f700b8>
#> <environment: namespace:stats>

s3_get_method(str.POSIXt)



# 13.2.1 Exercises --------------------------------------------------------

#Q4.

set.seed(1014)
some_days <- as.Date("2017-01-31") + sample(10, 5)

mean(some_days)
#> [1] "2017-02-06"

unclass(some_days)
mean(unclass(some_days))
#> [1] 17203


# 13.3 Classes --------------------------------------------------------------------

# Create a linear model
mod <- lm(log(mpg) ~ log(disp), data = mtcars)
class(mod)

print(mod)

# Turn it into a date (?!)
class(mod) <- "Date"

# Unsurprisingly this doesn't work very well
print(mod)
#> Error in as.POSIXlt.Date(x): 'list' object cannot be coerced to type 'double'









