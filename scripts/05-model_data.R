#### Preamble ####
# Purpose: Development and validation of two different model for predicting coffee product pricing based on historical data
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
library(caret)

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

#### Save Bayesian model ####
saveRDS(
  Coffee_product_pricing,
  file = "models/Coffee_product_pricing.rds"
)

# Frenquentist model

Coffee_product_pricing2 <- glm(current_price ~ old_price + month + vendor,
  data = analysis_data,
  family = gaussian()
)

#### Save Frenquentist model ####
saveRDS(
  Coffee_product_pricing2,
  file = "models/Coffee_product_pricing2.rds"
)

# Train-Test Split

set.seed(304)
train_indices <- sample(1:nrow(analysis_data), size = 0.8 * nrow(analysis_data))
train_data <- analysis_data[train_indices, ]
test_data <- analysis_data[-train_indices, ]

# Fit the stan_glm model

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

# Fit the glm model
Coffee_product_pricing2 <- glm(
  formula = current_price ~ month + vendor + old_price,
  data = train_data,
  family = gaussian()
)

# Predictions on the test set
# For stan_glm
stan_preds <- posterior_predict(Coffee_product_pricing, newdata = test_data)
stan_preds_mean <- apply(stan_preds, 2, mean) # Predicted values

# For glm
glm_preds <- predict(Coffee_product_pricing2, newdata = test_data, type = "response") # Predicted values

# Evaluate Performance
# Mean Squared Error
stan_mse <- mean((stan_preds_mean - test_data$current_price)^2)
glm_mse <- mean((glm_preds - test_data$current_price)^2)

# Print Results
cat("Bayesian GLM Model MSE:", stan_mse, "\n")
cat("GLM Model MSE:", glm_mse, "\n")
