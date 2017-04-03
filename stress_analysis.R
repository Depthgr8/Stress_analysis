# Documentation -----------------------------------------------------------

# Title: "Stress prediction using IBI"
# Author: "Deepak Sharma"
# Date: "March 20, 2017"

# Import libraries --------------------------------------------------------

library(xlsx)

# Import data -------------------------------------------------------------

di <- read.xlsx("~/AIIMS work/Stress_analysis/Datasets/27-1-15 dr indrajeet(M).xlsx",sheetIndex = 1,header = TRUE)

# Filter parameters -------------------------------------------------------

min_ibi <- 400
max_ibi <- 800
margin <- 50

# Subsetting --------------------------------------------------------------

first <- margin
di_ibi <- as.numeric(di$IBI)
times <- di$LocalTime
lasttime <- tail(times[!is.na(times)], 1)
last <- which(times == lasttime)
last <- last - x

di_ibi <- di_ibi[first:last]
s_set <- as.numeric(subset(di_ibi, di_ibi >= min_ibi & di_ibi < max_ibi ))
cat("Range of IBI (Min, Max) : ", range(di_ibi))
cat("Standard deviation of complete dataset: ", sd(di_ibi))
cat("Standard deviation of subset : ", sd(s_set))
y <- fft(as.numeric(a))


# Process -----------------------------------------------------------------

freq_frame = as.data.frame(table(s_set))
colnames(freq_frame) <- c("Inter Beat Interval", "Frequency")
freq_frame
x = as.numeric(as.vector(freq_frame[,1]))
y = freq_frame[,2]
freq_codes <- list("Very low frequency","LOw frequency","High frequency","Very high frequency")

# Visualization -----------------------------------------------------------
plot(x,y,main = "Frequency spectrum of Inter Beat Interval",
     xlab="Inter Beat Interval", ylab="Frequency",
     xlim=c(min(x),max(x)), ylim=c(min(y),max(y)),pch=15, col="blue")
text(x, y, row.names(freq_frame$Frequency), cex=1, pos=1, col="blue",labels = freq_codes)
plot(1:last,fft(di_ibi),type = 'l')
plot(a,type='l')
hist(a,breaks = 200)
