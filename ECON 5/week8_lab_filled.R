##########################
# Week 8 LAB
##########################

## GGPLOT2 -- All questions should be answered using 
## ggplot2 functions

# setup 
rm(list=ls())
setwd("C:/Users/schwa/Desktop/UCSD Undergrad/Spring '23/ECON 5/Labs/Lab8")
# libraries 
library(tidyverse)

##################
# GME PRICE OVER TIME
##################

# 1. In this part of the question we are going to study 
# how the price of Gamestop stock has evolved over time
# The gme_clean.csv is a file with the daily stock prices.
# Because a stock price changes over the course of the 
# day it has the price at opening, the high and low price of the day
# as well as the closing price of the day.

# load the data 
gme <- read_csv("gme_clean.csv")

# create a basic line plot in ggplot2 using the geom_line() function
# closing price should be on the y-axis
# The date should be on the x-axis. Make sure 
# to give the plot an appropriate title/labels
ggplot(gme, aes(x = Date, y = Close)) + geom_line() + ylab("Price") + ggtitle("GME Closing Price by Date")

# create a data frame named df_hl which has 3 variables 
# Date, High, and Low
df_hl <- gme |> select(Date, High, Low)

# Next we are going to convert our data into what is referred to as "long" format
# In df_hl, right now, there are 387 observations: 
# The unit of observation is the date and there are two variables that hold price information
# When we run the code below it will convert our data to having 
# 774 observations (2 observations per date), a variable named "PriceType" which 
# indicates whether the corresponding price in a given row is the "High"
# or "Low" price of the day, and then a final variable named "Price" that holds
# the relevant price.

df_long_hl <- pivot_longer(df_hl,!Date, names_to="PriceType", values_to="Price")

# Look at df_long_hl and df_hl to make sure you understand the difference 
# between the two. They hold the same information, but are structured differently
# In this class you won't need to use pivot_longer yourself, but you should 
# understand after looking at the two dataframes how they differ.

# create a line plot with two lines
# The first will be the high price and
# the second will be the low price.
# the code below is partially filled out to help you
# In general, when you want to do the same figure by different groups, you 
# can specify "color=group". In our case, we specify "color=PriceType"
# because we want a separate line for each PriceType

df_long_hl %>%
  ggplot( aes(x=Date, y=Price, color=PriceType) ) + 
  geom_line() +
  ylab("Price") +
  ggtitle("GME High and Low Prices Over Time") 


##################
# Olympic Athlete Ages
##################

# clear environment 
rm(list=ls())

# load Olympic data 
olym <- read_csv("athlete_events.csv")

# Create a table that displays the frequency of each Olympic event in the dataset
# We used this function at the end of Week 6 Part 1, as well as Video 6.10
table(olym$Event)

# Pick 2 events you are interested in and create a data
# frame that is filtered only to those two events
# you will have to use a logical operator to accomplish this
olym_fltr <- olym |> filter(Event %in% c("Basketball Men's Basketball", "Sailing Women's Windsurfer"))

# Create a box plot of the age in each of these events
ggplot(olym_fltr, aes(x = Event, y = Age)) + geom_boxplot() + ggtitle("Age by Event")




