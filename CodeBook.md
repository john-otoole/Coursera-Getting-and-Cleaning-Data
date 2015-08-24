# Getting and Cleaning Data Course Project Code Book

This Code Book describes the data, the variables and any transformations carried out to tidy up the data.

##  Introduction
One of the most exciting areas in all of data science right now is wearable computing - see for example this article: http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

In summary, the R script "run_analysis.R" does the following:
* Merges the training and the test sets to create one data set
* Extracts only the measurements on the mean and standard deviation for each measurement
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

## Details

* Set the working directory to the location where the data zip file was extracted
* Read features.txt into the variable *featureNames*
* Read subject_train.txt into the variable *subjectTrain*
* Read y_train.txt into the variable *activityTrain*
* Read X_train.txt into the variable *featuresTrain*
* Read subject_test.txt into the variable *subjectTest*
* Read y_test.txt into the variable *activityTest*
* Read X_test.txt into the variable *featuresTest*
* Use rbind to merge each of the Train and Test datasets together
* Cast the second column of featuresNames to a matrix and set is as the column names of features
* Use cbind to merge the features, activity and subject datasets
* Use gsub to standardise the casing of the columns containing "mean" or "std"
* Get the indices of the columns containing "Mean" or "Std"
* Extract the required columns from the main dataset, into a new data.frame *subSetData*.  Include the indices for the Activity and Subject columns
* Read activity_labels.txt into the variable *activityLabels*
* Set the activityLabels to lower case and remove the underscore
* Apply the labels to *subSetData*
* Use gsub to tidy up some column names
* In preparation for calling *aggregate*, set Activity and Subject as factors
* Call *aggregate" using the dot notation format, to get the mean, grouping by Activity and Subject
* Order the dataset by Subject and Activity
* Write the dataset out to *TidyDataSet.txt*


