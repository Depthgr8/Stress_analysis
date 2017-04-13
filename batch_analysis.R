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
list.index <- 1:limit
ibi_m <- matrix(nrow=10,ncol=limit,dimnames = list(c("Index","File Name","Min IBI","Min Fil","Mean Fil","SD Fil","Median Fil","Max Fil","Max IBI","Category")))

# Filter parameters -------------------------------------------------------

min_ibi <- 600
max_ibi <- 1200
margin <- 50

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
  
  # Put data in IBI matrix
  ibi_m[1,i] <- i
  ibi_m[2,i] <- files[i]
  ibi_m[3,i] <- min(di_ibi)
  ibi_m[4,i] <- min(s_set)  
  ibi_m[5,i] <- mean(s_set)
  ibi_m[6,i] <- sd(s_set)
  ibi_m[7,i] <- median(s_set)
  ibi_m[8,i] <- max(s_set)
  ibi_m[9,i] <- max(di_ibi)
  ibi_m[10,i] <- categorize(sd(s_set))
}

# Create output csv data file from matrix
write.csv(t(ibi_m[,]), file = "../Output.csv")

