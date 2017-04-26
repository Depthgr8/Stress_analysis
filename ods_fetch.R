# Batch read ods file to extract stress score from ods files
# Date: 25 April 2017
# Author: Deepak Sharma

# Import library ----------------------------------------------------------

library(readODS)

# Set parameters ----------------------------------------------------------

setwd("~/AIIMS work/Stress_analysis/Datasets")
getwd()
ods_files <-  Sys.glob("*.ods")
ods_length <- length(ods_files)
list.index <- 1:ods_length
ods <- matrix(nrow=8,ncol=ods_length,dimnames = list(c("File Name","Night Duty","Proper Sleep","Fever","Headache","Tired","Stress","S_Score")))

# Read in one batch -------------------------------------------------------

for(i in list.index)
{
  print(noquote(paste("Analyzing file no. ",i," ",ods_files[i])))
  full_ods <- read_ods(paste(ods_files[i]),sheet = 2) 
  ods[1,i] <- noquote(ods_files[i]) # File name
  ods[2,i] <- full_ods[1,2] # Night duty (Yes/No)
  ods[3,i] <- full_ods[2,2] # Proper sleep (Yes/No + Hours)
  ods[4,i] <- full_ods[3,2] # Fever
  ods[5,i] <- full_ods[4,2] # Headache
  ods[6,i] <- full_ods[5,2] # Tired
  ods[7,i] <- full_ods[6,2] # Stress (Yes/No)
  ods[8,i] <- full_ods[7,2] # Stress score
}

# Write as output file (CSV) ----------------------------------------------

write.csv(t(ods[,]),file = "~/AIIMS work/Stress_analysis/ods_mined.csv")
