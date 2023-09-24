library(tidyverse)
install.packages("PerformanceAnalytics")

setwd("C:\\Users\\schwa\\Desktop\\UCSD Undergrad\\Spring '23\\MGT 100\\R-Scripts")
cust_dat <- read_csv("../data/smartphone_customer_data.csv")

#1
sub <- cust_dat |> filter(years_ago == 2) |> select (gaming, chat, maps, video, social, reading)
PerformanceAnalytics::chart.Correlation(sub)

#2 & 3
pca_sub <- sub |> prcomp()
summary(pca_sub)

#4
sub2 <- as_tibble(pca_sub$x)
k <- 3
km <- kmeans(sub2[,1:2], centers = k)
df <- data.frame(PC1 = sub2[,1], PC2 = sub2[,2], cluster = km$cluster)
ggplot(df, aes(x = PC1, y = PC2, color = factor(cluster))) + geom_point()
