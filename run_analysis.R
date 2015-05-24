#  R script called run_analysis.R to analyse the data given in "Getting and Cleaning Data" project. 

# 0. Check if the resource directory already exists locally, if not download and extract

dataSetDir <- "UCI HAR Dataset"

if (file.exists(dataSetDir)){
  print("Dataset already exists locally, re-using it")
} else {
  
  print("Data set needs to be downloaded and extracted")
  
  dataFile <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  dir.create("assignment")
  download.file(dataFile, "assignment/UCI-HAR-dataset.zip", method="curl")
  unzip("assignment/UCI-HAR-dataset.zip")
}

# 1. Merge the training and the test sets to create a unified data set.
features <- read.table("./UCI HAR Dataset/features.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names=features[,2])
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names=features[,2])
X <- rbind(X_test, X_train)

# 2. Extract the measurements on the mean and std dev for each measurement. 
interestingFeatures <- features[grep("(mean|std)\\(", features[,2]),]
mean_and_std <- X[,interestingFeatures[,1]]

# 3. Add descriptive activity names to name the activities in the data set
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = c('activity'))
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = c('activity'))
y <- rbind(y_test, y_train)

labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
for (i in 1:nrow(labels)) {
        code <- as.numeric(labels[i, 1])
        name <- as.character(labels[i, 2])
        y[y$activity == code, ] <- name
}

# 4. Add appropriate labels to the data set with descriptive activity names. 
X_with_labels <- cbind(y, X)
mean_and_std_with_labels <- cbind(y, mean_and_std)
write.csv(mean_and_std_with_labels, file='assignment/GCD_Project_result4.csv')

# 5. A second, independent tidy data set with the average of each variable for each activity and each subject. 
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = c('subject'))
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = c('subject'))
subject <- rbind(subject_test, subject_train)
averages <- aggregate(mean_and_std_with_labels, by = list(activity = y[,1], subject = subject[,1]), mean)
averages <- averages[, colSums(is.na(averages)) != nrow(averages)]

write.table(averages, file='assignment/GCD_Project_result5.txt', row.names=FALSE)
write.csv(averages, file='assignment/GCD_Project_result5.csv')
