##
## This function performs the following tasks required by the Getting and Cleaning Data Course Project:
## a) Merges the training and the test sets to create one data set
## b) Extracts only the measurements on the mean and standard deviation for each measurement 
## c) Uses descriptive activity names to name the activities in the data set
## d) Appropriately labels the data set with descriptive variable names
## e) From the data set in step d), creates a second, independent tidy data set with the average
##    of each variable for each activity and each subject
##
## This function requires the following input files to be in the working directory where it is run:
## activity_labels.txt
## features.txt
## test/subject_test
## test/X_test.txt
## test/y_test.txt
## train/subject_train
## train/X_train.txt
## train/y_train.txt
##
## This function generates the output file tiny_data.txt in the working directory
##
run_analysis <- function() { 

   ## Load the required R packages
   require(dplyr)
   
   ## Read in feature and activity labels
   feaLbl <- read.table("features.txt", col.names=c("pos", "desc"))
   actLbl <- read.table("activity_labels.txt", col.names=c("actCode", "activity"))
   
   ## Determine feature columns containing mean() & std()
   selCol <- c(grep("mean\\(\\)", feaLbl$desc), grep("std\\(\\)", feaLbl$desc))
   
   ## Read in test data and select only those columns of interest 
   testData <- read.table("./test/X_test.txt", col.names=feaLbl$desc)
   testData <- select(testData, selCol)

   ## Append subject and activity to test data
   testData <- bind_cols(inner_join(read.table("./test/y_test.txt", col.names="actCode"), 
                                    actLbl, by="actCode"), testData)
   testData <- bind_cols(read.table("./test/subject_test.txt", col.names="subject"),
                         testData)

   ## Read in training data and select only those columns of interest 
   trainData <- read.table("./train/X_train.txt", col.names=feaLbl$desc)
   trainData <- select(trainData, selCol)
   
   ## Append subject and activity to training data
   trainData <- bind_cols(inner_join(read.table("./train/y_train.txt", col.names="actCode"),
                                     actLbl, by="actCode"), trainData)
   trainData <- bind_cols(read.table("./train/subject_train.txt", col.names="subject"),
                          trainData)
   
   ## Merge test and training data
   allData <- bind_rows(testData, trainData)
   allData <- select(allData, -actCode)
   rm(testData)
   rm(trainData)
   
   ## Make variable names descriptive 
   varNames <- colnames(allData)
   varNames <- gsub("\\.mean", "Mean", varNames)
   varNames <- gsub("\\.std", "Std", varNames)
   varNames <- gsub("\\.", "", varNames)
   colnames(allData) <- varNames
   
   ## Summarize and extract the required tiny data
   tinyData <- summarise_each(group_by(allData, subject, activity), funs(mean))
   
   ## Output the tiny data as text file
   write.table(tinyData, file="tiny_data.txt", row.names=FALSE)
}      