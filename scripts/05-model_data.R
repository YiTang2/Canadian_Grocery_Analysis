#### Preamble ####
# Purpose: Development and validation of a Bayesian regression model for predicting coffee product pricing based on historical data
# Author: Yi Tang
# Date: today
# Contact: zachary.tang@mail.utoronto.ca
# License: MIT
# Pre-requisites: R, rstanarm package, and arrow package for data handling
# Any other information needed? Ensure rstanarm and arrow are properly installed and configured before running this script.




#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(arrow)

#### Read data ####
analysis_data <- read_parquet("data/02-analysis_data/analysis_data.parquet")

# Set the final coffee product pricing model
Coffee_product_pricing <-
  stan_glm(
    formula = current_price ~ old_price + month + vendor,
    data = analysis_data,
    family = gaussian(),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_aux = exponential(rate = 1, autoscale = TRUE),
    seed = 304
  )

#### Save model ####
saveRDS(
  Coffee_product_pricing,
  file = "models/Coffee_product_pricing.rds"
)
