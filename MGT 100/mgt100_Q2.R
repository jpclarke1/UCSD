library(tidyverse)
install.packages("devtools")
devtools::install_github("r-lib/conflicted")

# Q1
cust_dat |>
  filter(total_minutes < 1200) |>
  select(brand, size_cat) |>
  table()

#Q2
cust_dat |>
  filter(years_ago == 2) |>
  ggplot(aes(total_minutes)) +
  geom_histogram(bins = 10)

#Q3
cust_dat |>
  filter(phone_id == "A2") |>
  ggplot(aes(handsize)) +
  facet_grid(rows = vars(years_ago)) +
  geom_boxplot()

#Q4
ggplot(cust_dat, aes(height, reading)) + 
  geom_point(color = "dodgerblue4", alpha = 0.3) + 
  ggtitle("Joshua's Scatterplot (Minutes Spent Reading vs. Height)") +
  xlab("Height") +
  ylab("Minutes Spent Reading") +
  theme_classic()
