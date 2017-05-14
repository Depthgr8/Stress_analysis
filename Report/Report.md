>  Project report on 'Monitoring cognition of healthcare workers in emergency & intensive care setting and its relation to medical errors

`Author: Deepak Sharma`
`Date: May 13, 2017`

# Stress prediction in healthcare workers with Linear discriminant analysis
### Abstract
Mental stress affect sympathetic and parasympathetic nervous systems which controls heart beat patterns. Heart rate variability is often considered a measure to understand cognition acitvities such as stress. In this paper we have analyzed time domain measures of heart rate variability for 95 healthcare workers. This heart rate variability data is later used to build a classfication model using linear discriminant analysis algorithm which has 93.43% accuracy in predicting stress.

### Study
A total of 115 datasets were part of this study of which 20 had missing values, thus removed during data cleaning process. Subsetting resulted in 95 datasets with all time domain measures. This heart rate variability data contains 17 measures (Avg_HR, RMS, NN50, pNN50, Actual_Stress score, Subset_length, Data_length, Min_IBI, Max_IBI, Min_Subset, Max_Subset, Mean_Subset, Median_Subset, Mode_Subset, SD_Subset, Skewness, Kurtosis). The RMS (Root Mean Square) value of heart rate variability found to be the most important variable for classification of IBI data into stress and non-stress classes.

The stress score that was surveyed from medical staff was in 4 categories (1, 2, 3, and 4) and further simplified in 2 classes (Stress and non-stress). Training of LDA model suggests that using RMS values of IBI, classification of IBI data can be performed.

```r
library(xlsx)
sample <- read.xlsx("~/AIIMS work/Stress_analysis/Report/sample_hrv.xlsx",sheetIndex = 1)
sample <- sample$IBI
sample_filtered<- as.numeric(subset(sample, sample >= 600 & sample <= 1300 ))
```

### Methodology
Raw data was obtained from Sunto T6D watch for medical staff which includes doctors and nurses. Data cleaning was performed using R and 95 clean datasets were obtained out of 120 raw datasets. Using Inter Beat Interval data various time domain measures were calculated such as standard deviation, rms values and pNN50. All the volunteers who participated in this study were given a questionaire which included the stress score they reported. Using these time domain variables we created a model which predicts stress score for provided heart rate variability (inter beat interval) data.

### Data processing
Obtained heart rate variability data contains abnormal peaks of unusual RR intervals, thus a filter is created to allow certain (600-1300) RR interval which was first step in cleaning. An automated program in R was developed to analyzed all excel files in one execution. Which also includes functionality to extract time domain measures from cleaned excel files. In next step missing time domain values were removed. 

#### Plots showing difference between raw and clean data

```r
plot(sample, type = 'l', main = "Unfiltered raw data")
```
```r
plot(sample_filtered, type = 'l',main = "Filtered clean data")
```

[![N|Raw](https://github.com/Depthgr8/Stress_analysis/blob/master/Report/clean.png)]()
[![N|Clean](https://github.com/Depthgr8/Stress_analysis/blob/master/Report/clean.png)]()


### Results
LDA (Linear Discriminant Analysis) model was first trained using provided IBI data. Validation of model was carried out using 10 fold cross validation. The sensitivity of LDA model was 96.55% and specificity was 89.19%. Overall accuracy of model was calculated to be 93.68%. In the literature it was suggested that neural network models can increase the accuracy of classification task, a neural network model (Multi Layer Perceptron) is being developed.

```r
sample_td_data <- read.csv("~/AIIMS work/Stress_analysis/Report/HRV.csv")
head(sample_td_data)
```
```
##   Subset_length Data_length Min_IBI Max_IBI Min_Subset Max_Subset
## 1          4070        7309     252   18000        600       1287
## 2          2710        4433     251    3715        600       1300
## 3          5615        6725     251   60000        600       1272
## 4          4493        6553     251   24000        600       1298
## 5          1220        5321     251   37000        600       1230
## 6          6526        6664     258   39545        602       1226
##   Mean_Subset Median_Subset Mode_Subset SD_Subset   Skewness    Kurtosis
## 1    652.7172           636         627  61.76831  3.7152607 20.86051772
## 2    729.5085           674         608 145.29463  1.8771904  3.10401043
## 3    793.9179           791         808  83.21980  0.6094697  2.29990864
## 4    876.6975           886         873 111.38504 -0.1525725  0.12715207
## 5    651.5131           623         605  90.62993  3.7853799 15.74336173
## 6    922.5259           930         928  93.27928 -0.3815079 -0.04083709
##     Avg_HR       RMS NN50    pNN50 Actual Predicted
## 1 92.56367  66.04736  535 13.14819      1         1
## 2 84.78659 179.48682 1040 38.39055      0         0
## 3 76.39075  71.22452  883 15.72854      0         1
## 4 69.62361 109.83497 1631 36.30899      0         0
## 5 93.31468 108.12274  176 14.43806      1         0
## 6 65.75287  53.34515 1886 28.90421      0         1
```

### Discussion
In this study 95 datasets were used to train a model to classify hrv data into stress and non-stress class. Accuracy of which is 93% which can be further increased if the model is trained with some other machine learning algorithm. In future study we are planning to train the model using relatively efficient deep learning algorithms with sample size of 1000 datasets.
