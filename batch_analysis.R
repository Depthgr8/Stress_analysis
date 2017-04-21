# Documentation -----------------------------------------------------------

# Title: "Batch analysis of Inter Beat Interval data (Excel sheets)"
# Author: "Deepak Sharma"
# Date: "April 11, 2017"

# Import libraries --------------------------------------------------------

library(xlsx)
library(psych)

# Import data -------------------------------------------------------------

setwd("~/AIIMS work/Stress_analysis/Datasets")
files <-  Sys.glob("*.xlsx")
limit <- length(files)
list.index <- 1:1
ibi_m <- matrix(nrow=18,ncol=limit,dimnames = list(c("Index","File Name","Min IBI","Min Fil","Mean Fil","SDN","Median Fil","Max Fil","Max IBI","Category","Skewness","Kurtosis","Avg HR","RRMS","NN50","pNN50","Subset_length","Data_length")))

# Filter parameters -------------------------------------------------------

min_ibi <- 600
max_ibi <- 1200
margin <- 50

# Functions defined -------------------------------------------------------

categorize <- function(x){
  if (x >= 0 && x < 50){
    return(1)
  }
  else if (x >= 50 && x < 100){
    return(2)
  }
  else if (x >= 100 && x < 150){
    return(3)
  }
  else if (x >= 150 && x < 200){
    return(4)
  }
  else
    return(5)
}
# For loop to perfom batch analysis
for(i in list.index)
{
  print(noquote(paste("Analyzing file no. ",i," ",files[i])))
  di <- read.xlsx(paste(files[i]),sheetIndex = 1,header = TRUE)
  first <- margin
  di_ibi <- as.numeric(di$IBI)
  times <- di$LocalTime
  lasttime <- tail(times[!is.na(times)], 1)
  last <- which(times == lasttime)
  last <- last - margin
  di_ibi <- di_ibi[first:last]
  s_set <- as.numeric(subset(di_ibi, di_ibi >= min_ibi & di_ibi < max_ibi ))
  des <- describe(s_set)

  # Put data in IBI matrix
  
  ibi_m[1,i] <- i
  ibi_m[2,i] <- files[i]
  ibi_m[3,i] <- min(di_ibi)
  ibi_m[4,i] <- min(s_set)  
  ibi_m[5,i] <- mean(s_set)
  ibi_m[6,i] <- sd(s_set)
  ibi_m[7,i] <- sqrt(mean(s_set))
  ibi_m[8,i] <- median(s_set)
  ibi_m[9,i] <- max(s_set)
  ibi_m[8,i] <- max(di_ibi)
  ibi_m[10,i] <- categorize(sd(s_set))
  ibi_m[11,i] <- des$skew
  ibi_m[12,i] <- des$kurtosis      # Kurtosis of filtered IBI
  ibi_m[13,i] <- mean(60/(s_set/1000))    # Average Heart rate
  diffs <- diff(s_set)
  ibi_m[14,i] <- sqrt(mean(diffs ^ 2))  # Calculate RMS
  ibi_m[15,i] <- sum(abs(diffs) > 50)     # nn50
  nn50 <- sum(abs(diffs) > 50)
  ibi_m[16,i] <- nn50 / length(diffs) * 100
  ibi_m[17,i] <- length(s_set)  # length of subset
  ibi_m[18,i] <- length(di_ibi) # length of full dataset

  
  # Create output csv data file from matrix
}
write.csv(t(ibi_m[,]), file = "../Output.csv")

