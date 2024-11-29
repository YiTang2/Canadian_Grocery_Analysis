#### Preamble ####
# Purpose: Data Validation Tests for Coffee Products Analysis Dataset
# Author: Yi Tang
# Date: today
# Contact: zachary.tang@mail.utoronto.ca
# License: MIT
# Pre-requisites:None
# Any other information needed? None



#### Workspace setup ####
library(testthat)
library(arrow)

# Load the cleaned data
cleaned_data <- read_parquet("data/02-analysis_data/analysis_data.parquet")

#### TESTS ####

# Test 1: Check if the dataset is not empty
test_that("Data is not empty", {
  expect_gt(nrow(cleaned_data), 0)  # Ensure the dataset has rows
})

# Test 2: Check column names
test_that("Data has correct column names", {
  expected_columns <- c("vendor", "product_name","current_price", "old_price", "month")
  expect_named(cleaned_data, expected_columns)
})

# Test 3: Check vendor values
test_that("Vendor contains only expected values", {
  expect_setequal(unique(cleaned_data$vendor), c("Metro", "SaveOnFoods"))
})

# Test 4: Check product_name contains "coffee"
test_that("Product names contain 'coffee'", {
  expect_true(all(grepl("coffee", tolower(cleaned_data$product_name))))
})

# Test 5: Check month values are valid
test_that("Month values are between 1 and 12", {
  expect_true(all(cleaned_data$month >= 1 & cleaned_data$month <= 12))
})

# Test 6: Check current_price and old_price are numeric
test_that("Prices are numeric", {
  expect_type(cleaned_data$current_price, "double")
  expect_type(cleaned_data$old_price, "double")
})

# Test 7: Check prices are non-negative
test_that("Prices are non-negative", {
  expect_true(all(cleaned_data$current_price >= 0))
  expect_true(all(cleaned_data$old_price >= 0))
})

# Test 8: Test there is no duplicated row
test_that("Dataset has no duplicate rows", {
  # Calculate the total rows and unique rows
  total_rows <- nrow(cleaned_data)
  unique_rows <- nrow(distinct(cleaned_data))
  
  # Expect that the number of total rows equals the number of unique rows
  expect_equal(total_rows, unique_rows, 
               info = paste("Found", total_rows - unique_rows, "duplicate rows."))
})
