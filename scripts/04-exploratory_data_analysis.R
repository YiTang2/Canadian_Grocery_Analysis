#### Preamble ####
# Purpose: Basic Exploratory Data Analysis for Coffee Prices Dataset
# Author: Yi Tang
# Date: today
# Contact: zachary.tang@mail.utoronto.ca
# License: MIT
# Pre-requisites: None.
# Any other information needed? None.


#### Workspace setup ####
library(tidyverse)
library(arrow)
library(ggplot2)

#### Read data ####
analysis_data <- read_parquet("data/02-analysis_data/analysis_data.parquet")

# Read and prepare the data
analysis_data <- read_parquet("data/02-analysis_data/analysis_data.parquet")
analysis_data <- analysis_data %>%
  mutate(month = factor(month, levels = 1:12, labels = month.abb))

# Basic Histogram for Current Price
hist(analysis_data$current_price,
     main = "Histogram of Current Prices",
     xlab = "Current Price")

# Basic Histogram for Old Price
hist(analysis_data$old_price,
     main = "Histogram of Old Prices",
     xlab = "Old Price")

# Basic Bar Chart for Month without minimal theme
ggplot(analysis_data, aes(x = month)) +
  geom_bar() +
  labs(x = "Month", y = "Frequency")

# Basic Bar Chart for Vendor without minimal theme
ggplot(analysis_data, aes(x = vendor)) +
  geom_bar() +
  labs(x = "Vendor", y = "Frequency")

