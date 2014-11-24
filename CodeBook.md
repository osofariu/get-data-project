---
title: "CodeBook"
author: "OS"
date: "November 23, 2014"
output: html_document
---


The original data is read from the "UCI HAR Dataset" directory and is unchanged.

Let's go over the main step, and identify how we manage the data in each step

### We import the training data and the test data, and append subject and activity to the data frame

For each of the two datasets (train, test)
- We combine data coming from X_subject_{train|test} with X_{train|test}.txt and y_{train|test}
- so no data is changed - we just put together the subjet, the activity, and the features
- we can do this because each of these data sets has the same number of onservations.

### Merge the training and the test sets to create one data set.
- just use the rbind function to put the two data sets together, because they have the same number of features

###  Use descriptive activity names to name the activities in the data set
- we start with the original label names, which are read from "features.txt"

### Add appropriate labels to the entire data set, based on the activity labels that were defined in the data provided
- we label all columns, before selecting just the mean an std columns

### Extracts only the measurements on the mean and standard deviation for each measurement.
- we use grep to extract the names that end in -mean() but doesn't include columns that contain meanFreq
- we use a similar grep expression to get columns with names matching std()
This technique ensures that we select similar data for future processing.

### Appropriately labels the data set with descriptive variable names.
- we create a table that maps the standart coumn names with beter ones.
- the file is called: "better_labels.txt"
- The data is mapped progrematically, but I am including it here for reference:

Subject                    Subject
Activity                   Activity
tBodyAcc-mean()-X          Time Body Acceleration Mean - X
tBodyAcc-mean()-Y          Time Body Acceleration Mean - Y
tBodyAcc-mean()-Z          Time Body Acceleration Mean - Z
tGravityAcc-mean()-X       Time Gravity Acceperation Mean - X
tGravityAcc-mean()-Y       Time Gravity Acceperation Mean - Y
tGravityAcc-mean()-Z       Time Gravity Acceperation Mean - Z
tBodyAccJerk-mean()-X      Time Body Acceleration Jerk Mean - X
tBodyAccJerk-mean()-Y      Time Body Acceleration Jerk Mean - Y  
tBodyAccJerk-mean()-Z      Time Body Acceleration Jerk Mean - Z
tBodyGyro-mean()-X         Time Body Gyro Mean - X
tBodyGyro-mean()-Y         Time Body Gyro Mean - Y
tBodyGyro-mean()-Z         Time Body Gyro Mean - Z
tBodyGyroJerk-mean()-X     Time Body Gyro Jerk Mean - X
tBodyGyroJerk-mean()-Y     Time Body Gyro Jerk Mean - Y
tBodyGyroJerk-mean()-Z     Time Body Gyro Jerk Mean - Z
fBodyAcc-mean()-X          Frequency Body Acceleration Mean - X
fBodyAcc-mean()-Y          Frequency Body Acceleration Mean - Y
fBodyAcc-mean()-Z          Frequency Body Acceleration Mean - Z
fBodyAccJerk-mean()-X      Frequency Body Accelecation Jerk Mean - X
fBodyAccJerk-mean()-Y      Frequency Body Accelecation Jerk Mean - Y
fBodyAccJerk-mean()-Z      Frequency Body Accelecation Jerk Mean - Z
fBodyGyro-mean()-X         Frequency Body Gyro Mean - X
fBodyGyro-mean()-Y         Frequency Body Gyro Mean - Y  
fBodyGyro-mean()-Z         Frequency Body Gyro Mean - Z
tBodyAcc-std()-X           Time Body Acceleration Standard Deviation - X
tBodyAcc-std()-Y           Time Body Acceleration Standard Deviation - Y
tBodyAcc-std()-Z           Time Body Acceleration Standard Deviation - Z
tGravityAcc-std()-X        Time Gravity Acceleration Standard Deviation - X
tGravityAcc-std()-Y        Time Gravity Acceleration Standard Deviation - Y
tGravityAcc-std()-Z        Time Gravity Acceleration Standard Deviation - Z
tBodyAccJerk-std()-X       Time Body Acceleration Jerk Stanrads Devlation - X
tBodyAccJerk-std()-Y       Time Body Acceleration Jerk Stanrads Devlation - Y
tBodyAccJerk-std()-Z       Time Body Acceleration Jerk Stanrads Devlation - Z
tBodyGyro-std()-X          Time Body Gyro Standard Deviation - X
tBodyGyro-std()-Y          Time Body Gyro Standard Deviation - Y
tBodyGyro-std()-Z          Time Body Gyro Standard Deviation - Z
tBodyGyroJerk-std()-X      Time Body Gyro Jerk Standard Deviation - X
tBodyGyroJerk-std()-Y      Time Body Gyro Jerk Standard Deviation - Y
tBodyGyroJerk-std()-Z      Time Body Gyro Jerk Standard Deviation - Z
fBodyAcc-std()-X           Frequency Body Acceleration - X
fBodyAcc-std()-Y           Frequency Body Acceleration - Y
fBodyAcc-std()-Z           Frequency Body Acceleration - Z
fBodyAccJerk-std()-X       Frequency Body Acceleration Jerk Standard Deviation - X
fBodyAccJerk-std()-Y       Frequency Body Acceleration Jerk Standard Deviation - Y
fBodyAccJerk-std()-Z       Frequency Body Acceleration Jerk Standard Deviation - Z
fBodyGyro-std()-X          Frequency Body Gyro Standard Deviation - X
fBodyGyro-std()-Y          Frequency Body Gyro Standard Deviation - Y
fBodyGyro-std()-Z           Frequency Body Gyro Standard Deviation - Z 


###  From the data set in step 4, creates a second, independent tidy data
### set with the average of each variable for each activity and each subject.

- the aggregate function is used to split the data by subject and then by activity.
- the output file is: "tidy_aggregate_data.txt"
