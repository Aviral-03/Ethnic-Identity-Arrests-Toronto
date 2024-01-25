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
library(dplyr)

#### Simulate data ####
set.seed(1008239407)
num_observation = 100
# For booked arrests, which is not always 100
num_observation_small = sample(50:100, 1, replace=TRUE)

# Fictional Ethnic Identities
sim_identities <- c("Black", "White", "South Asian", "East Asian", "Middle Eastern", "Latin American", "Southeast Asian", "Indigenous")

# Fictional Age Groups
sim_age_groups <- c("Aged 17 years and under", "Aged 18 to 24 years", "Aged 25 to 34 years", "Aged 35 to 44 years", "Aged 45 to 54 years", "Aged 55 to 64 years", "Aged 65 years and over")

simulated_arrests_data <-
  tibble(
    "arrest_year" = sample(2020:2021, num_observation, replace = TRUE),
    "percieved_race" = sample(sim_identities, num_observation, replace = TRUE),
  )

simulated_booked_data <-
  tibble(
    "arrest_year" = sample(2020:2021, num_observation_small, replace = TRUE),
    "perceived_race" = sample(sim_identities, num_observation_small, replace = TRUE),
  )


simulated_age_group_data <-
  tibble(
    "arrest_year" = sample(2020:2021, num_observation, replace = TRUE),
    "perceived_race" = sample(sim_identities, num_observation, replace = TRUE),
    "age_group" = sample(sim_age_groups, num_observation, replace = TRUE),
  )

# Group and count for simulated_arrests_data
arrests_counts <- simulated_arrests_data %>%
  group_by(arrest_year, percieved_race) %>%
  summarise(count = n(), .groups = "drop")

# Group and count for simulated_booked_data
booked_counts <- simulated_booked_data %>%
  group_by(arrest_year, perceived_race) %>%
  summarise(count = n(), .groups = "drop")

# Group and count for simulated_age_group_data
age_group_counts <- simulated_age_group_data %>%
  group_by(arrest_year, perceived_race, age_group) %>%
  summarise(count = n(), .groups = "drop")




