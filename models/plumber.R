library(plumber)
library(rstanarm)
library(tidyverse)

# Load the model
model <- readRDS("Coffee_product_pricing.rds")

# Define the model version
version_number <- "0.0.1"

# Define the variables
variables <- list(
  old_price = "The previous price of the product, numeric value.",
  vendor = "The vendor identifier, categorical - Metro or SaveOnFoods",
  month = "The month of the year, numeric (1 to 12)."
)

#* @param old_price 
#* @param vendor 
#* @param month 
#* @get /predict_price
predict_price <- function(old_price = 1.75, vendor = "SaveOnFoods", month = 6) {
  # Convert inputs to appropriate types
  old_price <- as.numeric(old_price)
  vendor <- as.character(vendor)
  month <- as.integer(month)
  
  # Prepare the payload as a data frame
  payload <- data.frame(
    old_price = old_price,
    vendor = vendor,
    month = month
  )
  
  # Extract posterior samples
  posterior_samples <- as.matrix(model)  # Convert to matrix for easier manipulation
  
  # Define the generative process for prediction
  beta_old_price <- posterior_samples[, "old_price"]
  beta_vendor <- posterior_samples[, "vendorSaveOnFoods"]
  beta_month <- posterior_samples[, "month"]
  alpha <- posterior_samples[, "(Intercept)"]
  
  # Compute the predicted value for the observation
  predicted_values <- alpha +
    beta_old_price * payload$old_price +
    beta_vendor * ifelse(payload$vendor == "SaveOnFoods", 1, 0) +
    beta_month * payload$month
  
  # Predict
  mean_prediction <- mean(predicted_values)
  
  # Store results
  result <- list(
    "estimated_price" = mean_prediction
  )
  
  return(result)
}
