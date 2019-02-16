# a5 Data Report

# comments

################################################################################
# Setup
################################################################################

# Install (if not installed) + load dplyr package
library(dplyr)

# Read in `shootings-2018.csv` data using a *relative path*
shootings_2018 <- read.csv("data/shootings-2018.csv", stringsAsFactors = F)

# str(shootings_2018)
# View(shootings_2018)

################################################################################
# Summary information
################################################################################
# To start your report, you should summarize relevant features of your dataset. 
# Write a paragraph providing a high-level overview of shootings in the US, based 
# on the dataset. This should provide your reader with a sense of scale of the 
# issue such as:

# How many shootings occurred? 
num_shootings <- nrow(shootings_2018)

# How many lives were lost?  1720
lives_lost <- sum(shootings_2018$num_killed)

# Which cities that were most impacted (you can decide how to measure "impact")?
most_impacted_city <- shootings_2018 %>% 
  mutate(death_and_injuries = num_killed + num_injured) %>% 
  arrange(-death_and_injuries) %>%
  top_n(5)

# At least one other insight of your choice.
most_impacted_state <- shootings_2018 %>% 
  select(state, num_killed, num_injured) %>% 
  group_by(state) %>% 
  summarise_all(sum) %>% 
  mutate(state_death_and_injuries = num_killed + num_injured) %>% 
  arrange(-state_death_and_injuries) %>%
  top_n(5)

# Data in this paragraph should reference values that you calculate in R, and 
# should not simply be typed as text into the paragraph.

################################################################################
# Summary Table
################################################################################
# To show a set of quantitative values to your user, you should include a well 
# formatted summary table of your interest. This should not just be the raw data, 
# but instead should an aggregate table of information. How you would like to 
# aggregate the information (by city, state, month, day of the week, etc.) is up 
# to you. Make sure to include accompanying text that describes the important 
# insights from the table. 

summary_table <- shootings_2018 %>% 
  select(state, city, num_killed, num_injured) %>% 
  top_n(10)

################################################################################
# Description of a particular incident
################################################################################
# Your report will include a paragraph (4+ sentences) of in-depth information 
# about a particular (single) incident. You should provide your reader with 
# relevant information from the dataset, such as the date and location of the 
# incident, as well as the number of people impacted (injured, killed). You 
# should include a link to at least one outside resource (not found in the data). 
# Data in this paragraph should reference values that you calculate in R, and 
# should not simply be typed as text into the paragraph.
most_killed_incident <- shootings_2018 %>%
  filter(num_killed == max(num_killed))

################################################################################
# An interactive map
################################################################################
# While maps are not always the most appropriate visual representation of 
# geographic data, they are extraordinarily popular and attract broad audiences. 
# You'll build an interactive map that shows a marker at the location of each 
# shooting. On your map, manipulate the appearance (size, color, etc.) of the 
# markers based on the underlying dataset (# injured, # killed, etc.). The map 
# should be appropriately labeled, and detailed information should be shown to 
# the user when they hover over each point. Choice of plotting library is up to 
# you, though I suggest you consult the interactive visualization chapter of the 
# book -- remember, the map must be interactive, so ggplot2 is probably not the 
# best choice.

# leaflet

################################################################################
# A plot of your choice
################################################################################
# In addition to the interactive map, you will build an additional plot of your 
# choice. You can do this using the package of your choice, such as ggplot2, 
# plotly, bokeh, or others. As you create your chart, be sure to consider what 
# questions it answers for your audience. Similarly to your map, you should 
# integrate your plot seamlessly with the rest of your report, and 
# reference/describe it in your text. Regardless of library, the chart should 
# have meaningful and clear title, axis labels, and legend (if appropriate). 
#
# You should provide a defense of why you chose the chart by highlighting the 
# insights gained from the chart you build.

# ggplot2