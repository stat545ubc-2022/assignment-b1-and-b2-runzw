library(tidyr)
library(dplyr)
library(lubridate)
library(datateachr)
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

date_planted <- c("a", "random", "object")

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
