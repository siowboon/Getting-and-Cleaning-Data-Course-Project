## Getting and Cleaning Data Course Project
This repository contains the following files submitted for the course project:
a) run_analysis.R
b) codebook.md

## run_analysis.R
This function performs the following tasks required by the Course Project:
a) Merges the training and the test sets to create one data set
b) Extracts only the measurements on the mean and standard deviation for each measurement 
c) Uses descriptive activity names to name the activities in the data set
d) Appropriately labels the data set with descriptive variable names 
e) From the data set in step d), creates a second, independent tidy data set with the average
   of each variable for each activity and each subject

This function requires the following Samsung data files to be in the working directory where it is run:
- activity_labels.txt
- features.txt
- test/subject_test
- test/X_test.txt
- test/y_test.txt
- train/subject_train
- train/X_train.txt
- train/y_train.txt

This function generates the output tiny data set (tiny_data.txt) in the working directory

## codebook.md
This is the code Book describing each variable and its values in the tidy data set





- it describes the variables in tidy data set 