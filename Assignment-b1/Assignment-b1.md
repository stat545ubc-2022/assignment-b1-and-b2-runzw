Assignment-b1
================
2022-11-04

``` r
knitr::opts_chunk$set(echo = TRUE)
library(tidyverse)
library(datateachr)
library(testthat)
library(dplyr)
library(lubridate)
```

# Exercise 1 & 2

- Exercise 1: In this exercise, you’ll be making a function and
  fortifying it. The function need not be complicated. The function need
  not be “serious”, but shouldn’t be nonsense.

- Exercise 2: In the same code chunk where you made your function,
  document the function using roxygen2 tags. Be sure to include:

1.  Title.
2.  Function description: In 1-2 brief sentences, describe what the
    function does.
3.  Document each argument with the @param tag, making sure to justify
    why you named the parameter as you did.
4.  (Justification for naming is not often needed, but we want to hear
    your reasoning.)
5.  What the function returns, using the @return tag.

``` r
#' @title count_by_time function
#' 
#' @details Given a Date column, count the occurrence of a date unit specified by floor_unit. This could be useful when finding the pattern between values and specified time frames.
#' 
#' @param dataset, the dataset to be analyzed
#' 
#' @param date_column, name of the Date column on which to be applied the operation
#' 
#' @param floor_unit, the date unit to be counted
#' 
#' @return a N X 2 dataframe with column "time" and "count", which represents the list of date unit values and the number of their occurrence, respectively.  
#' 
count_by_time <- function(dataset, date_column, floor_unit) {
    if (!is.character(date_column)) {
        stop("The selected column must be a string.")
    }
  
    if(!(date_column %in% names(dataset))){
        stop("The selected column does not exist in the given dataset.")
    }
  
    if(!(inherits(dataset[[date_column]], 'Date'))){
        stop("The selected column must be a Date.")
    }
  
    if(!(floor_unit %in% c("year", "month", "day"))){
        stop("floor_unit must be one of year, month, or day.")
    }
    
    format_unit <- if(floor_unit == "year") "%Y" else (if(floor_unit == "month") "%b" else "%d") 
    return (dataset %>%
        drop_na(.data[[date_column]]) %>%
        mutate(date_floored = floor_date(.data[[date_column]], unit=floor_unit)) %>%
        mutate(time = format(date_floored, format_unit)) %>%
        group_by(time) %>%
        count(time, name = "count"))
}
```

# Exercise 3

Demonstrate the usage of your function with a few examples. Use one or
more new code chunks, describing what you’re doing.

Note: If you want to deliberately show an error, you can use error =
TRUE in your code chunk option.

Select Vancouver_trees as the example dataset.

``` r
head(vancouver_trees)
```

    ## # A tibble: 6 × 20
    ##   tree_id civic_number std_str…¹ genus…² speci…³ culti…⁴ commo…⁵ assig…⁶ root_…⁷
    ##     <dbl>        <dbl> <chr>     <chr>   <chr>   <chr>   <chr>   <chr>   <chr>  
    ## 1  149556          494 W 58TH AV ULMUS   AMERIC… BRANDON BRANDO… N       N      
    ## 2  149563          450 W 58TH AV ZELKOVA SERRATA <NA>    JAPANE… N       N      
    ## 3  149579         4994 WINDSOR … STYRAX  JAPONI… <NA>    JAPANE… N       N      
    ## 4  149590          858 E 39TH AV FRAXIN… AMERIC… AUTUMN… AUTUMN… Y       N      
    ## 5  149604         5032 WINDSOR … ACER    CAMPES… <NA>    HEDGE … N       N      
    ## 6  149616          585 W 61ST AV PYRUS   CALLER… CHANTI… CHANTI… N       N      
    ## # … with 11 more variables: plant_area <chr>, on_street_block <dbl>,
    ## #   on_street <chr>, neighbourhood_name <chr>, street_side_name <chr>,
    ## #   height_range_id <dbl>, diameter <dbl>, curb <chr>, date_planted <date>,
    ## #   longitude <dbl>, latitude <dbl>, and abbreviated variable names
    ## #   ¹​std_street, ²​genus_name, ³​species_name, ⁴​cultivar_name, ⁵​common_name,
    ## #   ⁶​assigned, ⁷​root_barrier

Now show the total number of trees planted each year

``` r
(count_by_time(vancouver_trees, "date_planted", "year"))
```

    ## Warning: Use of .data in tidyselect expressions was deprecated in tidyselect 1.2.0.
    ## ℹ Please use `all_of(var)` (or `any_of(var)`) instead of `.data[[var]]`

    ## # A tibble: 31 × 2
    ## # Groups:   time [31]
    ##    time  count
    ##    <chr> <int>
    ##  1 1989    300
    ##  2 1990   1145
    ##  3 1991    579
    ##  4 1992   1759
    ##  5 1993   2128
    ##  6 1994   1879
    ##  7 1995   2912
    ##  8 1996   3079
    ##  9 1997   2778
    ## 10 1998   3581
    ## # … with 21 more rows

Show the total number of trees planted each month across all years

``` r
(count_by_time(vancouver_trees, "date_planted", "month"))
```

    ## # A tibble: 12 × 2
    ## # Groups:   time [12]
    ##    time  count
    ##    <chr> <int>
    ##  1 " 1"  12138
    ##  2 " 2"  12988
    ##  3 " 3"  12299
    ##  4 " 4"   6815
    ##  5 " 5"   1549
    ##  6 " 6"    516
    ##  7 " 7"    170
    ##  8 " 8"     87
    ##  9 " 9"    127
    ## 10 "10"   2688
    ## 11 "11"  12184
    ## 12 "12"   8502

Show the total number of trees planted each day across all months

``` r
(count_by_time(vancouver_trees, "date_planted", "day"))
```

    ## # A tibble: 31 × 2
    ## # Groups:   time [31]
    ##    time  count
    ##    <chr> <int>
    ##  1 01     2259
    ##  2 02     2446
    ##  3 03     2551
    ##  4 04     2438
    ##  5 05     2482
    ##  6 06     2425
    ##  7 07     2284
    ##  8 08     2493
    ##  9 09     2250
    ## 10 10     2407
    ## # … with 21 more rows

The function throws an error when date_column is not a valid string.

``` r
date_planted <- as.Date(c("2020-01-01", "2020-01-02"))
(count_by_time(vancouver_trees, date_planted, "year"))
```

    ## Error in count_by_time(vancouver_trees, date_planted, "year"): The selected column must be a string.

It also throws an error when date_column does not exist in the dataset.

``` r
(count_by_time(vancouver_trees, "planted_date", "year"))
```

    ## Error in count_by_time(vancouver_trees, "planted_date", "year"): The selected column does not exist in the given dataset.

It also throws an error when date_column is not a Date column.

``` r
(count_by_time(vancouver_trees, "curb", "year"))
```

    ## Error in count_by_time(vancouver_trees, "curb", "year"): The selected column must be a Date.

It also throws an error when floor_unit is not a value in (“day”,
“year”, “month”).

``` r
(count_by_time(vancouver_trees, "date_planted", "hour"))
```

    ## Error in count_by_time(vancouver_trees, "date_planted", "hour"): floor_unit must be one of year, month, or day.

# Exercise 4

Running examples is a good way of checking by-eye whether your function
is working as expected. But, having a formal “yes or no” check is useful
when you move on to other parts of your analysis.

Write formal tests for your function. You should use at least three
non-redundant uses of an expect\_() function from the testthat package,
and they should be contained in a test_that() function (or more than
one). They should all pass.

``` r
count_by_year <- vancouver_trees %>%
  drop_na(date_planted) %>%
  mutate(date_floored = floor_date(date_planted, unit="year")) %>%
  mutate(time = format(date_floored, "%Y")) %>%
  group_by(time) %>%
  count(time, name = "count")

count_by_month <- vancouver_trees %>%
  drop_na(date_planted) %>%
  mutate(date_floored = floor_date(date_planted, unit="month")) %>%
  mutate(time = format(date_floored, "%b")) %>%
  group_by(time) %>%
  count(time, name = "count")

count_by_day <- vancouver_trees %>%
  drop_na(date_planted) %>%
  mutate(date_floored = floor_date(date_planted, unit="day")) %>%
  mutate(time = format(date_floored, "%d")) %>%
  group_by(time) %>%
  count(time, name = "count")

test_that("Test count_by_time function", {
  # Test if it handles "year" correctly
  expect_equal(count_by_time(vancouver_trees, "date_planted", "year"), count_by_year)
  # Test if it handles "month" correctly
  expect_equal(count_by_time(vancouver_trees, "date_planted", "month"), count_by_month)
  # Test if it handles "day" correctly
  expect_equal(count_by_time(vancouver_trees, "date_planted", "day"), count_by_day)
  # Test if it throws an error when the input column is an object
  expect_error(count_by_time(vancouver_trees, date_planted, "year"), 'The selected column must be a string.')
  # Test if it throws an error when the input column does not exist
  expect_error(count_by_time(vancouver_trees, "planted_date", "year"), 'The selected column does not exist in the given dataset.')
  # Test if it throws an error when the input column is not a Date column
  expect_error(count_by_time(vancouver_trees, "curb", "year"), 'The selected column must be a Date.')
  # Test if it throws an error when the time unit is not valid option
  expect_error(count_by_time(vancouver_trees, "date_planted", "hour"), 'floor_unit must be one of year, month, or day.')
})
```

    ## Test passed 😸
