# Set the working directory
setwd("C:\\Users\\johnot\\Google Drive\\Data Science\\03 Getting and Cleaning Data\\Week_3\\Project\\getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset")

# Load the required libraries
library(dplyr)
library(data.table)

# Read feature names
featureNames <- read.table("features.txt", header = FALSE)

# Read the Train data
subjectTrain <- read.table("train/subject_train.txt", header = FALSE)
activityTrain <- read.table("train/y_train.txt", header = FALSE)
featuresTrain <- read.table("train/X_train.txt", header = FALSE)

# Read the Test data
subjectTest <- read.table("test/subject_test.txt", header = FALSE)
activityTest <- read.table("test/y_test.txt", header = FALSE)
featuresTest <- read.table("test/X_test.txt", header = FALSE)

#
# STEP 1 - Merge the training and the test sets to create one data set
#
subject <- rbind(subjectTrain, subjectTest)
activity <- rbind(activityTrain, activityTest)
features <- rbind(featuresTrain, featuresTest)

# Set the name of the columns based on the features.txt file
names(features) <- as.matrix(featureNames[2])

# Add activity and subject as a column to features
names(activity) <- "Activity"
names(subject) <- "Subject"
fullDataSet <- cbind(features,activity,subject)

#
# STEP 2 - Extracts only the measurements on the mean and standard deviation for each measurement
#
# Standardise the names
names(fullDataSet) <- gsub("mean", "Mean", names(fullDataSet))
names(fullDataSet) <- gsub("std", "Std", names(fullDataSet)) 

# Get the indices of the Mean or Std columns 
meanStdIndices <- grep(".*Mean.*|.*Std.*", names(fullDataSet))

# Add the indices for the Activity and Subject columns
requiredColumns <- c(meanStdIndices, 562, 563)

# Now extract the subset of the fullDataSet based on the specified column indices
subSetData <- fullDataSet[,requiredColumns]


#
# STEP 3 - Uses descriptive activity names to name the activities in the data set
#

# Read the Activity labels
activityLabels <- read.table("activity_labels.txt", header = FALSE)

# Tidy them up a little
activityLabels[, 2] <- tolower(gsub("_", " ", activityLabels[, 2]))

# Apply the lables to the actual data
subSetData$Activity[subSetData$Activity == 1] <- activityLabels[1,2]
subSetData$Activity[subSetData$Activity == 2] <- activityLabels[2,2]
subSetData$Activity[subSetData$Activity == 3] <- activityLabels[3,2]
subSetData$Activity[subSetData$Activity == 4] <- activityLabels[4,2]
subSetData$Activity[subSetData$Activity == 5] <- activityLabels[5,2]
subSetData$Activity[subSetData$Activity == 6] <- activityLabels[6,2]

#
# STEP 4 - Appropriately labels the data set with descriptive variable names. 
#

# Use gsub to tidy up some of the variable names
names(subSetData) <- gsub("Acc", "Accelerometer", names(subSetData))
names(subSetData) <- gsub("angle", "Angle", names(subSetData))
names(subSetData) <- gsub("BodyBody", "Body", names(subSetData))
names(subSetData)<-gsub("^f", "Frequency", names(subSetData))
names(subSetData) <- gsub("freq\\()", "Frequency", names(subSetData), ignore.case = TRUE)
names(subSetData) <- gsub("gravity", "Gravity", names(subSetData))
names(subSetData) <- gsub("Gyro", "Gyroscope", names(subSetData))
names(subSetData) <- gsub("Mag", "Magnitude", names(subSetData))
names(subSetData) <- gsub("mean\\()", "Mean", names(subSetData), ignore.case = TRUE)
names(subSetData) <- gsub("std\\()", "STD", names(subSetData), ignore.case = TRUE)
names(subSetData)<-gsub("^t", "Time", names(subSetData))
names(subSetData) <- gsub("tBody", "TimeBody", names(subSetData))

#
# STEP 5 - From the data set in step 4, create a second, independent tidy data set with the average of 
# each variable for each activity and each subject.
# Please upload your data set as a txt file created with write.table() using row.name=FALSE
#

# Set the Activity and Subject variables as factors
subSetData$Activity <- as.factor(subSetData$Activity)
subSetData$Subject <- as.factor(subSetData$Subject)

# Convert the data.frame to a data.table
class(subSetData)
subSetData <- data.table(subSetData)

# Create tidyDataSet as a set with average for each activity and subject
tidyData <- aggregate(. ~Subject + Activity, subSetData, mean)

# Order tidyDataSet according to subject and activity
tidyDataSet <- tidyDataSet[order(tidyDataSet$Subject, tidyDataSet$Activity), ]

# Write tidyDataSet to a text file
write.table(tidyDataSet, file = "TidyDataSet.txt", row.names = FALSE)
