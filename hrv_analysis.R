# Documentation -----------------------------------------------------------

# Title: "Batch analysis of Inter Beat Interval data (Excel sheets)"
# Author: "Deepak Sharma"
# Date: "April 29, 2017"

# Functions defined -------------------------------------------------------

categorize <- function(x){
  if (x <= avg_rms){
    return(1)
  }
  else if (x > avg_rms){
    return(2)
  }
}

# Classification ----------------------------------------------------------

hrv_data <- read.csv("~/AIIMS work/Stress_analysis/HRV.csv")
avg_rms <- mean(hrv_data[,16])
categorize(avg_rms)
