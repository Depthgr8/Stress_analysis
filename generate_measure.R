# Documentation -----------------------------------------------------------

# Title: "Generate other classification measures"
# Author: "Deepak Sharma"
# Date: "April 17, 2017"

# Import libraries --------------------------------------------------------

# library(cs)

# Import data -------------------------------------------------------------

setwd("~/AIIMS work/Stress_analysis/Clean/")
raw <- read.csv("raw.csv")

sd <- raw$SD.Fil
hist(sd,freq = 20)

rmssd <- sqrt(mean(sd^2))

write.csv(t(ibi_m[,]), file = "../Output_update.csv")

