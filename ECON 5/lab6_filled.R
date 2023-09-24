# Econ 5/Poli 5D, Lab 6
#
# Please complete the code below. 
#
# Remember that you can use help() if you forget the syntax for a function or type 
# ?functionname
################################################################################

# Part 0 : Learning some basics
# remove all objects from current environment 
# this is the equivalent of clear all in Stata
rm(list = ls())

# 1.  create an object called add that is 5 + 12
add <- 5 +12

# 2.  create a vector called vec of the following numbers (1,2,3,4)
vec <- c(1,2,3,4)

# 3.  find the range of vec
range(vec)
#ANS: 1 4

# 4. find the length of vec
length(vec)
#ANS: 4

# 5. take the sum of all the entries in vec
sum(vec)
# ANS: 10

# 6. Create a new vector, called vec2, that contains two entries. "Hello" in
# as the first entry and "Goodbye" as the second
vec2 <- c("Hello","Goodbye")

# 7. You can retrieve specific elements of a vector by using brackets. For example
# to display Hello we can type
vec2[1]

# Now retrieve the word "Goodbye"
vec2[2]

## Part 2: Importing and exploring data
# 1. Set your working directory to the location of resume.csv, import the csv,
#     and *assign* it as a data frame object called 'resume'.
setwd("C:/Users/schwa/Desktop/UCSD Undergrad/Spring '23/ECON 5/Labs/Lab5")
resume <- read.csv("resume.csv")

# 2. How many observations are there in this dataset? How many variables?
dim(resume)
# ANS: 4870 obs, 5 var

# 3. Display the first three observations of the data frame using the head command
head(resume, n=3)

# 4. Display the last three observations of the data frame using the tail command
tail(resume, n=3)

# 5. Display summary statistics of the entire data set. Give a summary of the column titled call.
summary(resume)
summary(resume$call)

# 6. Make a table that shows the frequency of male and female applications
table(resume$sex)

## Part 3: simple bar graph in R (fill in XX with code)

## 1. In class we showed how to compute average callback rates by race
## Save these averages as objects by replacing the XX with one of 
## ways we calculate average callback rates by race 

# callback rate for Black applicants 
mean_b <- mean(resume$call[resume$race == "black"])

# callback rate for white applicants
mean_w <- mean(resume$call[resume$race == "white"])

# create a vector that stores mean_b in the first entry and mean_w in the second
# name this vector mean
mean <- c(mean_b, mean_w)


## If you have filled in the prior codes correctly you 
## should be able to run this to retrieve a bar plot of callback 
## rates by race
barplot(mean, main="Callback Rate by Race",
        xlab="Race", ylab="Callback Rate", names.arg = c("Black","White"))
