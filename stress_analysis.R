
# Documentation -----------------------------------------------------------

# Title: "Stress prediction using IBI"
# Author: "Deepak Sharma"
# Date: "March 20, 2017"

# Import libraries --------------------------------------------------------

library(xlsx)
library(XLConnect)

# Import data -------------------------------------------------------------

di <- read.xlsx("~/AIIMS work/Stress_analysis/Datasets/27-1-15 dr indrajeet(M).xlsx",sheetIndex = 1,header = TRUE)

# Filter ------------------------------------------------------------------

di_ibi <- as.numeric(di$IBI)
first <- 1
times <- di$LocalTime
lasttime <- tail(times[!is.na(times)], 1)
last <- which(times == lasttime)

# Subsetting --------------------------------------------------------------

di_ibi <- di_ibi[first:last]
a <- as.numeric(subset(di_ibi, di_ibi >= min(di_ibi) & di_ibi < max(di_ibi) ))
cat("Range of IBI (Min, Max) : ", range(di_ibi))
cat("Standard deviation of complete dataset: ", sd(di_ibi))
cat("Standard deviation of subset : ", sd(a))
y <- fft(as.numeric(a))

# Visualization -----------------------------------------------------------

plot(1:last,fft(di_ibi),type = 'l')
plot(a,type='l')
hist(a,breaks = 200)
