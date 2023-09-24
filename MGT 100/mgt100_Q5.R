library(tidyverse)
library(mlogit)

setwd("C:\\Users\\schwa\\Desktop\\UCSD Undergrad\\Spring '23\\MGT 100\\R-Scripts")
cust_dat <- read_csv("../data/smartphone_customer_data.csv")

#1
brand_shares1 <- cust_dat |>
  filter(years_ago == 1) |>
  count(brand) |>
  mutate(shr = n / sum(n))

brand_shares2 <- cust_dat |>
  filter(years_ago == 2) |>
  count(brand) |>
  mutate(shr = n / sum(n))

brand_shares1
brand_shares2

apple_chng <- 0.432-0.356
apple_chng
huawei_chng <- 0.198-0.292
huawei_chng
samsung_chng <- 0.370-0.352
samsung_chng

#2&3.
load("../data/mnl_datasets.RData")
out3 <- mlogit(choice ~ apple + samsung | 0, data = mdat3)
summary(out3)
coef(out3)
coefs3 <- c(huawei = 0, coef(out3))
coefs3

#4
load("../data/mnl_performance_functions.RData")
out3_price <- mlogit(choice ~ apple + samsung + price | 0, data = mdat3)
summary(out3_price)
coef(out3_price)
brand_hit_rate(mdat3, out3_price)
ll_ratio(mdat3, out3_price)
