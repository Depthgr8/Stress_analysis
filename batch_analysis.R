# Documentation -----------------------------------------------------------

# Title: "Batch analysis of Inter Beat Interval data (Excel sheets)"
# Author: "Deepak Sharma"
# Date: "April 11, 2017"

# Import libraries --------------------------------------------------------

library(xlsx)

# Import data -------------------------------------------------------------

setwd("~/AIIMS work/Stress_analysis/Datasets")
files <-  Sys.glob("*.xlsx")
limit <- length(files)
list.index <- 1:1
ibi_m <- matrix(nrow=6,ncol=limit)

# Filter parameters -------------------------------------------------------

min_ibi <- 600
max_ibi <- 1200
margin <- 50

# For loop to perfom batch analysis
for(i in list.index)
{
  print(noquote(paste("Analyzing ",files[i])))
  di <- read.xlsx(paste(files[i]),sheetIndex = 1,header = TRUE)
  first <- margin
  di_ibi <- as.numeric(di$IBI)
  times <- di$LocalTime
  lasttime <- tail(times[!is.na(times)], 1)
  last <- which(times == lasttime)
  last <- last - margin
  di_ibi <- di_ibi[first:last]
  s_set <- as.numeric(subset(di_ibi, di_ibi >= min_ibi & di_ibi < max_ibi ))
  
  # Put data in IBI matrix
  ibi_m[1,i] <- min(di_ibi)
  ibi_m[2,i] <- mean(s_set)
  ibi_m[3,i] <- sd(s_set)
  ibi_m[4,i] <- median(s_set)
  ibi_m[5,i] <- max(di_ibi)
  
  # Create output csv data file from matrix
}
write.csv(ibi_m[,], file = "../Output.csv")

