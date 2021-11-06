
# chp 12 ------------------------------------------------------------------
library(sloop)

# A base object:
is.object(1:10)
#> [1] FALSE
sloop::otype(1:10)
#> [1] "base"

x <- 1:10
class(x)
attributes(x)

y <- c(1:10)
class(y)
attributes(y)

# An OO object
is.object(mtcars)
#> [1] TRUE

### an OO object has a $class attributes
attributes(mtcars)
sloop::otype(mtcars)
#> [1] "S3"
#> 


x <- matrix(1:4, nrow = 2)
class(x)
#> [1] "matrix" "array"
sloop::s3_class(x)
#> [1] "matrix"  "integer" "numeric"

is.object(x)
attributes(x)
attr(x, "class")

# so x is not a OO object, but it is a base object.

sloop::s3_class(1)
#> [1] "double"  "numeric"
sloop::s3_class(1L)
#> [1] "integer" "numeric"

typeof(factor("x"))
#> [1] "integer"
is.numeric(factor("x"))
#> [1] FALSE

sloop::s3_class(factor("x"))

