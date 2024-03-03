library(tidyverse)
library(dplyr)
library(stats)
library(rio)
library(naniar)
library(jtools)
library(Hmisc)
library(mice)
library(plotly)
library(ggplot2)
library(patchwork)

#read data
setwd("C:/Users/13945/Desktop/data mgmt/umai")
chi_household <- read.csv(file = "C:/Users/13945/Desktop/data mgmt/umai/chi_final_for_regression.csv")
la_household <- read.csv(file = "C:/Users/13945/Desktop/data mgmt/umai/lax_final_for_regression.csv")
nyc_household <- read.csv(file = "C:/Users/13945/Desktop/data mgmt/umai/nyc_final_for_regression.csv")
neighbor_level <- read.csv(file = "C:/Users/13945/Desktop/data mgmt/umai/neighborhood_level_regression.csv")

#household level for Chicago
chicago_reg <- lm(PRICE ~ SQFT + house.age + PROP_TYPE + PARK_DIST + HOSPITAL_D + RAIL_DIST + BUS_COUNTS + FnB_COUNTS, data=chi_household)
summ(chicago_reg)

#household level for LA
la_reg <- lm(PRICE ~ SQFT + house.age + PROP_TYPE + PARK_DIST + HOSPITAL_D + RAIL_DIST + BUS_COUNTS + FnB_COUNTS, data=la_household)
summ(la_reg)


#household level for NYC
nyc_reg <- lm(PRICE ~ SQFT + house.age + PROP_TYPE + PARK_DIST + HOSPITAL_D + RAIL_DIST + BUS_COUNTS + FnB_COUNTS, data=nyc_household)
summ(nyc_reg)

#neighborhood level
neighbor_level$PROP_TYPE <- factor(neighbor_level$PROP_TYPE)
neighbor_level$dominant.race <- factor(neighbor_level$dominant.race, levels = c("White", "Asian" ,"Black", "Hispanic or Latino"))

neighbor_reg <- lm(average_PRICE ~ SQFT + house.age + PROP_TYPE + PARK_DIST + HOSPITAL_D + RAIL_DIST + BUS_COUNTS + FnB_COUNTS + population.density + median.age + dominant.race, data=neighbor_level)
summ(neighbor_reg)

# Plot regression line with dots and shaded confidence intervals
#Correlation between SQFT and price
psqft <- ggplot(neighbor_level, aes(x = SQFT, y = average_PRICE)) +
  geom_point(color = "#063970", size = 1) +
  geom_smooth(method = "lm", se = TRUE, color = "darkgrey", fill = "lightgrey") +
  labs(title = "SQFT",
       x = "Square Footage",
       y = "Price") +
  theme_minimal()

#Correlation between house age and price
phouse_age <- ggplot(neighbor_level, aes(x = house.age, y = average_PRICE)) +
  geom_point(color = "#063970", size = 1) +
  geom_smooth(method = "lm", se = TRUE, color = "darkgrey", fill = "lightgrey") +
  labs(title = "House Age",
       x = "House Age",
       y = "Price") +
  theme_minimal()

#Correlation between park distance and price
ppark_dist <- ggplot(neighbor_level, aes(x = PARK_DIST, y = average_PRICE)) +
  geom_point(color = "#063970", size = 1) +
  geom_smooth(method = "lm", se = TRUE, color = "darkgrey", fill = "lightgrey") +
  labs(title = "Park Distance",
       x = "Park Distance",
       y = "Price") +
  theme_minimal()

#Correlation between bus stop counts and price
pbus_count <- ggplot(neighbor_level, aes(x = BUS_COUNTS, y = average_PRICE)) +
  geom_point(color = "#063970", size = 1) +
  geom_smooth(method = "lm", se = TRUE, color = "darkgrey", fill = "lightgrey") +
  labs(title = "Bus Stop Count",
       x = "Bus Stop Count",
       y = "Price") +
  theme_minimal()

#Correlation between Asian as dominant race and price
coef_ci <- confint(neighbor_reg)
prace <- ggplot(neighbor_level, aes(x = dominant.race, y = average_PRICE, color = dominant.race)) +
  geom_point(size = 1) +
  labs(title = "Dominant Race",
       x = "Dominant Race",
       y = "Price") +
  scale_color_manual(values = c('#063970', '#ff0039', '#063970', '#063970'),
                     labels = c('Others', 'Asian')) +
  theme_minimal() +
  theme(legend.position = "none")

#Combine graphs for visualization
psqft+ppark_dist+prace+phouse_age+pbus_count




