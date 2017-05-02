# Documentation -----------------------------------------------------------

# Title: "Batch analysis of Inter Beat Interval data (Excel sheets)"
# Author: "Deepak Sharma"
# Date: "April 29, 2017"

# Functions defined -------------------------------------------------------

categorize <- function(x){
  if (x <= avg_sd){
    return(1)
  }
  else if (x > avg_sd){
    return(0)
  }
}

approx_stress <- function(x){
  if(x == 1 || x == 2)
    return(0)
  else if(x == 3 || x == 4)
    return(1)
}

check_match <- function(x,y){
  if(x == y)
    return(1)
  else
    return(0)
}
# Classification ----------------------------------------------------------

hrv_data <- matrix(nrow = 100,ncol = 21)
hrv_data[,] <- 0
hrv_data <- read.csv("~/AIIMS work/Stress_analysis/hrv_ss.csv")
head(hrv_data)
hrv_data[,11]   # Standard deviation
avg_sd <- mean(hrv_data[,11])
limit <- nrow(hrv_data)
col <- ncol(hrv_data)

for(i in 1:limit){
  hrv_data[i,18] <- approx_stress(hrv_data[i,18])
  hrv_data[i,19] <- categorize(hrv_data[i,15])
  hrv_data[i,20] <- check_match(hrv_data[i,18],hrv_data[i,19])
}

# Generate output ---------------------------------------------------------

colnames(hrv_data)[19] <- "Predicted_score"
colnames(hrv_data)[20] <- "Correct_predictions"
write.csv(hrv_data[,], file = "HRV_analyzed.csv")
