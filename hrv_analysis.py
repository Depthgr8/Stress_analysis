# Documentation

""" 
Heart Rate Variability (HRV) analysis with python
Date: 28 April 2017
Author: Deepak Sharma (Computer Programmer - JPNATC)
"""

# Import packages

import xlrd
import glob
import os
import csv

# Read data

cwd = os.getcwd()
print("Following CSV files will be analyzed \t ", glob.glob(cwd + "/Data/*.csv"))
print("Present working directory \t ", cwd)

with open(cwd+'/Data/HRV_clean.csv') as clean_data:
    c_d = csv.reader(clean_data, delimiter=',')
    for index in c_d:
        print(index[1])