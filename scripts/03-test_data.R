#### Preamble ####
# Purpose: Downloads and saves the data from OpenData Toronto for Police Race and Identity Based Data Collection: Arrests & Strip Searches
# Author: Aviral Bhardwaj
# Date: 24 January 2024
# Contact: aviral.bhardwaj@mail.utoronto.ca
# License: MIT
# Pre-requisites: none
# Datasets: https://open.toronto.ca/dataset/police-race-and-identity-based-data-collection-arrests-strip-searches/


#### Workspace setup ####
library(tidyverse)


#### Test data ####
police_arrest_data <- read.csv("../outputs/data/cleaned_data.csv")

# Test Check year is numeric 
police_arrest_data$arrest_year == as.numeric(police_arrest_data$arrest_year)

# Test Check age group is character
police_arrest_data$age_group == as.character(police_arrest_data$age_group)

# Test check if booked values is between 0 and 1
booked_values_check <- all(police_arrest_data$booked >= 0 & police_arrest_data$booked <= 1)

# Test check if search reason is between 0 and 1
search_reason_check <- all(police_arrest_data$search_reason >= 0 & police_arrest_data$search_reason <= 1)

# Test check if year is between 2020 and 2021
police_arrest_data$arrest_year <- police_arrest_data %>%
  filter(arrest_year >= 2020 & arrest_year <= 2021)

# Check if total observations are 32000
police_arrest_data |> nrow() == 32000
