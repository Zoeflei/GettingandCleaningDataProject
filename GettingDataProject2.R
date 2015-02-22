######################################################################################
## Zoe Fleischmann
## Coursera - Getting and Cleaning Data Project
## 22-February-2015
##
## This file performs the following tasks:
## 1. Downloads from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
## 2. Merges the training and the test sets to create one data set.
## 3. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 4. Uses descriptive activity names to name the activities in the data set
## 5. Appropriately labels the data set with descriptive variable names. 
## 6. From the data set in step 4, creates a second, independent tidy data set with the 
## average of each variable for each activity and each subject.
##
######################################################################################

##Download and decompress zip file. Saved to destfile "./data" in working directory.
fileName <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileName, destfile = "./data/Dataset.zip", method = "curl")
unzip(zipfile = "./data/Dataset.zip", exdir = "./data")

## Expand list of files to determine which will be needed -
path_rf <- file.path("./data", "UCI HAR Dataset")
files <- list.files(path_rf, recursive = TRUE)
files

## For purposes of this project, X-test.txt, y-test.txt, subject_test.txt,
## subject_train.txt, X_train.txt, and y_train.txt are needed. Files activity_labels.txt
## and features.txt used for labels

setwd("./data/UCI HAR Dataset")

## Download training set
features = read.table("./features.txt", header = FALSE)
activityType = read.table("./activity_labels.txt", header = FALSE)
subjectTrain = read.table("./train/subject_train.txt", header = FALSE)
xTrain = read.table("./train/x_train.txt", header = FALSE)
yTrain = read.table("./train/y_train.txt", header = FALSE)

## Set Column names, begin tidying/labelling process
colnames(activityType) <- c("activityId", "activityType")
colnames(subjectTrain) <- "subjectId"
colnames(xTrain) <- features[,2]
colnames(yTrain) <- "activityId"

## Same for test set
subjectTest = read.table("./test/subject_test.txt", header = FALSE)
xTest = read.table("./test/x_test.txt", header = FALSE)
yTest = read.table("./test/y_test.txt", header = FALSE)
colnames(subjectTest) <- "subjectId"
colnames(xTest) <- features[,2]
colnames(yTest) <- "activityId"

## merge xTest and xTrain, yTest and yTrain, subjectTest and subjectTrain.
subject <- rbind(subjectTrain, subjectTest)
xData <- rbind(xTrain, xTest)
yData <- rbind(yTrain, yTest)
finalData <- cbind(yData, subject, xData)

## Subset Data by measuremenst of Std Deviation and Mean
columnsNeeded <- features$V2[grep("mean\\(\\)|std\\(\\)", features$V2)]
selection <- c(as.character(columnsNeeded), "subjectId", "activityId")
Data <- subset(finalData, select = selection)

## Create Descriptive Names
names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))
Data$activityId <- factor(Data$activityId, levels = activityType$activityId, labels = activityType$activityType)

## Tidy data set w/average of each variable for each activity and subject
tidyData <- aggregate(. ~subjectId + activityId, Data, mean)
tidyData <- tidyData[order(tidyData$subjectId, tidyData$activityId),]

write.table(tidyData, file = "./tidyData.txt", row.name = FALSE)

