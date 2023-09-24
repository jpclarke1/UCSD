#####################################

# Lab 9 

#####################################

# clear environment
rm(list=ls())

# set working directory
setwd("C:/Users/schwa/Desktop/UCSD Undergrad/Spring '23/ECON 5/Labs/Lab9")

# load required libraries for this lab
library(tidyverse)

# load ANES dataset
anes <- read_csv("lab9_anes.csv")

# Information on dataset
# This dataset is the American National Election Survey
# We discussed this survey in Week 5. It is a survey on issues related to politics
# and elections. The survey asks many "feeling thermometer" questions. 
# Here is a description of feeling thermometers 
# https://electionstudies.org/wp-content/uploads/2018/03/2007ANES_Gallup_QuestionComparisons.pdf
# Basically, a higher value of a feeling thermometer means the respondent 
# feels warmly towards that person or group. We are going to study the relationship 
# between age and feelings toward the police. The variable "police_ft" in the dataset 
# is a variable the holds "Feeling Thermometer" which corresponds to how individuals
# feel toward the police.


###########################################################################
#  The Relationship between Feeling Thermometer for Police and Age
###########################################################################

####
# Q1 Create a scatter plot using ggplot2 with the Feeling Thermometer for Police on the 
# Vertical Axis and Age on the Horizontal axis
###

ggplot(anes, aes(x = age, y = police_ft)) + geom_point() + 
  labs(x = "Age", y = "Feeling Thermometer for Police") + ggtitle("Scatter Plot of Feeling Thermometer vs. Age")

#####
## Q2 Is the relationship at all clear to you?
####
## A: No

####
## Q3 use group_by and summarize to create a dataframe
## that contains the average value of police feeling thermometer
## by each age in the data. Name this new data frame police_by_age
####

police_by_age <- anes |> group_by(age) |>
  summarize(average_police_ft = mean(police_ft, na.rm = TRUE))

average_police_18 <- police_by_age$average_police_ft[police_by_age$age == 18]
average_police_18

#####
# Q4 Using the police_by_age dataframe created above,
# Create a scatter plot using ggplot2 with the Average Feeling Thermometer on the 
# Vertical Axis and Age on the Horizontal axis.
###

ggplot(police_by_age, aes(x = age, y = average_police_ft)) + geom_point() + 
  labs(x = "Age", y = "Feeling Thermometer for Police") + ggtitle("Scatter Plot of Feeling Thermometer vs. Age")

#####
## Q5 Is the relationship clearer to you now?
####
## A: Yes


#####
# Q6 Estimate a Regression with Police Feeling Thermometer 
# as the dependent variable and age as the independent variable. 
# Use the original dataframe "anes" to estimate this regression
####
model <- lm(police_ft ~ age, data = anes)

####
## Q7: Interpret the magnitude of the slope coefficient
###
## A: there is a positive relationship between Age and Police Feeling Thermometer score for every one year
##    increase in Age, we would expect, on average, a 0.248 unit increase in the Police Feeling Thermometer score

####
## Q8: (Bonus/Optional)
## Create a scatterplot from the police_by_age data frame, just as in Q4,
## but add a line of best fit to the scatter plot
###

ggplot(police_by_age, aes(x = age, y = average_police_ft)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(x = "Age", y = "Average Police Feeling Thermometer") +
  ggtitle("Scatter Plot with Line of Best Fit")



