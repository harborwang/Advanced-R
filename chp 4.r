x <- 1:5
x[c(1, 2)] <- c(101, 102)
x
x[1]

str(x)
str(x[1])

str(x[[1]])


x <- list(a = 1, b = 2)
x[["b"]] <- NULL
str(x)
#> List of 1
#>  $ a: num 1

y <- list(a = 1, b = 2)
y["b"] <- list(NULL)
str(y)
str(y["b"])
str(y[["b"]])

## y["b"] is a list not a number. y[["b"]] is a number.


mtcars <- datasets::mtcars

mtcars[] <- lapply(mtcars, as.integer)
is.data.frame(mtcars)

str(mtcars[])

mtcars
#> [1] TRUE

mtcars <- lapply(mtcars, as.integer)  # change mtcars to a matrix.
is.data.frame(mtcars)
str(mtcars)

#> [1] FALSE