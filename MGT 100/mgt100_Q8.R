setwd("C:\\Users\\schwa\\Desktop\\UCSD Undergrad\\Spring '23\\MGT 100\\R-Scripts")
rm(list=ls())
cust_dat <- read_csv("../data/smartphone_customer_data.csv")
load("../data/mnl_datasets.RData")
library(tidyverse)
library(mlogit)

prod_vec <- c("A1", "A2", "S1", "S2", "H1", "H2")

out <- mlogit(choice ~ apple:segment +
                samsung:segment +
                price:segment +
                screen_size:segment +
                price:total_minutes:segment | 0, data = mdat1)

M <- 10
mc1 <- 440
mc2 <- 470

#Q1
phone_dat <- cust_dat |>
  filter(years_ago == 1) |>
  count(phone_id) |>
  mutate(shr = n / sum(n))

phone_dat

d1 <- tibble(
  price1 = 799,
  share1 = phone_dat[5,3],
  price2 = 899,
  share2 = phone_dat[6,3]
)

d1 <- d1 |> mutate(
  q1 = share1 * M,
  q2 = share2 * M,
  rev1 = q1 * price1,
  rev2 = q2 * price2
)


d1 <- d1 |> mutate(
  cost1 = mc1 * q1,
  cost2 = mc2 * q2,
  profit1 = rev1 - cost1,
  profit2 = rev2 - cost2,
  total_profit = profit1 + profit2
)
d1

#Q2-Q3
pred1 <- colMeans(predict(out, mdat1))
names(pred1) <- prod_vec

d2 <- tibble(
  price1 = 799,
  share1 = pred1[3],
  price2 = 899,
  share2 = pred1[4]
)

d2 <- d2 |> mutate(
  q1 = share1 * M,
  q2 = share2 * M,
  rev1 = q1 * price1,
  rev2 = q2 * price2,
  cost1 = mc1 * q1,
  cost2 = mc2 * q2,
  profit1 = rev1 - cost1,
  profit2 = rev2 - cost2,
  total_profit = profit1 + profit2
)

rbind(d1, d2)

#Q4-Q6
#S1
pvec <- seq(from = -150, to = 150, by = 10)

smat <- matrix(NA, nrow = length(pvec), ncol = 6)
colnames(smat) <- prod_vec

for (i in 1:length(pvec)) {
  
  cat("Working on", i, "of", length(pvec), "\n")
  
  p <- pvec[i]
  
  tempdat <- as_tibble(mdat1) |> mutate(price = ifelse(phone_id == "S1", price + p, price))
  
  preds <- predict(out, newdata = tempdat)
  
  smat[i, ] <- colMeans(preds)
}

relcolS1 <- which(colnames(smat) == "S1")
s1dat <- tibble(scenario = 1:length(pvec), price = pvec + 799, share = smat[, relcolS1])

s1dat <- s1dat |> mutate(quantity = share * M)
s1dat <- s1dat |> mutate(revenue = price * quantity)
s1dat <- s1dat |> mutate(cost = mc1 * quantity)
s1dat <- s1dat |> mutate(profit = revenue - cost)
s1dat |> filter(profit == max(profit))

#S2
for (i in 1:length(pvec)) {
  
  cat("Working on", i, "of", length(pvec), "\n")
  
  p <- pvec[i]
  
  tempdat <- as_tibble(mdat1) |> mutate(price = ifelse(phone_id == "S2", price + p, price))
  
  preds <- predict(out, newdata = tempdat)
  
  smat[i, ] <- colMeans(preds)
}

relcolS2 <- which(colnames(smat) == "S2")
s2dat <- tibble(scenario = 1:length(pvec), price = pvec + 899, share = smat[, relcolS2])
s2dat <- s2dat |> mutate(quantity = share * M)
s2dat <- s2dat |> mutate(revenue = price * quantity)
s2dat <- s2dat |> mutate(cost = mc2 * quantity)
s2dat <- s2dat |> mutate(profit = revenue - cost)
s2dat |> filter(profit == max(profit))


#Q7
cce <- 0.05
delta1 = 699 - 799
delta2 = 749 - 899

mdat1_newprices = mdat1 |> as_tibble() |>
  mutate(price = ifelse(phone_id=="S1", price + delta1, price)) |>
  mutate(price = ifelse(phone_id=="S2", price + delta2, price))

pred2 = colMeans(predict(out, newdata = mdat1_newprices))
names(pred2) <- prod_vec
round(pred2 * 100, 1)

d3 <- tibble(
  price1 = 699,
  share1 = pred2[3],
  price2 = 749,
  share2 = pred2[4]
)
d3 <- d3 |> mutate(
  q1 = share1 * M,
  q2 = share2 * M,
  rev1 = q1 * price1,
  rev2 = q2 * price2
)
d3 <- d3 |> mutate(
  cost1 = mc1 * q1,
  cost2 = mc2 * q2,
  profit1 = rev1 - cost1,
  profit2 = rev2 - cost2,
  total_profit = profit1 + profit2
)
d3

out_adj <- out
out_adj$coefficients[4:6] <- out_adj$coefficients[4:6] + cce

pred3 <- colMeans(predict(out_adj, newdata = mdat1_newprices))
names(pred3) <- prod_vec

shr_change <- pred3 - pred2
names(shr_change) <- prod_vec

round(pred2 * 100, 1)
round(pred3 * 100, 1)
round(shr_change * 100, 2)

d4 <- tibble(
  price1 = 699,
  share1 = pred3[3],
  price2 = 749,
  share2 = pred3[4]
)

d4 <- d4 |> mutate(
  q1 = share1 * M,
  q2 = share2 * M,
  rev1 = q1 * price1,
  rev2 = q2 * price2,
  cost1 = mc1 * q1,
  cost2 = mc2 * q2,
  profit1 = rev1 - cost1,
  profit2 = rev2 - cost2,
  total_profit = profit1 + profit2
)


rbind(d3, d4)

net = 1435 - 1404 - 50
net

library(downloader)
library(dplyr)
url="https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/msleep_ggplot2.csv"
filename <- basename(url)
download(url,filename)

dat2 <- read.csv("msleep_ggplot2.csv")
class(dat2)

primates <- filter(dat2, order=="Primates")
class(primates)

select(primates, sleep_total) |> unlist() |> mean()

getwd()
setwd("C:/Users/schwa/Desktop/UCSD Undergrad/Spring '23/MGT 100/R-Scripts")
dat3 <- load("skew.RData")
dim(dat)

for (i in 1:9) {
  qqnorm(dat[,i])
  qqline(dat[,i])
}

hist(dat[,9])

par(mar=c(0.001,0.001,0.001,0.001))
summarize(InsectSprays)
boxplot(split(InsectSprays$count, InsectSprays$spray))

library(UsingR)
library(ggplot2)
data(nym.2002, package="UsingR")
boxplot(split(nym.2002$gender, nym.2002$time))
ggplot(data = nym.2002, aes()) + geom_histogram('gender', 'time')
