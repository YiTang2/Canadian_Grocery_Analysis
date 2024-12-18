# Canadian Grocery Coffee Products Pricing

## Overview

This paper investigates the factors that influence the current pricing of coffee products in Canadian grocery stores, focusing primarily on historical price data, seasonal trends, and vendor differences. The study uses a Bayesian multiple linear regression model to analyze how these variables affect current prices. The results indicate that historical prices are the strongest predictor of current coffee prices, with significant differences also observed between vendors such as Metro and SaveOnFoods. Seasonal trends show smaller but notable effects. The findings try to inform retail pricing strategies by understanding the impact of past prices, vendor-specific dynamics, and seasonal factors on coffee pricing in the market.

## File Structure

The repo is structured as:


-   `data/simulated_data` contains the simulated data with analysis data.
-   `data/raw_data` contains the raw data as obtained from Hammer Grocery Price dataset.
-   `data/analysis_data` contains the cleaned dataset that was constructed.
-   `model` contains fitted models for data and API which allows the user to enter input and get a predicted price.
-   `other` contains relevant literature and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate (00-simulate_data.R), test simulated data (01-test_simulated_data.R), clean (02-clean_data.R), test cleaned data (03-test_analysis_data.R), EDA (04-exploratory_data_analysis.R) and model (05-model_data.R).


## Statement on LLM usage

I confirm that no LLM tools were used in this paper.
