##The following R script is constructed to get, work with, and clean the data set 
##collected from the accelerometers from the Samsung Galaxy S smartphone.
##The goal is to prepare tidy data that can be used for later analysis.
##Once the data set is downloaded, The script runs the following processes to make 
##the tidy data.
##1. Merges the training and the test sets to create one data set.
##2. Extracts only the measurements on the mean and standard deviation for each measurement.
##3. Uses descriptive activity names to name the activities in the data set.
##4. Appropriately labels from the data set with descriptive variable names.
##5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#The variables "pathDataset" and "dataFeaturesNames" are assigned in the global environment.

#Load "plyr" package.
library(plyr)

#Download the data set from the web source and unzip it at the local "./data" directory.
DownloadDataset <- function(fileUrl) {
  if(!file.exists("./data")) {
    dir.create("./data")
  }
  
  if(!file.exists("./data/UCI HAR Dataset")) {
    download.file(fileUrl, destfile="./data/Dataset.zip")
    unzip(zipfile="./data/Dataset.zip", exdir="./data")
  }
}

#Read and merge the train and test files.
MergeDataset <- function() {
  pathDataset <<- file.path("./data", "UCI HAR Dataset")
  dataActivityTrain <- read.table(file.path(pathDataset, "train", "y_train.txt"), header=FALSE)
  dataActivityTest <- read.table(file.path(pathDataset, "test", "y_test.txt"), header=FALSE)
  dataSubjectTrain <- read.table(file.path(pathDataset, "train", "subject_train.txt"), header=FALSE)
  dataSubjectTest <- read.table(file.path(pathDataset, "test", "subject_test.txt"), header=FALSE)
  dataFeaturesTrain <- read.table(file.path(pathDataset, "train", "X_train.txt"), header=FALSE)
  dataFeaturesTest <- read.table(file.path(pathDataset, "test", "X_test.txt"), header=FALSE)
  #Concatenate data tables by row.
  dataActivity <- rbind(dataActivityTrain, dataActivityTest)
  dataSubject <- rbind(dataSubjectTrain, dataSubjectTest)
  dataFeatures <- rbind(dataFeaturesTrain, dataFeaturesTest)
  #Set names to variables.
  names(dataActivity) <- c("activity")
  names(dataSubject) <- c("subject")
  dataFeaturesNames <<- read.table(file.path(pathDataset, "features.txt"), header=FALSE)
  names(dataFeatures) <- dataFeaturesNames$V2
  #Merge all the data by column to get a new "Data" data frame.
  dataMerge <- cbind(dataActivity, dataSubject)
  Data <- cbind(dataFeatures, dataMerge)
}

#Extracts only the data on mean and standard deviation.
ExtractsDataset <- function(Data) {
  #Subset Names of Features with the mean and standard deviation from measurements. 
  extractsdataFeaturesNames <- dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]
  #Subset the "Data" data frame by extracted Names of Features.
  extractsNames <- c(as.character(extractsdataFeaturesNames), "activity", "subject")
  Data <- subset(Data, select=extractsNames)
}

#Uses descriptive activity names to name the activities in the data set.
SetActivityNames <- function(Data) {
  activityLabels <- read.table(file.path(pathDataset, "activity_labels.txt"), header=FALSE)
  activityIndex = 1
  #Set the matching activity label for each row.
  for (activityLabels in activityLabels$V2) {
    Data$activity <- gsub(activityIndex, activityLabels, Data$activity)
    activityIndex <- activityIndex + 1
  }
  Data
}

#Appropriately labels the data set with descriptive variable names.
DescriptiveVariableNames <- function(Data) {
  names(Data) <- gsub("^t", "time", names(Data))
  names(Data) <- gsub("^f", "frequency", names(Data))
  names(Data) <- gsub("Acc", "Accelerometer", names(Data))
  names(Data) <- gsub("Gyro", "Gyroscope", names(Data))
  names(Data) <- gsub("Mag", "Magnitude", names(Data))
  names(Data) <- gsub("BodyBody", "Body", names(Data))
  names(Data) <- gsub("-mean()", ".mean", names(Data))
  names(Data) <- gsub("-std()", ".std", names(Data))
  names(Data) <- gsub("-meanFreq()", ".mean.freq", names(Data))
  names(Data) <- gsub("[-]", ".", names(Data))
  names(Data) <- gsub("[()]", "", names(Data))
  Data
}

#Creates a second, independent data frame "tidyData" with the mean of each measurement variable for each activity and each subject.
TidyDataset <- function(Data) {
  tidyData <- ddply(Data, .(subject, activity), function(x) colMeans(x[,1:66]))
  tidyData
}

##Execute the processes with assigned functions.

#Download the data set from the source.
DownloadDataset("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")

#1. Merges the training and the test sets to create one data set.
Data <- MergeDataset()

#2. Extracts only the measurements on the mean and standard deviation for each measurement.
Data <- ExtractsDataset(Data)

#3. Appropriately labels from the data set with descriptive variable names.
Data <- DescriptiveVariableNames(Data)

#4. Uses descriptive activity names to name the activities in the data set.
Data <- SetActivityNames(Data)

#5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidyData <- TidyDataset(Data)

#Write the result of tidy data on the text file "tidy_data.txt".
write.table(tidyData, file="tidy_data.txt", row.names=FALSE)

#Write the names of the variables on the text file "variables.txt" as a part of code book.
write(names(Data), file="variables.txt", ncolumns=1)
