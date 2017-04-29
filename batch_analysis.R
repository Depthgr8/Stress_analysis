# Documentation -----------------------------------------------------------

# Title: "Generate measures for Inter Beat Interval (RR interval) data analysis"
# Author: "Deepak Sharma"
# Date: "April 11, 2017"

# Import libraries --------------------------------------------------------

library(xlsx)
library(psych)
library(DescTools)

# Function defined --------------------------------------------------------

mode <- function(x) {
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}

# Import data -------------------------------------------------------------

setwd("~/AIIMS work/Stress_analysis/Datasets")
files <-  Sys.glob("*.xlsx")
limit <- length(files)
list.index <- 1:limit
ibi_m <- matrix(nrow=18, ncol=limit, dimnames = list(c("Index","File_Name","Subset_length","Data_length","Min_IBI","Max_IBI","Min_Subset","Max_Subset","Mean_Subset","Median_Subset","Mode_Subset","SD_Subset","Skewness","Kurtosis","Avg_HR","RMS","NN50","pNN50")))

# Filter parameters ------------------------------------------------------- 

min_ibi <- 600
max_ibi <- 1300
margin <- 50

# Iterate through all the xlsx files
for(i in list.index)
{
  print(noquote(paste("Analyzing file no. ", i, " ", files[i])))
  di <- read.xlsx(paste(files[i]), sheetIndex = 1, header = TRUE)
  first <- margin
  di_ibi <- as.numeric(di$IBI)
  times <- di$LocalTime
  lasttime <- tail(times[!is.na(times)], 1)
  last <- (which(times == lasttime)) - margin
  di_ibi <- di_ibi[first:last]
  s_set <- as.numeric(subset(di_ibi, di_ibi >= min_ibi & di_ibi <= max_ibi ))
  des <- describe(s_set)

  # Put data in IBI matrix
  
  ibi_m[1,i] <- i                           # Generating index
  ibi_m[2,i] <- files[i]                    # File name
  ibi_m[3,i] <- length(s_set)               # length of filtered subset
  ibi_m[4,i] <- length(di_ibi)              # length of full dataset
  ibi_m[5,i] <- min(di_ibi)                 # Minimum of recorded IBI
  ibi_m[6,i] <- max(di_ibi)                 # Maximum of recorded IBI
  ibi_m[7,i] <- min(s_set)                  # Minimum of filtered subset
  ibi_m[8,i] <- max(s_set)                  # Maximum of filtered subset 
  ibi_m[9,i] <- mean(s_set)                 # Mean of filtered subset
  ibi_m[10,i] <- median(s_set)              # Median of filtered subset
  ibi_m[11,i] <- mode(s_set)                # Mode of filtered subset
  ibi_m[12,i] <- sd(s_set)                  # Standard deviation of filtered subset
  ibi_m[13,i] <- des$skew                   # Skewness of filtered IBI
  ibi_m[14,i] <- des$kurtosis               # Kurtosis of filtered IBI
  ibi_m[15,i] <- mean(60/(s_set/1000))      # Average Heart rate
  diffs <- diff(s_set)                      # Calculate difference between RR intervals
  ibi_m[16,i] <- sqrt(mean(diffs ^ 2))      # Calculate RMS
  ibi_m[17,i] <- sum(abs(diffs) > 50)       # Calculate nn50
  ibi_m[18,i] <- sum(abs(diffs) > 50) / length(diffs) * 100   # Calculate pNN50
}

# Generate output ---------------------------------------------------------

write.csv(t(ibi_m[,]), file = "../HRV.csv")


