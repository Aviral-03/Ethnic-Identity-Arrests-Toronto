#### Preamble ####
# Purpose: Downloads and saves the data from OpenData Toronto for Police Race and Identity Based Data Collection: Arrests & Strip Searches
# Author: Aviral Bhardwaj
# Date: 24 January 2024
# Contact: aviral.bhardwaj@mail.utoronto.ca
# License: MIT
# Pre-requisites: none
# Datasets: https://open.toronto.ca/dataset/police-race-and-identity-based-data-collection-arrests-strip-searches/



#### Workspace setup ####
library(opendatatoronto)
library(tidyverse)
# Get package data

# get package
package <- show_package("police-race-and-identity-based-data-collection-arrests-strip-searches")
package

# get all resources for this package
resources <- list_package_resources("police-race-and-identity-based-data-collection-arrests-strip-searches")

# identify datastore resources; by default, Toronto Open Data sets datastore resource format to CSV for non-geospatial and GeoJSON for geospatial resources
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))

# load the first datastore resource as a sample
data <- filter(datastore_resources, row_number()==1) %>% get_resource()

# Save the data in CSV
write.csv(data, "../data/raw_data.csv")

         
