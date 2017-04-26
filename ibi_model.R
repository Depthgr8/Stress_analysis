# R script to classify stress data using k-means clustering
# Author: Deepak Sharma
# Date: 26 April 2017


# Import libraries --------------------------------------------------------

library(datasets)
library(psych)
library(ggplot2)

# Import data -------------------------------------------------------------

ods <- read.csv("Output_non_NA.csv")
ods_ss <- ods
attach(ods_ss)
headTail(ods_ss)

# K means clustering ------------------------------------------------------

set.seed(10)
ods_ss_cluster <- kmeans(ods_ss[, 1:7], 4, nstart = 10)
ods_ss_cluster
table(ods_ss_cluster$cluster, Category)
ods_ss_cluster$cluster <- as.factor(ods_ss_cluster$cluster)

# Visualization -----------------------------------------------------------

# Cluster plot
ggplot(ods_ss, aes(RRMS, pNN50, SDN, color = ods_ss_cluster$cluster)) + geom_point()

