# Getting-and-Cleaning-Data
Getting and Cleaning Data: Course Project

The repository contains a R script which is assigned as a Course Project work for Coursera's Getting and Cleaning Data course.
The reposited "run_analysis.R" script is constructed to get, work with, and clean the data set collected from the accelerometers from the Samsung Galaxy S smartphone.
The goal is to prepare tidy data that can be used for later analysis.
The original data set was obtained from UCI's Machine Learning Repository web site as below link.

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

A little information of data set is given below. 
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

Once the data set is downloaded, The script runs the following processes to make the tidy data.
##1. Merges the training and the test sets to create one data set.
##2. Extracts only the measurements on the mean and standard deviation for each measurement.
##3. Uses descriptive activity names to name the activities in the data set.
##4. Appropriately labels from the data set with descriptive variable names.
##5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The "run_analysis.R" script has following details.
##1. DownloadDataset function: Download the data set from the web source and unzip it at the local "./data" directory.
##2. MergeDataset function: Read and merge the train and test files.
##3. ExtractsDataset function: Extracts only the data on mean and standard deviation.
##4. SetActivityNames function: Uses descriptive activity names to name the activities in the data set.
##5. DescriptiveVariableNames function: Appropriately labels the data set with descriptive variable names.
##6. TidyDataset function: Creates a second, independent data frame "tidyData" with the mean of each measurement variable for each activity and each subject.
##7. Write the result of tidy data on the text file "tidy_data.txt".
##8. Write the names of the variables on the text file "variables.txt" as a part of code book.

A code book that describes the variables and the data from the script is also provided as CodeBook.md and included in the repo. 

