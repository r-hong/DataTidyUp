CODEBOOK (created on Jan 21, 2015)
Course: Getting and cleaning data.
Project: Collecting, working with, and cleaning data sets.

Introduction:
The purpose of the project was to download a given data set and performing a series of operations (e.g., 
merging, mean and standard deviation calculations, subsetting, etc.) to obtain two specified data sets. In 
this code book we described the initial data, the subsequently implemented data transformations and the 
tidy data sets obtained.  

Initial Data.
The data was downloaded from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Once unpacked it consist of a main Directory named ‘UCI HAR Dataset’ containing a README file and some 
additional information about the activities, and features in the data set. Basically the data set consist of a 
series of measurements from smart phone sensors (features are derived from these data) that were 
recorded when the subjects using these smart phones were performing certain activities (e.g., walking, 
standing, etc.). As the data set was used for some sort of machine learning purposes, the data were divided 
into a training set and a test set. This gives rise to the first objective of this project: Creating a merged 
dataset from the raw training and test sets. A second objective is to use the merged ‘total’ data set to 
create a second tidy data sets with the mean values per activity of the measured variables. 
The data from ‘UCI HAR Dataset’ is consequently divided into the folders ‘train’ and ‘test’ and on each of 
these folders we find files the subjects present in this group (file ‘subject_test’), their activities (file 
‘y_test’), 561 derived features (or variables) from the sensor data (file ‘X_test’) and a folder (‘Inertial 
Signals’)that contains 9 additional raw sensor measures (e.g., ‘body_acc_x_test’) and each one of these 
measures is formed by row of 128 observations.       
General strategy.
The strategy we followed can be roughly divided in these steps:
1.- Load the files from the main folder of the data (‘UCI HAR Dataset’) to create list/vectors containing the 
names and indices of the activities, and derived features (variables).
2.- Create a data set for the train(test) dataset, which will imply: (a) data frames with the subjects, the 
activities and derived features, (b) creating a second derived data frame using the mean and standard 
deviations of the raw 128 size vector data in the folder ‘Inertial Signals’. This will produce another 18 
additional  features, and  (c) merge the data frames from (a) and (b). 
3.- Merge the created ‘train’ and ‘test’ data sets to create a ‘total’ data sets.
4. Subset the ‘total’ data set created in (3) with conditional information to obtained only the average value 
of the variables per activity.
5. Saving all the results.
All these steps were programed in a single script named ‘run_analysis.R’. The script is fully commented and 
some additional information can be found in the file README.md  

Detailed description of steps 1-5 in the General strategy.
STEP 1. Getting the information about the activities and features.

-The activities were loaded from the file ‘activity_labels.txt’ into a data frame using the read.csv() function. 
The names of the variables in this data frame were label ‘Activity.Index’ and ‘Activity.Label’
-The derived features (variables) names were loaded from the file ‘features.txt’ into a data frame using the 
read.csv() function. Several feature names include substrings like ‘()’ or ‘-’ that could be interpreted as 
functions calls or operation in R. To avoid possible problem while referring to these variable names we 
eliminated these substrings from the original names of the featured and we saved the new names in a list. 
Besides this changes, the new 561 feature names preserved the same meaning as in the original data set. 

STEP2. Create a unify data frame for the ‘train’ data set. For simplicity we will refer here only to the ‘train’ 
set, but the same procedure was also applied to the ‘test’ data set.

Step2(a)
-SUBJECTS. The indices per measurement of the subjects present in this data set were loaded into a data 
frame from the file ‘./train/subject_train.txt’ and the variable of this data frame was named ‘Subject.Index’. 

-ACTIVITIES. The activity indices per record were loaded into a data frames from the file ‘./train/y_train.txt’. 
The variable named ‘Activity.Index’ was assigned to this data column.

-FEATURES. The 561 features per record were loaded into a data frame from the file ‘./train/X_train.txt’. 
White leading and lagging white spaces in the feature vectors were eliminated and the names of the 
features was added to this data frame using the list of feature names obtained in Step 1. 

Step2(b)
-NEW_FEATURES. Data from each of the 9 files in the folder ‘./train/ Inertial Signals’ were loaded in their 
corresponding data frames. In each of these files there are 128 observations of the variable per record 
(row). Therefore, we calculated the mean() and sd() values per record and put the result in a new data 
frame that will contained in total 18 new features (variables). We labeled the new 18 variables using the file 
names and therefore we kept the original meaning of these variables. For instance the first 2 features 
calculated from the file ‘body_acc_x_train.txt’ were labelled ‘body_acc_x.Mean’ and ‘body_acc_x.SD’. As 
these new variables are meant to be merged in a unify data frame with the ‘test’ data set is not really 
necessary specify that this variable comes from the train data set, the origin of the data is at this moment 
implied in the name of the data frame that we are generating.

Step2(c)
-TRAIN.DF. At this point we simply merge all the records in the data frames from SUBJECTS, ACTIVITIES, 
FEATURES, and NEW_FEATURES into a data frame that will contain contain records of 561+18 features, the 
subjects and the activities for the ‘train’ data set. The same steps, from 2(a) to 2(c) are now repeated for 
the ‘test’ data set to obtained TEST.DF.


STEP 3
 -TOTAL.DF. A unified ‘total’ data frame can now be obtained by adding all the rows of the data frame 
TEST.DF to the end of TRAIN.DF. Therefore these 3 data frames contained the same type of variables in 
each column.

STEP 4
SUBSET. In this step we created a function that uses TOTAL.DF and an index j representing a subject (1<= j 
<=30). The function give us back a new data frame df(i) that for that subject extracts the average value of 
each feature per activity. As we have 6 activities, each table df(i) will have 6 rows. In the first column we 
save the subject index I, in the second column the activity index (1<= i <=6) and the rest of the columns the 
mean values. We place this function in a loop of the subjects to get 30 data frames that we merged at the 
end to get a data frame named REDUCED.DF with 30x6=180 rows and 2+561+18 columns. 
 
STEP 5
We save the data frames TOTAL.DF and REDUCED.DF as csv files and we also save a copy of all the variables 
names (561 derived features with modified names according to step 1, and 18 newly calculated variables 
according to step 2(b)).
An additional file that updates the file ‘features.txt’ (named 'features_updated.txt') that includes the 
variables in the tidy data set generated in this analysis is also provided.
 
