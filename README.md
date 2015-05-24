#Getting and Cleaning Data Course Project


##Project Tasks

You should create one R script called run_analysis.R that does the following. 
Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement. 
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names. 
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


##Solution summary


Step 0. Initialisation step to check if the resource directory already exists locally, if not download and extract


Step 1. Merge the training and the test sets using ```rbind``` to create a unified data set.


Step 2. Extract the measurements on the mean (```mean()```) and std dev(```std```) for each measurement using ```grep```.


Step 3. Add descriptive activity names to name the activities in the data set by loading activity labels and replacing indices with names.


Step 4. Add appropriate labels to the data set with descriptive activity names by combining the labels and data set using ```cbind```.


Step 5. A second, independent tidy data set with the average of each variable for each activity and each subject - ```aggregate``` and ```mean``` functions applied on the data set obtained in Step 4 which results in a 180 x 68 matrix.
