---
title: "Untitled"
author: "Zoe Fleischmann"
date: "February 22, 2015"
output: html_document
---

##Data Set Information: 
The following is an excerpt from the site where the data was obtained:

"The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain."

##Attribute Information: 
"For each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment."

More information at: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

#Process:

##Step 1:
Set source directory for files, read selected files into tables. data came from files: 
- features.txt
- activity_labels.txt
- subject_train.txt
- x_train.txt
- y_train.txt
- subject_test.txt
- x_test.txt
- y_test.txt

Column names were assigned from activity labels, subject_train and test, and features for the x and y, train and test files. Data merged in the order: ydata(ytrain and ytest), subject ids, then xdata (xtrain and xtest). 

##Step 2: 
Logical vector created from features table to subset only those that correspond to mean and standard deviations. (561 observations become 66)

##Step 3:
Descriptive names created from the fragmented variable names(ie f became frequency; gyr, gyroscope, etc). Activity ids were replaced with more descriptive activity names (ie 1 became WALKING, 2 became WALKING_UPSTAIRS, etc).

Final Data contains 10299 observations in 68 variables. Column names as follows:

- 1-6: timeBodyAccelerometer-mean()-XYZ, -std()-XYZ                               
- 7-12: timeGravityAccelerometer-mean()-XYZ, -std()-XYZ            
- 13-18: timeBodyAccelerometerJerk-mean()-XYZ, -std()-XYZ            
- 19-24: timeBodyGyroscope-mean()-XYZ, -std()-XYZ                      
- 25-30: timeBodyGyroscopeJerk-mean()-XYZ, -std()-XYZ                 
- 31-32: timeBodyAccelerometerMagnitude-mean(), -std()        
- 33-34: timeGravityAccelerometerMagnitude-mean(), -std()    
- 35-36: timeBodyAccelerometerJerkMagnitude-mean(), -std()     
- 37-38: timeBodyGyroscopeMagnitude-mean(), -std()          
- 39-40: timeBodyGyroscopeJerkMagnitude-mean(), -std()           
- 41-46: frequencyBodyAccelerometer-mean()-XYZ, -std()-XYZ               
- 47-52: frequencyBodyAccelerometerJerk-mean()-XYZ, -std()-XYZ         
- 53-58: frequencyBodyGyroscope-mean()-XYZ, -std()-XYZ                
- 59-60: frequencyBodyAccelerometerMagnitude-mean(), -std()     
- 61-62: frequencyBodyAccelerometerJerkMagnitude-mean(), -std()
- 63-64: frequencyBodyGyroscopeMagnitude-mean(), -std()           
- 65-66: frequencyBodyGyroscopeJerkMagnitude-mean(), -std()  
- 67: subjectId                                     
- 68: activityId 

NB: "1-6: timeBodyAccelerometer-mean()-XYZ, -std()-XYZ" means that the columns 1-6 are:
- 1: timeBodyAccelerometer-mean()-X
- 2: timeBodyAccelerometer-mean()-Y
- 3: timeBodyAccelerometer-mean()-Z
- 4: timeBodyAccelerometer-std()-X
- etc.

##Step 4: Further "tidy" data set was created per project instructions.
Average of each variable for each activity for each subject. (see tidyData.txt file)
