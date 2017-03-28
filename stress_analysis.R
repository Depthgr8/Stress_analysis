
# Documentation -----------------------------------------------------------

# Title: "Stress prediction using IBI"
# Author: "Deepak Sharma"
# Date: "March 20, 2017"

# Import libraries --------------------------------------------------------

library(xlsx)

# Import data -------------------------------------------------------------

di <- read.xlsx("~/AIIMS work/Stress_analysis/Datasets/DR. indrajit 27-5-15(E).xlsx",sheetIndex = 1,header = FALSE)

# Filter ------------------------------------------------------------------

di_ibi <- as.numeric(di$X41)
first <- which(di$X41 == 'IBI') + 1
times <- di$X36
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

plot(fft(di_ibi),type = 'l')
plot(a,type='l')
hist(a,breaks = 200)
