#######################################

#  Lab 7 

#######################################

# clear environment 
rm(list=ls())

# load packages
library(tidyverse)

########################

# Part 1:loops 

########################

# create an object named sum that is equal to zero 
sum <- 0
# create a vector named vec that contains the elements 1,10,20
vec <- c(1, 10, 20)
# write a loop that iterates over the elements in vec
# within each loop, replace the object sum 
# to sum plus the element of the vector

for (element in vec){
  
  sum <- sum + element
  
}

########################

# Part 2: Exploring Time Spent on Childcare for Fathers

#######################

# change working directory 
setwd("C:\\Users\\schwa\\Desktop\\UCSD Undergrad\\Spring '23\\ECON 5\\Labs\\Lab7")
# load data as a "tibble"
data <- read_csv("rugratrace.csv")

# create a tibble named fathers2534, between age 25 and 34
# who have at least 1 child, using pipes and the filter function. 
# the variable father2 is equal to 1 for fathers.
# Additionally select the variables age, childtot, childeduc, childtravel, dataset, and college
fathers2534 <- data |>
  filter(age >= 25 & age <= 34, father2 == 1) |>
  select(age, childtot, childeduc, childtravel, dataset, college)


# For a similar code in the textbook, look toward the end of section 7.6:
# https://daarnolducsd.github.io/ep5book/the-rug-rat-race.html#the-pipe-operator

# Using mutate, Add a variable named collegeprep = childeduc + childtravel to your dataset 
fathers2534 <- fathers2534 |>
  mutate(collegeprep = childeduc + childtravel)

# Using group_by and summarize, create a new tibble named collegeprep_father
# that contains for each year, the average value of collegeprep for 
# fathers aged 25 to 34.
collegeprep_father <- fathers2534 |>
  group_by(dataset, college) |>
  summarize(average_collegeprep = mean(childtot))
