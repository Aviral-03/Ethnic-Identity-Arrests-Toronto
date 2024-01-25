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

#### Clean data ####
# Reading the data
data <- read.csv("../inputs/data/raw_data.csv")

# Adjusting and cleaning the name of the variable
cleaned_data <- data %>% 
  clean_names() %>% 
  clean_names(case = "snake")

cleaned_data <- cleaned_data |>
  select(
    arrest_year, perceived_race, age_group_at_arrest, youth_at_arrest_under_18_years, booked, search_reason_cause_injury, search_reason_assist_escape, search_reason_possess_weapons, search_reason_possess_evidence)

# Combining the columns that are similar
cleaned_data <- cleaned_data %>%
  mutate(search_reason = case_when(
    search_reason_cause_injury == 1 ~ "1",
    search_reason_assist_escape == 1 ~ "1",
    search_reason_possess_weapons == 1 ~ "1",
    search_reason_possess_evidence == 1 ~ "1",
    TRUE ~ "0"
  ))

# Rename the columns
cleaned_data <- cleaned_data %>%
  rename(
    age_group = age_group_at_arrest,
    youth_at_arrest_under_18_years = youth_at_arrest_under_18_years
  )

# Mutating the date for age groups involving Aged 17 years and younger and Aged 17 years and under essentially they mean the same thing
cleaned_data <- cleaned_data %>%
  mutate(age_group = case_when(
    age_group == "Aged 17 years and younger" ~ "Aged 17 years and under",
    age_group == "Aged 17 years and under" ~ "Aged 17 years and under",
    TRUE ~ age_group
  ))

# Mutating for booked with NA values
cleaned_data <- cleaned_data %>%
  mutate(booked = case_when(
    is.na(booked) ~ "0",
    booked == 1 ~ "1",
    TRUE ~ "Not Booked"
  ))

cleaned_data <- cleaned_data |>
  select(
    arrest_year, perceived_race, age_group, youth_at_arrest_under_18_years, booked, search_reason)

write.csv("../outputs/data/cleaned_data.csv")
