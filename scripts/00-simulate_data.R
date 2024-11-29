#### Preamble ####
# Purpose: Simulates a dataset of coffee vendors
# Author: Yi Tang
# Date: today
# Contact: zachary.tang@mail.utoronto.ca
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed
# Any other information needed? None



#### Workspace setup ####
library(tidyverse)
set.seed(304)


#### Simulate data ####
# Vendor names
Vendors <- c("SaveOnFoods", "Metro")


# Generate simulated data
simulated_data <- tibble(
  Vendors = sample(c("Metro", "SaveOnFoods"), size = 1000, replace = TRUE),  # Assumed these are the vendor options
  current_price = round(runif(1000, 0, 500), 3),
  old_price = round(runif(1000, 0, 1000), 3),
  month = sample(1:12, 1000, replace = TRUE),
  coffee_product = sample(
    c("Espresso Coffee", "Vanilla Coffee", "Caramel Coffee", "Dark Roast Coffee", "Decaf Coffee"),
    size = 1000, replace = TRUE
  )
)
#### Save data ####
write_csv(simulated_data, "data/00-simulated_data/simulated_data.csv")