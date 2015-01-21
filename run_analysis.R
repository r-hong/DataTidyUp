#### STEP 1####
#########################################################
# Getting and modifying initial variables names 
# found in the main directoty of the raw data sets.
# it is assumed that this script will be run using as
# working directory 'UCI HAR Dataset'.
###############################################################
#Loading general tables with labels (features&activities)
#feature labels
features <- read.csv("features.txt",sep=" ",header=FALSE)
#eliminate conflicting '()' and '-' substrings from the feature labels
#found in the file 'features.txt'
feat.list <- as.vector(features$V2)
for (i in 1:length(feat.list)){
        feat.list[i] <- gsub("()", "", feat.list[i],fixed=TRUE)
        feat.list[i] <- gsub("-", "", feat.list[i],fixed=TRUE)
}
#activity labels
activities  <- read.csv("activity_labels.txt",sep="",header=FALSE)
colnames(activities) <- c("Activity.Index" ,"Activity.Label")

#################
#### STEP 2 ####
###########################################################
#Prtocessing data from the 'train' set
############################################################
#Objective: obtain the data frame Train.DF with all the data 
#for the Train set

## Step 2(a) #
#loading data from the set 'train'
Train_Subjects  <- read.csv("./train/subject_train.txt",sep="",header=FALSE)
colnames(Train_Subjects) <- c("Subject.Index")

Train_features <- read.table("./train/X_train.txt",strip.white=TRUE)
colnames(Train_features) <- feat.list  
Train_activities <- read.table("./train/y_train.txt",strip.white=TRUE)
colnames(Train_activities) <- c("Activity.Index")

# Step 2(b) #
#Preprocessing of the mean() and sd() values of the data in the forder
#./train/Inertial Signals/
#objective: create the data frame 'Table.train.DF' that will contain the calculated 
#mean() and sd() values from the data in this folder (18 variables in total)
body_acc_x <- read.table("./train/Inertial Signals/body_acc_x_train.txt",strip.white=TRUE)
body_acc_y <- read.table("./train/Inertial Signals/body_acc_y_train.txt",strip.white=TRUE)
body_acc_z <- read.table("./train/Inertial Signals/body_acc_z_train.txt",strip.white=TRUE)

body_gyro_x <- read.table("./train/Inertial Signals/body_gyro_x_train.txt",strip.white=TRUE)
body_gyro_y <- read.table("./train/Inertial Signals/body_gyro_y_train.txt",strip.white=TRUE)
body_gyro_z <- read.table("./train/Inertial Signals/body_gyro_z_train.txt",strip.white=TRUE)

total_acc_x <- read.table("./train/Inertial Signals/total_acc_x_train.txt",strip.white=TRUE)
total_acc_y <- read.table("./train/Inertial Signals/total_acc_y_train.txt",strip.white=TRUE)
total_acc_z <- read.table("./train/Inertial Signals/total_acc_z_train.txt",strip.white=TRUE)

#mean (INI)
TbaccxM=vector()
TbaccyM=vector()
TbacczM=vector()

TbgyroxM=vector()
TbgyroyM=vector()
TbgyrozM=vector()

TtaccxM=vector()
TtaccyM=vector()
TtacczM=vector()

#standard dev (INI)
TbaccxSD=vector()
TbaccySD=vector()
TbacczSD=vector()

TbgyroxSD=vector()
TbgyroySD=vector()
TbgyrozSD=vector()

TtaccxSD=vector()
TtaccySD=vector()
TtacczSD=vector()

for (i in 1:length(body_acc_x[,1])){
        #mean
        TbaccxM <- c(TbaccxM,mean(as.numeric(body_acc_x[i,])))
        TbaccyM <- c(TbaccyM,mean(as.numeric(body_acc_y[i,])))
        TbacczM <- c(TbacczM,mean(as.numeric(body_acc_z[i,])))

        TbgyroxM <- c(TbgyroxM,mean(as.numeric(body_gyro_x[i,])))
        TbgyroyM <- c(TbgyroyM,mean(as.numeric(body_gyro_y[i,])))
        TbgyrozM <- c(TbgyrozM,mean(as.numeric(body_gyro_z[i,])))
        
        TtaccxM <- c(TtaccxM,mean(as.numeric(total_acc_x[i,])))
        TtaccyM <- c(TtaccyM,mean(as.numeric(total_acc_y[i,])))
        TtacczM <- c(TtacczM,mean(as.numeric(total_acc_z[i,])))
        
        #sd
        TbaccxSD <- c(TbaccxSD,sd(as.numeric(body_acc_x[i,])))
        TbaccySD <- c(TbaccySD,sd(as.numeric(body_acc_y[i,])))
        TbacczSD <- c(TbacczSD,sd(as.numeric(body_acc_z[i,])))
        
        TbgyroxSD <- c(TbgyroxSD,sd(as.numeric(body_gyro_x[i,])))
        TbgyroySD <- c(TbgyroySD,sd(as.numeric(body_gyro_y[i,])))
        TbgyrozSD <- c(TbgyrozSD,sd(as.numeric(body_gyro_z[i,])))
        
        TtaccxSD <- c(TtaccxSD,sd(as.numeric(total_acc_x[i,])))
        TtaccySD <- c(TtaccySD,sd(as.numeric(total_acc_y[i,])))
        TtacczSD <- c(TtacczSD,sd(as.numeric(total_acc_z[i,])))
}
Table.train.DF <- data.frame(TbaccxM,TbaccxSD,TbaccyM,TbaccySD,TbacczM,TbacczSD,TbgyroxM,TbgyroxSD,TbgyroyM,TbgyroySD,TbgyrozM,TbgyrozSD,TtaccxM,TtaccxSD,TtaccyM,TtaccySD,TtacczM,TtacczSD)
colnames(Table.train.DF) <- c("Body_acc_x.Mean","Body_acc_x.SD","Body_acc_y.Mean","Body_acc_y.SD","Body_acc_z.Mean","Body_acc_z.SD","Body_gyro_x.Mean","Body_gyro_x.SD","Body_gyro_y.Mean","Body_gyro_y.SD","Body_gyro_z.Mean","Body_gyro_z.SD","Total_acc_x.Mean","Total_acc_x.SD","Total_acc_y.Mean","Total_acc_y.SD","Total_acc_z.Mean","Total_acc_z.SD")

# Step 3(c) #
#Creating a a total data frame for the Train set (Train.DF) by joining 
#side by side the columns from dataframes 'Train_subjects','Train_activities', 
#Train_features' and 'Table.train.DF'.
Train.DF <- cbind(Train_Subjects,Train_activities)
Train.DF <- cbind(Train.DF,Train_features)
Train.DF <- cbind(Train.DF,Table.train.DF)

#################
#### STEP 2 ####
#################################################
#################################################
## Repeating the same process for the test set  #
#################################################
#Objective: obtain the data frame Test.DF with all the data 
#for the test set
#############################################################

# Step 2(a) #
#loading data from the set 'test'
Test_Subjects  <- read.csv("./test/subject_test.txt",sep="",header=FALSE)
colnames(Test_Subjects) <- c("Subject.Index")

Test_features <- read.table("./test/X_test.txt",strip.white=TRUE)
colnames(Test_features) <- feat.list  
Test_activities <- read.table("./test/y_test.txt",strip.white=TRUE)
colnames(Test_activities) <- c("Activity.Index")

# Step 2(b) #
#Preprocessing of the mean() and sd() values of the data in the forder
#./test/Inertial Signals/
#objective: create the data frame 'Table.test.DF' that will contain the calculated 
#mean() and sd() values from the data in this folder (18 variables in total)
body_acc_x <- read.table("./test/Inertial Signals/body_acc_x_test.txt",strip.white=TRUE)
body_acc_y <- read.table("./test/Inertial Signals/body_acc_y_test.txt",strip.white=TRUE)
body_acc_z <- read.table("./test/Inertial Signals/body_acc_z_test.txt",strip.white=TRUE)

body_gyro_x <- read.table("./test/Inertial Signals/body_gyro_x_test.txt",strip.white=TRUE)
body_gyro_y <- read.table("./test/Inertial Signals/body_gyro_y_test.txt",strip.white=TRUE)
body_gyro_z <- read.table("./test/Inertial Signals/body_gyro_z_test.txt",strip.white=TRUE)

total_acc_x <- read.table("./test/Inertial Signals/total_acc_x_test.txt",strip.white=TRUE)
total_acc_y <- read.table("./test/Inertial Signals/total_acc_y_test.txt",strip.white=TRUE)
total_acc_z <- read.table("./test/Inertial Signals/total_acc_z_test.txt",strip.white=TRUE)

#mean (INI)
TbaccxM=vector()
TbaccyM=vector()
TbacczM=vector()

TbgyroxM=vector()
TbgyroyM=vector()
TbgyrozM=vector()

TtaccxM=vector()
TtaccyM=vector()
TtacczM=vector()

#standard dev (INI)
TbaccxSD=vector()
TbaccySD=vector()
TbacczSD=vector()

TbgyroxSD=vector()
TbgyroySD=vector()
TbgyrozSD=vector()

TtaccxSD=vector()
TtaccySD=vector()
TtacczSD=vector()

for (i in 1:length(body_acc_x[,1])){
        #mean
        TbaccxM <- c(TbaccxM,mean(as.numeric(body_acc_x[i,])))
        TbaccyM <- c(TbaccyM,mean(as.numeric(body_acc_y[i,])))
        TbacczM <- c(TbacczM,mean(as.numeric(body_acc_z[i,])))
        
        TbgyroxM <- c(TbgyroxM,mean(as.numeric(body_gyro_x[i,])))
        TbgyroyM <- c(TbgyroyM,mean(as.numeric(body_gyro_y[i,])))
        TbgyrozM <- c(TbgyrozM,mean(as.numeric(body_gyro_z[i,])))
        
        TtaccxM <- c(TtaccxM,mean(as.numeric(total_acc_x[i,])))
        TtaccyM <- c(TtaccyM,mean(as.numeric(total_acc_y[i,])))
        TtacczM <- c(TtacczM,mean(as.numeric(total_acc_z[i,])))
        
        #sd
        TbaccxSD <- c(TbaccxSD,sd(as.numeric(body_acc_x[i,])))
        TbaccySD <- c(TbaccySD,sd(as.numeric(body_acc_y[i,])))
        TbacczSD <- c(TbacczSD,sd(as.numeric(body_acc_z[i,])))
        
        TbgyroxSD <- c(TbgyroxSD,sd(as.numeric(body_gyro_x[i,])))
        TbgyroySD <- c(TbgyroySD,sd(as.numeric(body_gyro_y[i,])))
        TbgyrozSD <- c(TbgyrozSD,sd(as.numeric(body_gyro_z[i,])))
        
        TtaccxSD <- c(TtaccxSD,sd(as.numeric(total_acc_x[i,])))
        TtaccySD <- c(TtaccySD,sd(as.numeric(total_acc_y[i,])))
        TtacczSD <- c(TtacczSD,sd(as.numeric(total_acc_z[i,])))
}
Table.test.DF <- data.frame(TbaccxM,TbaccxSD,TbaccyM,TbaccySD,TbacczM,TbacczSD,TbgyroxM,TbgyroxSD,TbgyroyM,TbgyroySD,TbgyrozM,TbgyrozSD,TtaccxM,TtaccxSD,TtaccyM,TtaccySD,TtacczM,TtacczSD)
colnames(Table.test.DF) <- c("Body_acc_x.Mean","Body_acc_x.SD","Body_acc_y.Mean","Body_acc_y.SD","Body_acc_z.Mean","Body_acc_z.SD","Body_gyro_x.Mean","Body_gyro_x.SD","Body_gyro_y.Mean","Body_gyro_y.SD","Body_gyro_z.Mean","Body_gyro_z.SD","Total_acc_x.Mean","Total_acc_x.SD","Total_acc_y.Mean","Total_acc_y.SD","Total_acc_z.Mean","Total_acc_z.SD")

# Step 2(c) #
#Creating a a total data frame for the Test set (Test.DF) by joining 
#side by side the columns from dataframes 'Test_subjects','Test_activities', 
#Test_features', and 'Table.test.DF'.
Test.DF <- cbind(Test_Subjects,Test_activities)
Test.DF <- cbind(Test.DF,Test_features)
Test.DF <- cbind(Test.DF,Table.test.DF)

#################
#### STEP 3 ####
#############################################################
### Creating a Total Total.DF data frame by adding the rows  
### from Test.DF at the end of Train.DF
######################################################
Total.DF <- rbind(Train.DF,Test.DF)
write.csv(Total.DF, file="Total.csv")

##################
#### STEP 4 #####
################################################################
######## Deriving a second tydy data set from Total.DF #########
################################################################

subjectIndex=25
#This function takes as an argument the 'Total.DF' data frame, the indices 
#of the activities [1,..,6] and an index from a Subject [1,...,30]
#For the selected subject we create a data frame that contains the 6 activities 
#and the mean values of the variables for each activity calculated from the full
#data frame 'Total.DF'
getpiece <- function(Total.DF,activities,subjectIndex){
        for (i in activities$Activity.Index){
                conditional=substitute(Total.DF$Subject.Index==subjectIndex & Total.DF$Activity.Index==i)
                tmp=Total.DF[eval(conditional,Total.DF),]
                if(i==1){
                        tmp1<-data.frame(colMeans(tmp),check.names=TRUE)
                }else{
                        tmp2<-data.frame(colMeans(tmp),check.names=TRUE)
                        tmp1<-cbind(tmp1,tmp2)
                }
                
        }
        tmp1[1,1]<-subjectIndex
        tmp1<-as.data.frame(t(tmp1))
        colnames(tmp1)<-names(Total.DF)
        return(tmp1)

}
#aa<-getpiece(Total.DF,activities,subjectIndex)

#In this for loop we obtain for each subject [1,...,30] a data frame
#using the function 'getpiece'. We finally put merge all those data frames
#into Reduced.DF that contains for each Subject, the mean values of the variables
#per activity.
for (j in 1:length(unique(Total.DF$Subject.Index))){
        if(j==1){
                Reduced.DF<-getpiece(Total.DF,activities,1)
        }else{
                vecn<-getpiece(Total.DF,activities,j)
                Reduced.DF<-rbind(Reduced.DF,vecn)
        }
}

###################
##### STEP 5 #####
############################
## Saving the results ###################################
#########################################################
write.csv(Total.DF, file="Total.csv")
write.csv(Reduced.DF, file="Reduced.csv") #to upload at the Github link.
#saving for uploading at the cousera project peer review evaluation website.
write.table(Reduced.DF,file="Reduced.txt",row.name=FALSE)
