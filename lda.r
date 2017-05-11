# Including required libraries
library(MASS)

# Importing depressin versus normal data
hrv <- read.csv("HRV.csv")

# Creating modeling variables
Predictor <- subset(hrv, select=-Predicted)
Target <-  noquote(hrv$Predicted)

# Performing Linear Discriminant Analysis
fitting <- lda(Predicted ~ ., data = hrv)
hrv_model_pred <- predict(fitting)$class
hrv_model <- table(hrv_model_pred, hrv$Predicted)

# Results of discriminant analysis
sensitivity(hrv_model, "0") * 100
specificity(hrv_model, "1") * 100
negPredValue(hrv_model, "0") * 100
posPredValue(hrv_model, "1") * 100

