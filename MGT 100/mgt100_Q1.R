library(tidyverse)  
install.packages("devtools")
devtools::install_github("r-lib/conflicted")

    setwd("C:/Users/schwa/Desktop/UCSD Undergrad/Spring '23/MGT 100/R-Scripts")
    cust_dat <- read_csv("../data/smartphone_customer_data.csv")
    
    #4.
    Q_4 <- cust_dat |>
      filter(brand == "samsung", size_cat == "l", years_ago == 1)
    mean(Q_4$gaming)
    
    #5.
    Q_5 <- cust_dat |>
      group_by(size_cat, brand, years_ago) |>
      summarize(num_consumers = n())
    
    Q_5_sorted <- Q_5 |>
      arrange(desc(num_consumers))
    
    Q_5_second <- Q_5_sorted$num_consumers[2]
    
    #6.
    Q_6 <- cust_dat |>
      summarize(Q_6 = sum(is.na(discount)))
    
    #7.
    Q_7 <- cust_dat |>
      filter(discount == phone_id) |>
      summarize(Q_7 = n())

    #8 & 9.
    ggplot(cust_dat, aes(x = screen_size, y = price, color = brand)) + geom_point() + labs(x = "Screen size (inches)", y = "Price ($)", color = "Brand")
    