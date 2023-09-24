library(tidyverse)

setwd("C:\\Users\\schwa\\Desktop\\UCSD Undergrad\\Spring '23\\MGT 100\\R-Scripts")
cust_dat <- read_csv("../data/smartphone_customer_data.csv")

sub <- cust_dat |> select(social, gaming)

ggplot(sub, aes(social, gaming)) +
  geom_point() +
  theme_minimal()

scl <- sub |>
  scale() |>
  as_tibble()

scl |>
  summarize_all(mean) |>
  round(3) # check means
scl |> summarize_all(sd) # check std devs

set.seed(1234)
out <- kmeans(scl, centers = 4, nstart = 10)
str(out)

#2
sub<-
  sub |> 
  mutate(cluster = factor(out$cluster))

sub |> count(cluster)

centers <- as_tibble(out$centers)

SD <- sub |>    
  select(social, gaming) |>
  summarize_all(sd)
MEAN <- sub |>
  select(social, gaming) |>
  summarize_all(mean)

SD <- SD |>
  unlist() |>
  rep(4) |>
  matrix(nrow = 4, ncol = 2, byrow = T)
MEAN <- MEAN |>
  unlist() |>
  rep(4) |>
  matrix(nrow = 4, ncol = 2, byrow = T)

centers <- centers * SD + MEAN
round(centers, 1)

#3
out[["tot.withinss"]]

#4
out_10 <- kmeans(scl, centers = 10, nstart = 10)
out_10[["tot.withinss"]]
