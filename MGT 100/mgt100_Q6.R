library(tidyverse)
library(mlogit)

setwd("C:\\Users\\schwa\\Desktop\\UCSD Undergrad\\Spring '23\\MGT 100\\R-Scripts")
cust_dat <- read_csv("../data/smartphone_customer_data.csv")

#2-4
load("../data/mnl_datasets.RData")
out2 <- mlogit(choice ~ apple:segment + samsung:segment + screen_size:segment +
                 price:segment + price:total_minutes:segment | 0, data = mdat2)
options(scipen=n)
summary(out2)

#5-8
out1 <- mlogit(choice ~ apple:segment + samsung:segment + screen_size:segment +
                price:segment + price:total_minutes:segment | 0, data = mdat1)
options(scipen=n)
summary(out1)

out3 <- mlogit(choice ~ apple:segment + samsung:segment + screen_size:segment +
                 price:segment + price:total_minutes:segment | 0, data = mdat3)
options(scipen=n)
summary(out3)
