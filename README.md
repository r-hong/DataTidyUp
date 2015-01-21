README (created on Jan 21, 2015)
Course: Getting and cleaning data.
Project: Collecting, working with, and cleaning data sets.

Starting from the initial ‘raw’ data set 
(https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) we first 
unpacked the data and copy the R script ‘run_analysis.R’ in the main folder of the unpacked data, ‘UCI HAR 
Dataset’. The scrip should be sourced/executed in this folder.

The script ‘run_analysis.R’ is fully commented and divided in a series of steps requited for the 
transformations performed on the data. Each step is fully explained in the code book ‘CodeBook.md’. 
Briefly:

STEP 1.- Load the files from the main folder of the data (‘UCI HAR Dataset’) to create list/vectors containing 
the names and indices of the activities, and derived features (variables).
STEP 2.- Create a data set for the train(test) dataset, which will imply: (a) data frames with the subjects, the 
activities and derived features, (b) creating a second derived data frame using the mean and standard 
deviations of the raw 128 size vector data in the folder ‘Inertial Signals’. This will produce another 18 
additional  features, and  (c) merge the data frames from (a) and (b). 
STEP 3.- Merge the created ‘train’ and ‘test’ data sets to create a ‘total’ data sets.
STEP 4.- Subset the ‘total’ data set created in (3) with conditional information to obtained only the average 
value of the variables per activity.
STEP 5.- Saving all the results.

An additional file that updates the file ‘features.txt’ (named 'features_updated.txt') that includes the 
variables in the tidy data set generated in this analysis is also provided.

In case the peer reviewers find problems visualizing the tidy data set (question 1-uploading the tidy data 
set), we also placed the generated tidy data set (Reduced.csv) in the provided Github link.
 




