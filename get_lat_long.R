# Geocode addresses: based on the following blog post
# http://www.storybench.org/geocode-csv-addresses-r/
# NO NEED to run this script -- it is only included in case you are 
# curious how the lat/long were computed using the address

# Use dev version of ggmaps so that you can set the Google Maps API key
# devtools::install_github("dkahle/ggmap")
library(ggmap)
library(dplyr)


# Load and google maps API key (you'll need to get your own to run the script)
# source("api_key.R")
register_google(key = google_key)

# Load the raw data
library(ggmap)
raw_data <- read.csv("data/raw-shootings-2018.csv", stringsAsFactors = F) %>%
  mutate(
    lat = 0,
    long = 0, 
    city_state = paste0(City.Or.County, ", ", State)
  )

# Get addresses using the geocode function
raw_data[, c("long", "lat")] <- geocode(raw_data$city_state)

# Rename columns
data <- raw_data %>%
  select(
    date = Incident.Date,
    state = State,
    city = City.Or.County,
    address = Address,
    num_killed = X..Killed,
    num_injured = X..Injured, 
    lat, long
  )

# Write a CSV file containing raw_data to the working directory
write.csv(data, "data/shootings-2018.csv", row.names = FALSE)
