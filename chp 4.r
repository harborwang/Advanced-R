x <- 1:5
x[c(1, 2)] <- c(101, 102)
x[c(1, 2)]
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


# 4.5 Applications --------------------------------------------------------

## 4.5.1 Lookup tables (character subsetting)

x <- c("m", "f", "u", "f", "f", "m", "m")
lookup <- c(m = "Male", f = "Female", u = NA)
lookup[x]
#>        m        f        u        f        f        m        m 
#>   "Male" "Female"       NA "Female" "Female"   "Male"   "Male"

lookup[c("m", "f", "a", "b")]

unname(lookup[x])
#> [1] "Male"   "Female" NA       "Female" "Female" "Male"   "Male"

## 4.5.2 Matching and merging by hand (integer subsetting)

## 4.5.4 Ordering (integer subsetting)

## order() takes a vector as its input and returns an integer vector describing how to order the subsetted vector

## This is for vector only.
x <- c("b", "c", "a")
order(x)
#> [1] 3 1 2
x[order(x)]
#> [1] "a" "b" "c"

x[c(3, 1, 2)]


## 4.5.5 Expanding aggregated counts (integer subsetting)

df <- data.frame(x = c(2, 4, 1), y = c(9, 11, 6), n = c(3, 5, 1))
df
rep(1:nrow(df), df$n)
#> [1] 1 1 1 2 2 2 2 2 3

rep(df$x, df$n)
#> [1] 2 2 2 4 4 4 4 4 1

rep(df$y, df$n)

df[rep(1:nrow(df), df$n), ]
#>     x  y n
#> 1   2  9 3
#> 1.1 2  9 3
#> 1.2 2  9 3
#> 2   4 11 5
#> 2.1 4 11 5
#> 2.2 4 11 5
#> 2.3 4 11 5
#> 2.4 4 11 5
#> 3   1  6 1


## 4.5.9 Exercises

### Q1. 
# Permute columns

mtcars[sample(ncol(mtcars))]
str(mtcars[sample(ncol(mtcars))])

# random choose 5 cols.
mtcars[sample(ncol(mtcars),5)]

# Permute columns and rows in one step
mtcars[sample(nrow(mtcars)), sample(ncol(mtcars))]

# Permute 5 rows and 6 cols
mtcars[sample(nrow(mtcars),5), sample(ncol(mtcars),6)]

### Q2. 
# Permute columns
m <- 10
start <- sample(nrow(mtcars) - m + 1, 1)
end <- start + m - 1
mtcars[start:end, , drop = FALSE]

str(mtcars[start:end, ])


#Q3: How could you put the columns in a data frame in alphabetical order?
mtcars[order(names(mtcars))]
mtcars[sort(names(mtcars))]

  
  
