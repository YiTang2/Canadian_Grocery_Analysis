#### Preamble ####
# Purpose: Tests the structure and validity of the simulated vendor's data
# Author: Yi Tang
# Date: today
# Contact: zachary.tang@mail.utoronto.ca
# License: MIT
# Pre-requisites:
# - The `tidyverse` package must be installed and loaded
# - 00-simulate_data.R must have been run
# Any other information needed? None.


#### Workspace setup ####
library(tidyverse)
library(testthat)

simulated_data <- read_csv("data/00-simulated_data/simulated_data.csv", show_col_types = FALSE)
simulated_data$month <- as.integer(simulated_data$month)
#### Testing Simulated Data ####

# Test for correct column names
test_that("simulated_data has correct column names", {
  expect_named(simulated_data, c("Vendors", "current_price", "old_price", "month", "coffee_product"))
})

# Test column types
test_that("Vendors column is of type character", {
  expect_type(simulated_data$Vendors, "character")
})

test_that("current_price column is of type double", {
  expect_type(simulated_data$current_price, "double")
})

test_that("old_price column is of type double", {
  expect_type(simulated_data$old_price, "double")
})

test_that("month column is of type integer", {
  expect_type(simulated_data$month, "integer")
})

# Test Vendors contains only "loblaws" and "metro"
test_that("Vendors column contains only 'saveonfoods' and 'metro'", {
  expect_setequal(unique(simulated_data$Vendors), Vendors)
})
# Test current_price range
test_that("current_price values are within the range 0-500", {
  expect_true(all(simulated_data$current_price >= 0 & simulated_data$current_price <= 500))
})

# Test old_price range
test_that("old_price values are within the range 0-1000", {
  expect_true(all(simulated_data$old_price >= 0 & simulated_data$old_price <= 1000))
})

# Test month range
test_that("month values are within the range 1-12", {
  expect_true(all(simulated_data$month >= 1 & simulated_data$month <= 12))
})
