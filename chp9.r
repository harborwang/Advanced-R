
# Chapter 9 ---------------------------------------------------------------

library(purrr)
library(dplyr)

triple <- function(x) x * 3
map(1:3, triple)

map_dbl(mtcars, function(x) length(unique(x)))

## The two statements below have same output. 
map_dbl(mtcars, ~length(unique(.x)))
map_dbl(mtcars, ~length(unique(.)))

##!! . for one argument function, .x, .y for two arguments functions.

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


# 9.2.5 -------------------------------------------------------------------

trims <- c(0, 0.1, 0.2, 0.5)
x <- rcauchy(1000)

map_dbl(trims, function(trim) mean(x, trim = trim))

map_dbl(trims, ~mean(x, trim = .x))
map_dbl(trims, ~mean(x, trim = .))

map_dbl(trims, mean, x=x)

# 9.2.6 Exe  --------------------------------------------------------------

# Q3.

# try use the combination of dplyr and map.
library(palmerpenguins)

# Part B
penguins <- palmerpenguins::penguins

penguins_numeric <- map_lgl(penguins, is.numeric)
map_dbl(penguins[penguins_numeric], sd, na.rm = TRUE)

penguins %>% 
  select_if(is.numeric) %>% 
  map_dbl(sd, na.rm= TRUE)

penguins %>% 
  select_if(is.numeric) %>% 
  map_dbl(.f = mean, na.rm= TRUE)

penguins %>% 
  select_if(is.numeric) %>% 
  lapply(c(mean,sd), na.rm= TRUE)

## Use select and summarise
penguins %>% 
  select_if(is.numeric) %>% 
  summarise_all(list(mean, sd), na.rm= TRUE)

penguins %>% 
  select_if(is.numeric) %>% 
  summarise_all(list(mean = ~ mean(., na.rm= TRUE), sd = ~sd(., na.rm= TRUE))) %>% View()

# part C
penguins_factor <- map_lgl(penguins, is.factor)
map_int(penguins[penguins_factor], ~ length(levels(.x)))

## Use dplyr

penguins %>% 
  select_if(is.factor) %>% 
  summarise_all(.fun = ~length(levels(.)))

penguins %>% 
  select_if(is.factor) %>% 
  summarise_all(~length(levels(.x)))
  

# Q4 ----------------------------------------------------------------------

trials <- map(1:100, ~ t.test(rpois(10, 10), rpois(10, 7)))

names(trials[[1]])

library(ggplot2)

df_trials <- tibble::tibble(p_value = map_dbl(trials, "p.value"))

df_trials %>%
  ggplot(aes(x = p_value, fill = p_value < 0.05)) +
  #geom_dotplot(binwidth = .01) #+  
  geom_histogram() +
  theme(
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank(),
    legend.position = "top"
  )


## Q6.
formulas <- list(
  mpg ~ disp,
  mpg ~ I(1 / disp),
  mpg ~ disp + wt,
  mpg ~ I(1 / disp) + wt
)

# the code below is too clever and not easy to read. It is because formula is the 2nd argument in function lm, 
# so the var formulas is taken as the 2nd argument in lm.

models <- map(formulas, lm, data = mtcars)

models <- map(formulas, function(formula) lm(formula = formula, data = mtcars))
models

models <- map(formulas, ~ lm(formula = .x, data = mtcars))
head(models, 1)

models <- map(formulas, ~ lm(formula = ., data = mtcars))
head(models, 1)


as_mapper(~lm(formula = ., data = mtcars))


# Q 7 ---------------------------------------------------------------------

bootstrap <- function(df) {
  df[sample(nrow(df), replace = TRUE), , drop = FALSE]
}

bootstraps <- map(1:10, ~ bootstrap(mtcars))

## fit the model and pull r.squared.
bootstraps %>%
  map(~ lm(mpg ~ disp, data = .x)) %>%
  map(summary) %>%
  map_dbl("r.squared")

### step 1 fit lm models on the 10 bootstraps dataset

model_list <- bootstraps %>%
  map(~ lm(mpg ~ disp, data = .x))

####  Look one model
model_list[[1]] %>% summary() %>% names()

### step 2, summary model and pick r.squared.

model_list %>% 
  map(summary) %>% 
  map_dbl("r.squared")


# 9.3 Purrr style ---------------------------------------------------------

by_cyl <- split(mtcars, mtcars$cyl)

by_cyl %>% 
  map(~ lm(mpg ~ wt, data = .x)) %>%  # fit the lm model on each data list
  map(coef) %>%                       # pull the coef from each model
  map_dbl(2)                          # select the 2nd parameter from coef, which is the slope.
#>     4     6     8 
#> -5.65 -2.78 -2.19



# 9.4.5 -------------------------------------------------------------------


params <- tibble::tribble(
  ~ n, ~ min, ~ max,
  1L,     0,     1,
  2L,    10,   100,
  3L,   100,  1000
)

pmap(params, runif)
#> [[1]]
#> [1] 0.332
#> 
#> [[2]]
#> [1] 53.5 47.6
#> 
#> [[3]]
#> [1] 231 715 515


# 9.4.6 Exercises ---------------------------------------------------------

# Q1. -----------

map(mtcars, 1)

map_dbl(mtcars, 1) # same as head(mtcars, 1) without row name.

map_int(mtcars, 1) # error

head(mtcars, 1)

modify(mtcars, 1)  # because output of function modify has to keep the same structure of input, so it repeats 32 times with the same row names

# Q2. ----------
cyls <- split(mtcars, mtcars$cyl)

temp <- "."
paths <- file.path(temp, paste0("cyl-", names(cyls), ".csv"))
walk2(cyls, paths, write.csv)

## use iwalk

# my wrong code
# iwalk(cyls, ~ file.path(temp, paste0("cyl-", .y, ".csv")), write.csv)

# temp <- tempfile()
# dir.create(temp)

temp

cyls <- split(mtcars, mtcars$cyl)
# assign names to each sub-list, the name will be used as 2nd argument in iwalk function
names(cyls) <- file.path(temp, paste0("cyl-", names(cyls), ".csv"))
iwalk(cyls, ~ write.csv(.x, .y))

## use pipe
mtcars %>% 
  split(mtcars$cyl) %>% 
  set_names(~file.path(temp, paste0("cyl-", .x, ".csv"))) %>% 
  iwalk(~ write.csv(.x, .y))
  
  
mtcars %>% 
  split(mtcars$cyl) %>% 
  set_names(~paste0("cyl-", .x, ".csv"))   


# why .x works in set_names -----------------------------------------------

as_mapper(~paste0("cyl-", .x, ".csv"))  

cyls <- split(mtcars, mtcars$cyl)
names(cyls)

set_names(cyls, function(x) paste0("cyl-", x)) %>% names()

set_names(cyls, ~paste0("cyl-", .)) %>% names()

set_names(cyls, ~paste0("cyl-", .x)) %>% names()


paste0("cyl-", cyls)  # not in paste0

# the key is in set_names
set_names(x = cyls, nm = NULL) %>% names()

# for function set_names, if the new name is a function or formula, the function will take 
# name(x) as the input argument.
  
# Q3: ---------

# Explain how the following code transforms a data frame using functions stored in a list.
trans <- list(
  disp = function(x) x * 0.0163871,
  am = function(x) factor(x, labels = c("auto", "manual"))
)

nm <- names(trans)
mtcars[nm] <- map2(trans, mtcars[nm], function(f, var) f(var))

mtcars[nm]

mtcars[1,]
datasets::mtcars[1,]

mtcars[1,]
mtcars <- datasets::mtcars # reload the data

## Old fashion way :)
mtcars$disp <- mtcars$disp*0.0163871
mtcars$am <- factor(mtcars$am, labels = c("auto", "manual"))
mtcars[1,]












