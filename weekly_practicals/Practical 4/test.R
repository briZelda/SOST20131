# First independent project!!!
# Analysing forest fire data using dataset sourced from (DOI) 10.24432/C5D88D, https://archive.ics.uci.edu/dataset/162/forest+fires
# visualising data

#-----------------------------------------------------------------------
# Variables used:
# X: X-axis spatial coordinate within the Montesinho park map: 1 to 9
# Y: Y-axis spatial coordinate within the Montesinho park map: 2 to 9
# month: Month of the year: 'jan' to 'dec'
# day: Day of the week: 'mon' to 'sun'
# FFMC: Fine Fuel Moisture Code index from the FWI system: 18.7 to 96.20
# represents fuel moisture of litters and other cured fine fuels->higher values = drier litter = more flammable

# DMC: Duff Moisture Code index from the FWI system: 1.1 to 291.3
# represents moisture content of loosely compacted, decomposing organic matter-> higher values = higher risk of persistent deep fires

# DC: Drought Code index from the FWI system: 7.9 to 860.6
# a numeric rating of the average moisture content of deep, densely compacted organic layers -> higher values = higher risk of persistent fire
# ISI: Initial Spread Index from the FWI system: 0.0 to 56.10 
# expected rate of fire spread w/out influence of variable qties of fuel. Higher = more spread

# temp: Temperature in Celsius degrees: 2.2 to 33.30
# RH: Relative humidity in percentage: 15.0 to 100
# wind: Wind speed in km/h: 0.40 to 9.40
# rain: Outside rain in mm/m2 : 0.0 to 6.4
# area: The burned area of the forest (in ha): 0.00 to 1090.84

# install.packages("tidyverse")
# install.packages("ggplot2")
# install.packages("gridExtra")
# install.packages("tidyr")
library(tidyverse)
library(ggplot2)
library(gridExtra)
library(tidyr)
setwd("C:/Users/Briselda/Desktop/projects/portugal_fire")
forest_fires <- read_csv("forestfires.csv")

summary(forest_fires)
str(forest_fires)
view(forest_fires)
# there are 13 columns each representing a different variable. 
# Each row represents the location of a forest fire in Portugal and relevant characteristics

# month and day = char data-> Convert them into categorical data and use FACTOR
ordering_months <- c("jan", "feb", "mar", "apr", "may", "jun",
                     "jul", "aug", "sep", "oct", "nov", "dec")

# Ordering days starting from Sunday (i.e., most calendar formats)
ordering_days <- c("sun", "mon", "tue", "wed", "thu", "fri", "sat")

# Converting variables in data set into cat data by ordering them
forest_fires$month <- factor(forest_fires$month, levels = ordering_months)
forest_fires$day <- factor(forest_fires$day, levels  = ordering_days)

str(forest_fires) # month- factor with 12 levels, day-factor with 7 levels
typeof(forest_fires$month) # int
typeof(forest_fires$day) #int

# WHEN DO MOST FOREST FIRES OCCUR? Is there a specific day they occur more freq??

FireCount_Months <- forest_fires %>%
  group_by(month) %>% 
  summarise(fires_per_month = n())

head(FireCount_Months, 12)   # from the table, most fires in the sample seem to have occurred in Aug/Sep

FireCount_Days <- forest_fires %>%
  group_by(day) %>%
  summarise(fires_per_day = n())
head(FireCount_Days, 7)  # from the table, most fires in sample seem to have occurred on Sundays

# Visually:
FireCount_Months %>% 
  ggplot(aes(x = month, y = fires_per_month)) +
  geom_col(fill = "lightgreen", colour = "darkgreen")+
  labs(x = "Month of the Year", y = "Number of forest fires recorded",
       title = "Number of forest fires by month")
# highest fire freq: Sundays, lowest fire freq = Wednesdays
FireCount_Days %>%
  ggplot(aes(x = day, y = fires_per_day)) +
  geom_col(fill = "lightblue", colour = "darkblue") +
  labs(x = "Day of the Week", y = "Number of forest fires recorded",
       title = "Number of forest fires by day of the week ")


#-----Most fires recorded in the sample seem to have occurred in the months of Aug-Sep, on Sundays followed by Fridays and Saturdays
# examining variables relating to fires by month. 
# choosing to examine against months = perhaps more interesting than daily
# changes as those may be small and mostly unrelated to the rest of the variables

# Plan: create large plot to visualise all the variables and examine which are
# most relevant

# taking the averages of each variable in attempts to stay as central as possible
monthly_averages <- forest_fires %>% 
  group_by(month) %>% 
  summarise(FFMC_mean = mean(FFMC),
            DMC_mean = mean(DMC),
            DC_mean = mean(DC),
            ISI_mean = mean(ISI),
            temp_mean = mean(temp),
            RH_mean = mean(RH),
            rain_mean = mean(rain))
# head(monthly_averages, 12) 

# Plotting them all side by side; step 1: Individual bar charts
FFMC_plot <- ggplot(monthly_averages, aes(x = month, y = FFMC_mean)) + geom_col()

DMC_plot <- ggplot(monthly_averages, aes(x = month, y = DMC_mean)) + geom_col()

DC_plot <- ggplot(monthly_averages, aes(x = month, y = DC_mean)) + geom_col()

ISI_plot <- ggplot(monthly_averages, aes(x = month, y = ISI_mean)) + geom_col()

temp_plot <- ggplot(monthly_averages, aes(x = month, y = temp_mean)) + geom_col()

RH_plot <- ggplot(monthly_averages, aes(x = month, y = RH_mean)) + geom_col()

rain_plot <- ggplot(monthly_averages, aes(x = month, y = rain_mean)) + geom_col()

grid.arrange(FFMC_plot, DMC_plot, DC_plot, ISI_plot, temp_plot, RH_plot, rain_plot, nrow = 4)

# CONCLUSIONS?
# DC and DMC show the most prominent trend, visually, following that their means'
# are highest in the months Aug-Sep which are also the months with the highest
# number of fires recorded. 
# potentially, the higher Duff Moisture Code value indicates that fuel consumption of woody fuels in duff layer increases therefore causing deeper and more persistent fires
# potentially, the higher Drought Code index in the months Aug-Sep indicates that less moisture in soil and flammables in the forest lead to more frequent forest fires#
# Higher mean temps in the months where highest number of forest fires recorded which makes sense as this increases flammability

# How severe were the forest fires recorded?
# This can be observed through the variable "area", representing the number of hectares of forest
# that burned during the fires. The higher this number, the more severe the fire

# note: because of the locality of data, it doesn't make sense to plot area against month
# this is because all areas in portugal will be in the same seasons and experience similar weather conditions, therefore month in which fires happen will not have much insight to offer unless
# we account for socioeconomic factors

# to visualise the relationship between area burned by forest fires and the rest
# of the variables (minus days and months as mentioned), use pivot
extension <- forest_fires %>% 
  pivot_longer(cols = c("FFMC", "DMC", "DC", "ISI",
                        "temp", "RH", "wind", "rain"),
               names_to = "columns", # name of the column created from flipping the variables the loooong way
               values_to = "value")  #name of the column created y the values of each corresponding variable

print(extension, n = 199)

# visualisation
ggplot(extension, aes(x = value, y = area)) +
  geom_point(alpha = 0.15, colour = "magenta") +
  facet_wrap(vars(columns), scale = "free_x") + 
  labs(title = "SeverIty of forest fires",
       x = "Variable values",
       y = "Hectares of area burned")

# everything is collected at the bottom, why

ggplot(forest_fires, aes(x = area)) + geom_histogram()  
# most fires burn around same area in hectares (control measures, human intervention, natural barriers)

# filtering for area to be less than 300 hec as this is where most observations lie

extension %>% filter(area < 300) %>%
  ggplot(aes(x = value, y = area)) +
  geom_point(alpha = 0.15, colour = "orange") +
  facet_wrap(vars(columns), scale = "free_x") +
  labs(title = "Severity of forest fires",
       x = "Variable values",
       y = "Hectares of area burned")
  

# Seeminggly direct correlation between rain and area burned -> when there is minimal rain = more hectares burned
# additionally, the higher FFMC (flammability) is, the larger the more + larger area burned

#---------EXAMINING STATISTICAL SIGNIFICANCE
# stat significance on diff variables follow report guide 
# test test


# testing if repository cloned correctly on laptop

