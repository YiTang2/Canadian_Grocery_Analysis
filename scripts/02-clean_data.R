#### Preamble ####
# Purpose: Data Cleaning and Preparation for Coffee Product Analysis
# Author: Yi Tang
# Date: today
# Contact: zachary.tang@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Any other information needed? None

#### Workspace setup ####
library(tidyverse)
library(arrow)
library(janitor)
library(lubridate)

#### Clean data ####
raw_data <- read_csv("data/01-raw_data/hammer-4-raw.csv", show_col_types = FALSE)
product_data <- read_csv("data/01-raw_data/hammer-4-product.csv", show_col_types = FALSE)

# Combine and clean the data
combined_data <- raw_data |>
  inner_join(product_data, by = c("product_id" = "id")) |>
  select(nowtime, 
         vendor, 
         product_id, 
         product_name, 
         brand, 
         current_price, 
         old_price, 
         units, 
         price_per_unit)


cleaned_data <- combined_data |>
  filter(vendor %in% c("Metro", "SaveOnFoods")) |>
  select(vendor, product_name, current_price, old_price, nowtime) |>
  mutate(month = month(nowtime),
         current_price = parse_number(current_price),
         old_price = parse_number(old_price)) |>
  filter(str_detect(tolower(product_name), "coffee")) |>
  select(vendor, product_name, current_price, old_price, month) |>
  tidyr::drop_na() |>
  distinct()

#### Save data ####
write_parquet(x = cleaned_data,
              sink = "data/02-analysis_data/analysis_data.parquet")
