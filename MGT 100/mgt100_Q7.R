library(tidyverse)
library(mlogit)

setwd("C:\\Users\\schwa\\Desktop\\UCSD Undergrad\\Spring '23\\MGT 100\\R-Scripts")
cust_dat <- read_csv("../data/smartphone_customer_data.csv")
load("../data/mnl_datasets.RData")

out <- mlogit(choice ~ apple:segment + samsung:segment + price:segment + screen_size:segment + price:total_minutes:segment | 0, data = mdat1)

pvec <- seq(from = -200, to = 200, by = 10)

smat <- matrix(NA, nrow = length(pvec), ncol = 6)
colnames(smat) <- c("A1", "A2", "S1", "S2", "H1", "H2")

for (i in 1:length(pvec)) { 
  
  cat("Working on", i, "of", length(pvec), "\n")
  
  p <- pvec[i]
  
  tempdat <- as_tibble(mdat1) |> mutate(price = ifelse(phone_id == "A2", price + p, price))
  
  preds <- predict(out, newdata = tempdat)
  
  smat[i, ] <- colMeans(preds)
}

relcol <- which(colnames(smat) == "A2")
a2dat <- tibble(scenario = 1:length(pvec), price = pvec + 999, share = smat[, relcol])


ggplot(a2dat, aes(x = share, y = price)) +
  geom_point() +
  geom_line() +
  labs(x = "Share", y = "Price") +
  theme_bw()

cust_dat |>
  filter(years_ago == 1) |>
  count(phone_id) |>
  mutate(shr = n / sum(n))

smat[21, ] |> round(3)


#3.
a2dat <- a2dat |> mutate(quantity = share * 10)

p1 <- a2dat |>
  slice(20) |>
  pull(price)
q1 <- a2dat |>
  slice(20) |>
  pull(quantity)

p2 <- a2dat |>
  slice(22) |>
  pull(price)
q2 <- a2dat |>
  slice(22) |>
  pull(quantity)

elasticity <- ((q2 - q1) / q1) / ((p2 - p1) / p1)
elasticity

#4
600 * 1 / (1 - 1 / abs(elasticity))

#5
a2dat <- a2dat |> mutate(revenue = price * quantity)

a2dat <- a2dat |> mutate(cost = 600 * quantity)

a2dat <- a2dat |> mutate(profit = revenue - cost)

a2dat |> filter(profit == max(profit))
