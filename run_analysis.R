# --------------
# run_analysis.R
# --------------

library("dplyr")

# Download data archive
setwd("~/data")
file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(file_url, "dataset.zip")
unzip("dataset.zip")


# 1. Merges the training and the test sets to create one data set.
traindata <- read.table("UCI HAR Dataset/train/X_train.txt")
trainsubject <- read.table("UCI HAR Dataset/train/subject_train.txt")
trainactivity <- read.table("UCI HAR Dataset/train/y_train.txt")
traindata <- cbind(trainsubject, trainactivity, traindata)

testdata <- read.table("UCI HAR Dataset/test/X_test.txt")
testsubject <- read.table("UCI HAR Dataset/test/subject_test.txt")
testactivity <- read.table("UCI HAR Dataset/test/y_test.txt")
testdata <- cbind(testsubject, testactivity, testdata)

data <- rbind(traindata, testdata)
rm (trainactivity, trainsubject, traindata, testactivity, testsubject, testdata)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
features <- read.table("UCI HAR Dataset/features.txt")
mean_std <- grep(features$V2, pattern="mean\\(|std\\(")
data <- data[, c(1,2,mean_std +2)]


# 4. Appropriately labels the data set with descriptive variable names.
var_names <- as.character(features[mean_std,"V2"])
var_names <- gsub("\\(\\)", "", var_names)
var_names <- gsub("mean", "MEAN", var_names)
var_names <- gsub("std", "STD", var_names)
var_names <- gsub("^t", "Time", var_names)
var_names <- gsub("^f", "Freq", var_names)
names(data) <- c("subject", "activity", var_names) 

# 3. Uses descriptive activity names to name the activities in the data set 
activities <- read.table("UCI HAR Dataset/activity_labels.txt")
data$activity <- factor(data$activity, activities$V1, labels=activities$V2)

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
summary <- data %>% group_by(subject, activity) %>% summarise_each(funs(mean))
wwrite.table(x = summary, file = "means.txt", row.name=FALSE)
