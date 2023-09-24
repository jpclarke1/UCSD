rm(list=ls())
setwd("C:/Users/schwa/Desktop/UCSD Undergrad/Spring '23/MGT 100/R-Scripts")
iphone_sales <- read.csv("../data/iphone_sales.csv")

#1
M <- 2500
Nstart <- 0.27

N <- iphone_sales$sales
A <- cumsum(N)
R <- M - A
t <- iphone_sales$period

data <- data.frame(N, A, R, t)

out_lm <- lm(N ~ A + I(A^2), data = data)
summary(out_lm)

intercept <- round(coef(out_lm)[1], 2)
a_coefficient <- round(coef(out_lm)[2], 2)
a2_coefficient <- round(coef(out_lm)[3], 4)

print(intercept)
print(a_coefficient)
format(a2_coefficient, scientific = FALSE)

#2
iphone_sales$cum_sales <- cumsum(iphone_sales$sales)
iphone_sales$cum_sales
mdl_phone <- lm(sales ~ 1 + cum_sales + I(cum_sales^2),iphone_sales)
summary(mdl_phone)
M <- 2500
a_phone <- mdl_phone$coefficients[1]
b_phone <- mdl_phone$coefficients[2]
c_phone <- mdl_phone$coefficients[3]
p_phone <- a_phone/M
q_phone <- -c_phone*M
p_phone
q_phone
