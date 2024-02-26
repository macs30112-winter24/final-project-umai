install.packages("plotly")
library(plotly)
library(ggplot2)
#read data
setwd("C:/Users/13945/Desktop/data mgmt/umai")
chi_household <- read.csv(file = "C:/Users/13945/Desktop/data mgmt/umai/chi_data_for_regression.csv")
la_household <- read.csv(file = "C:/Users/13945/Desktop/data mgmt/umai/lax_final_for_regression.csv")
nyc_household <- read.csv(file = "C:/Users/13945/Desktop/data mgmt/umai/nyc_final_for_regression.csv")
neighbor_level <- read.csv(file = "C:/Users/13945/Desktop/data mgmt/umai/neighborhood_level_regression.csv")

#household level for Chicago
chi_household$PROP_TYPE <- factor(chi_household$PROP_TYPE)
chi_household$dominant.race <- factor(chi_household$dominant.race)

chicago_reg <- lm(PRICE ~ SQFT + house.age + PROP_TYPE + PARK_DIST + HOSPITAL_D + RAIL_DIST + BUS_COUNTS + FnB_COUNTS + population.density + median.age + dominant.race, data=chi_household)
summary(chicago_reg)

#visualization for Chicago
ggplot(chi_household, aes(x = SQFT, y = PRICE)) + 
  geom_point() + 
  geom_smooth(method = "lm", se = FALSE) +
  labs(x = "Square Feet (SQFT)", y = "Price", title = "Relationship between Price and SQFT in Chicago") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))

ggplot(chi_household, aes(x = PROP_TYPE, y = PRICE)) +
  geom_violin(trim = FALSE) +
  labs(x = "Property Type", y = "Price", title = "Price Distribution by Property Type in Chicago") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  theme(plot.title = element_text(hjust = 0.5))

ggplot(chi_household, aes(x = dominant.race, y = PRICE)) +
  geom_boxplot() +
  labs(x = "Dominant Race", y = "Price", title = "Price Distribution by Dominant Race in Chicago") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  theme(plot.title = element_text(hjust = 0.5))

p <- plot_ly(data = chi_household, x = ~SQFT, y = ~population.density, z = ~PRICE, type = 'scatter3d', mode = 'markers',
             marker = list(size = 2)) %>%  
  layout(title = '3D plot of Average Price by SQFT and Population Density in Chicago',
         scene = list(xaxis = list(title = 'SQFT'),
                      yaxis = list(title = 'Population Density'),
                      zaxis = list(title = 'Average Price')))
p



#household level for LA
la_household$PROP_TYPE <- factor(la_household$PROP_TYPE)
la_household$dominant.race <- factor(la_household$dominant.race)

la_all_reg <- lm(ln_PRICE ~ ln_SQFT + age + PROP_TYPE + ln_PARK_DIST + ln_HOSPITAL_D + ln_RAIL_DIST + ln_BUS_COUNTS + FnB_COUNTS + ln_population.density + ln_median.age + dominant.race, data=la_household)
summary(la_all_reg)

#visualization for LA
ggplot(la_household, aes(x = SQFT, y = PRICE)) + 
  geom_point() + 
  geom_smooth(method = "lm", se = FALSE) +
  labs(x = "Square Feet (SQFT)", y = "Price", title = "Relationship between Price and SQFT in LA") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))

ggplot(la_household, aes(x = PROP_TYPE, y = PRICE)) +
  geom_violin(trim = FALSE) +
  labs(x = "Property Type", y = "Price", title = "Price Distribution by Property Type in LA") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  theme(plot.title = element_text(hjust = 0.5))

ggplot(la_household, aes(x = dominant.race, y = PRICE)) +
  geom_boxplot() +
  labs(x = "Dominant Race", y = "Price", title = "Price Distribution by Dominant Race in LA") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  theme(plot.title = element_text(hjust = 0.5))

p <- plot_ly(data = la_household, x = ~SQFT, y = ~population.density, z = ~PRICE, type = 'scatter3d', mode = 'markers',
             marker = list(size = 2)) %>%  
  layout(title = '3D plot of Average Price by SQFT and Population Density in LA',
         scene = list(xaxis = list(title = 'SQFT'),
                      yaxis = list(title = 'Population Density'),
                      zaxis = list(title = 'Average Price')))
p


#household level for NYC
nyc_household$PROP_TYPE <- factor(nyc_household$PROP_TYPE)
nyc_household$dominant.race <- factor(nyc_household$dominant.race)

nyc_reg <- lm(PRICE ~ SQFT + house.age + PROP_TYPE + PARK_DIST + HOSPITAL_D + RAIL_DIST + BUS_COUNTS + FnB_COUNTS + population.density + median.age + dominant.race, data=nyc_household)
summary(nyc_reg)

#visualization for NYC
ggplot(nyc_household, aes(x = SQFT, y = PRICE)) + 
  geom_point() + 
  geom_smooth(method = "lm", se = FALSE) +
  labs(x = "Square Feet (SQFT)", y = "Price", title = "Relationship between Price and SQFT in NYC") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))

ggplot(nyc_household, aes(x = PROP_TYPE, y = PRICE)) +
  geom_violin(trim = FALSE) +
  labs(x = "Property Type", y = "Price", title = "Price Distribution by Property Type in NYC") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  theme(plot.title = element_text(hjust = 0.5))

ggplot(nyc_household, aes(x = dominant.race, y = PRICE)) +
  geom_boxplot() +
  labs(x = "Dominant Race", y = "Price", title = "Price Distribution by Dominant Race in NYC") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  theme(plot.title = element_text(hjust = 0.5))

p <- plot_ly(data = nyc_household, x = ~SQFT, y = ~population.density, z = ~PRICE, type = 'scatter3d', mode = 'markers',
             marker = list(size = 2)) %>%  
  layout(title = '3D plot of Average Price by SQFT and Population Density in NYC',
         scene = list(xaxis = list(title = 'SQFT'),
                      yaxis = list(title = 'Population Density'),
                      zaxis = list(title = 'Average Price')))
p

#neighborhood level
neighbor_reg <- lm(average_PRICE ~ SQFT + house.age + PROP_TYPE + PARK_DIST + HOSPITAL_D + RAIL_DIST + BUS_COUNTS + FnB_COUNTS + population.density + median.age + dominant.race, data=neighbor_level)
summary(neighbor_reg)

#visualization neighborhood level
ggplot(neighbor_reg, aes(x = SQFT, y = average_PRICE)) + 
  geom_point() + 
  geom_smooth(method = "lm", se = FALSE) +
  labs(x = "Square Feet (SQFT)", y = "Price", title = "Relationship between Price and SQFT in Neighborhood Level") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))

ggplot(neighbor_reg, aes(x = PROP_TYPE, y = average_PRICE)) +
  geom_violin(trim = FALSE) +
  labs(x = "Property Type", y = "Price", title = "Price Distribution by Property Type in Neighborhood Level") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  theme(plot.title = element_text(hjust = 0.5))

ggplot(neighbor_reg, aes(x = dominant.race, y = average_PRICE)) +
  geom_boxplot() +
  labs(x = "Dominant Race", y = "Price", title = "Price Distribution by Dominant Race in Neighborhood Level") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  theme(plot.title = element_text(hjust = 0.5))

p <- plot_ly(data = neighbor_level, x = ~SQFT, y = ~population.density, z = ~average_PRICE, type = 'scatter3d', mode = 'markers',
             marker = list(size = 2)) %>%  
  layout(title = '3D plot of Average Price by SQFT and Population Density in Neighborhood Level',
         scene = list(xaxis = list(title = 'SQFT'),
                      yaxis = list(title = 'Population Density'),
                      zaxis = list(title = 'Average Price')))
p


