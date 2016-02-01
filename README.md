### GettingAndCleaningDataProject

##Overview

This project is a short culmination of the Getting and Cleaning Data Course taught through Coursera in partnership with John Hopkins. The associated run_analysis.R file will load and clean the data associated to produce a tidy data set.

[Source data is available for download here.](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) And a full description with original codebooks of data used in this project is available at the [UCI Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

##Modifications

To replicate this, you will first have to download and unzip the above data. The data is then loaded by the run_analysis file into R for analysis. Lines 4:8 and 21:23 assume that the folder downloaded will be located in a folder labeled data within your working directory. If this is not the case you will have to edit the file names to reflect your structure.

##Project Instructions 

You should create one R script called run_analysis.R that does the following. 1. Merges the training and the test sets to create one data set. 2. Extracts only the measurements on the mean and standard deviation for each measurement. 3. Uses descriptive activity names to name the activities in the data set 4. Appropriately labels the data set with descriptive activity names. 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

