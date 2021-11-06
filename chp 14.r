
# chp 14 R6 ---------------------------------------------------------------

# install.packages("R6")
library(R6)

Accumulator <- R6Class("Accumulator", list(
  sum = 0,
  add = function(x = 1) {
    self$sum <- self$sum + x 
    invisible(self)
  })
)

Accumulator

x <- Accumulator$new() 
x$add(5)
x$sum

## I skipped chp 14









