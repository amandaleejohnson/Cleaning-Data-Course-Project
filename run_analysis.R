# The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set.

# Review criteria
        # 
        # The submitted data set is tidy.
        # The Github repo contains the required scripts.
        # GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries 
        #calculated, along with units, and any other relevant information.
        # The README that explains the analysis files is clear and understandable.
        # The work submitted for this project is the work of the student who submitted it.
        #

# Getting and Cleaning Data Course Project
# 
# The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 
# The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related 
# to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for 
# performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean 
# up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work 
# and how they are connected.
# # 
# # One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike,
# and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data 
# collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
#         
#         http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
# 
# Here are the data for the project:
#         
#         https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# 
#HELPFUL GUIDE:
#         https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/
#        
#
# You should create one R script called run_analysis.R that does the following.

setwd("C:/Users/ajohns34/Box/Data Science Specialization/Assignment 5")
##Install all packages needed in script:
install.packages(c("dplyr", "doBy", "data.table", "dataMaid"))

#Checking for and creating directories
# file.exists("directoryname") - looks to see if the directory exists - T/F
# dir.create("directoryname") - creates a directory if it doesn't exist

#If the directory doesn't exist, make a new one:
if(!file.exists("data")) {
        dir.create("data")
}

##Give full path 
list.files(full.names=TRUE)
##list files in the data directory
list.files("data/", full.names=TRUE)
test_files = list.files("./data/test/", full.names=TRUE)
train_files = list.files("./data/train/", full.names=TRUE)

#################################################################                
# Merges the training and the test sets to create one data set.
#################################################################

#Explore the feature and activity_label files:
list.files("C:/Users/ajohns34/Box/Data Science Specialization/Assignment 5", full.names = TRUE)                 
# - 'features.txt': List of all features.
features = read.table("./features.txt", header = FALSE) 
# - 'activity_labels.txt': Links the class labels with their activity name.
activity_labels = read.table("./activity_labels.txt", header = FALSE)
#1 = WALKING
#2 = WALKING_UPSTAIRS
#3 = WALKING_DOWNSTAIRS
#4 = SITTING
#5 = STANDING
#6 = LAYING


##Read in dplyr library!
library(dplyr)        
        
        
        #################################################################
        # Appropriately labels the data set with descriptive variable names.
        #################################################################        
        #Combine the testing data set and labels into one data.frame:
        test = read.table("./data/test/X_test.txt", header = FALSE)
        #Features is n=561 rows while test is 561 variables. 
        #It is safe to assume that second row in features can be used to
        #create the column names in test
        colnames(test) = features[,2]
        
        #Combine the training data set and labels into one data.frame:
        train = read.table("./data/train/X_train.txt", header = FALSE)
        #Features is n=561 rows while train is 561 variables. 
        #It is safe to assume that second row in features can be used to
        #create the column names in train
        colnames(train) = features[,2]
        
        #################################################################                
        # Extracts only the measurements on the mean and standard deviation for each measurement.
        #################################################################
        #Use grep to see which variables contain the word "mean" and std".
        #Although there are extra vars that contain "meanFreq()" - I'm not interested in these.
        #According to the features_info.txt: 
        #meanFreq(): Weighted average of the frequency components to obtain a mean frequency
        #Because I want an equal number of vars for mean and std.
        #grep is included in base R so there is no library to read in.
        
        std_cols_test = test[grepl("std()", names(test), fixed = TRUE)]        
        mean_cols_test = test[grepl("mean()", names(test), fixed = TRUE)]        
        
        std_cols_train = train[grepl("std()", names(train), fixed = TRUE)]        
        mean_cols_train = train[grepl("mean()", names(train), fixed = TRUE)]        
        
        #################################################################
        #Appropriately labels the data set with descriptive variable names 
        #################################################################
        # From features_info.txt file:
        # The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. 
        # These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. 
        # Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to 
        # remove noise. 
        # Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) 
        # using another low pass 
        # Butterworth filter with a corner frequency of 0.3 Hz. 
        # 
        # Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals 
        # (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). 
        # Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, 
        # tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, 
        # tBodyGyroJerkMag). 
        # 
        # Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, 
        # fBodyGyro-XYZ, fBodyAccJerkMag, 
        # fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 
        # 
        # These signals were used to estimate variables of the feature vector for each pattern:  
        # '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.
        
        mean_col_names = c("MeanBodyAccelerationSignalXAxis", "MeanBodyAccelerationSignalYAxis", "MeanBodyAccelerationSignalZAxis", "MeanGravityAccelerationSignalXAxis", "MeanGravityAccelerationSignalYAxis", "MeanGravityAccelerationSignalZAxis", "MeanBodyAccelerationJerkSignalXAxis", "MeanBodyAccelerationJerkSignalYAxis", "MeanBodyAccelerationJerkSignalZAxis", "MeanBodyGyroSignalXAxis", "MeanBodyGyroSignalYAxis", "MeanBodyGyroSignalZAxis", "MeanBodyGyroJerkSignalXAxis", "MeanBodyGyroJerkSignalYAxis", "MeanBodyGyroJerkSignalZAxis", "MeanMagnitudeOfBodyAccelerationSignal", "MeanMagnitudeOfGravityAccelerationSignal", "MeanMagnitudeOfBodyAccelerationJerkSignal", "MeanMagnitudeOfBodyGyroSignal", "MeanMagnitudeOfBodyGyroJerkSignal", "MeanFrequencyDomainBodyAccelerationSignalXAxis", "MeanFrequencyDomainBodyAccelerationSignalYAxis", "MeanFrequencyDomainBodyAccelerationSignalZAxis", "MeanFrequencyDomainBodyAccelerationJerkSignalXAxis", "MeanFrequencyDomainBodyAccelerationJerkSignalYAxis", "MeanFrequencyDomainBodyAccelerationJerkSignalZAxis", "MeanFrequencyDomainBodyGyroSignalXAxis", "MeanFrequencyDomainBodyGyroSignalYAxis", "MeanFrequencyDomainBodyGyroSignalZAxis", "MeanMagnitudeOfBodyAccelerationFrequencyDomainSignal", "MeanMagnitudeOfBodyAccelerationJerkFrequencyDomainSignal", "MeanMagnitudeOfBodyGyroFrequencyDomainSignal", "MeanMagnitudeOfBodyGyroJerkFrequencyDomainSignal")
        std_col_names = c("StdBodyAccelerationSignalXAxis", "StdBodyAccelerationSignalYAxis", "StdBodyAccelerationSignalZAxis", "StdGravityAccelerationSignalXAxis", "StdGravityAccelerationSignalYAxis", "StdGravityAccelerationSignalZAxis", "StdBodyAccelerationJerkSignalXAxis", "StdBodyAccelerationJerkSignalYAxis", "StdBodyAccelerationJerkSignalZAxis", "StdBodyGyroSignalXAxis", "StdBodyGyroSignalYAxis", "StdBodyGyroSignalZAxis", "StdBodyGyroJerkSignalXAxis", "StdBodyGyroJerkSignalYAxis", "StdBodyGyroJerkSignalZAxis", "StdMagnitudeOfBodyAccelerationSignal", "StdMagnitudeOfGravityAccelerationSignal", "StdMagnitudeOfBodyAccelerationJerkSignal", "StdMagnitudeOfBodyGyroSignal", "StdMagnitudeOfBodyGyroJerkSignal", "StdFrequencyDomainBodyAccelerationSignalXAxis", "StdFrequencyDomainBodyAccelerationSignalYAxis", "StdFrequencyDomainBodyAccelerationSignalZAxis", "StdFrequencyDomainBodyAccelerationJerkSignalXAxis", "StdFrequencyDomainBodyAccelerationJerkSignalYAxis", "StdFrequencyDomainBodyAccelerationJerkSignalZAxis", "StdFrequencyDomainBodyGyroSignalXAxis", "StdFrequencyDomainBodyGyroSignalYAxis", "StdFrequencyDomainBodyGyroSignalZAxis", "StdMagnitudeOfBodyAccelerationFrequencyDomainSignal", "StdMagnitudeOfBodyAccelerationJerkFrequencyDomainSignal", "StdMagnitudeOfBodyGyroFrequencyDomainSignal", "StdMagnitudeOfBodyGyroJerkFrequencyDomainSignal") 
         
        colnames(mean_cols_test) = mean_col_names
        colnames(mean_cols_train) = mean_col_names
        
        colnames(std_cols_test) = std_col_names
        colnames(std_cols_train) = std_col_names
        
        #################################################################
        # Uses descriptive activity names to name the activities in the data set
        #################################################################
        test_labels = read.table("./data/test/y_test.txt", header = FALSE)
        #The second column in the activity_labels data.frame can be used to label the 
        #rows in the test_labels data frame. 
        ##HOWEVER - MERGE REORDERS THE DATA!
        #LEFT JOIN DOESN'T REORDER DATA!!
        test_labels=left_join(test_labels, activity_labels, by="V1")
        
        #Give the columns names too:
        #Activity number = numerical value of the activity
        #Activity name = activity name corresponding to each numerica value
        #Rename the variable to be more descriptive
        test_labels=rename(test_labels, "activitynumber"=V1, "activityname"=V2)
        
        train_labels = read.table("./data/train/y_train.txt", header = FALSE)
        #The second column in the activity_labels data.frame can be used to label the 
        #rows in the train_labels data frame. 
        train_labels=left_join(train_labels, activity_labels, by="V1")
        #Rename the variable to be more descriptive
        train_labels=rename(train_labels, "activitynumber"=V1, "activityname"=V2)
        
        #################################################################
        # Read in the subject id's that are in each sample
        #################################################################
        subject_test = read.table("./data/test/subject_test.txt", header = FALSE)
        #Rename the variable to be more descriptive
        subject_test = rename(subject_test, "volunteerid" = V1)
        
        subject_train = read.table("./data/train/subject_train.txt", header = FALSE)
        #Rename the variable to be more descriptive
        subject_train = rename(subject_train, "volunteerid" = V1)
        
        #################################################################
        # Combine all the test-specific dfs into 1 full one
        # Combine all the train-specific dfs into 1 full one
        #################################################################
        #Combine all the data.frames together!
        test_full = cbind(mean_cols_test, std_cols_test, test_labels, subject_test)
        
        #Combine all the data.frames together!
        train_full = cbind(mean_cols_train, std_cols_train, train_labels, subject_train)

        #################################################################
        # Add a column as the last column to signify the sample
        #################################################################
        #Add a column as the last column to signify that these individuals
        #were included in the test dataset
        test_full$sample = "test"
        
        #Add a column as the last column to signify that these individuals
        #were included in the train dataset
        train_full$sample = "train"
        
        #################################################################
        # Combine the train_full and test_full data frames!
        #################################################################        
        #Since each full data frame has the same column names 
        #to represent the same categories of values, we can use rbind
        #to stack the data frames on top of one another
        combined_tidy=rbind(train_full, test_full)
                
     
#################################################################
# From the data set in step 4, creates a second, 
# independent tidy data set with the average of each variable for:
        #each activity and each subject.
#################################################################
        
#From the help site:
        #Is an average of a standard deviation even a thing?
                
        #Short answer. Doesn't matter, you are being asked to produce a average 
        #for each combination of subject, activity, and variable as a sign you 
        #can manipulate the data. Long answer, yes it is a thing.
        
        #30 subjects x 6 activities x 66 variables (33 mean, 33 sd) = 11,880

#####doBy and summaryBy examples
        
        #source: https://stats.idre.ucla.edu/r/faq/how-can-i-collapse-my-data-in-r/
        
        # Users of Stata are likely familiar with the concept of collapsing data: reducing the number of observations in your data, 
        # keeping one observation for each value or combination of values from one or more variables and calculating some summary 
        # of the other variables at this level. For examples of this in Stata, see our Stata Learning Module on collapse.
        
        
        # This data management step can also be done in R using the summaryBy command in the doBy package. 
        # Let's consider the dataset hsb2. We can start by collapsing the data by prog and calculating the mean of socst. 
        # The default summary calculation is the mean, as indicated by the output.
        
        #summaryBy(socst ~ prog, data=hsb2)
        
        # We can easily make our collapse more complex, creating one observation for each combination of prog and female and ses, 
        # calculating both the mean and standard deviation of several variables, and saving this as a new object.
        
        #collapse1 <- summaryBy(socst + math ~ prog + ses + female, FUN=c(mean,sd), data=hsb2)
        
        library(doBy)
        
        average_tidy = summaryBy(MeanBodyAccelerationSignalXAxis + MeanBodyAccelerationSignalYAxis + 
                                         MeanBodyAccelerationSignalZAxis + MeanGravityAccelerationSignalXAxis + 
                                         MeanGravityAccelerationSignalYAxis + MeanGravityAccelerationSignalZAxis + 
                                         MeanBodyAccelerationJerkSignalXAxis + MeanBodyAccelerationJerkSignalYAxis + 
                                         MeanBodyAccelerationJerkSignalZAxis + MeanBodyGyroSignalXAxis + 
                                         MeanBodyGyroSignalYAxis + MeanBodyGyroSignalZAxis + 
                                         MeanBodyGyroJerkSignalXAxis + MeanBodyGyroJerkSignalYAxis + 
                                         MeanBodyGyroJerkSignalZAxis + MeanMagnitudeOfBodyAccelerationSignal + 
                                         MeanMagnitudeOfGravityAccelerationSignal + 
                                         MeanMagnitudeOfBodyAccelerationJerkSignal + MeanMagnitudeOfBodyGyroSignal + 
                                         MeanMagnitudeOfBodyGyroJerkSignal + 
                                         MeanFrequencyDomainBodyAccelerationSignalXAxis + 
                                         MeanFrequencyDomainBodyAccelerationSignalYAxis + 
                                         MeanFrequencyDomainBodyAccelerationSignalZAxis + 
                                         MeanFrequencyDomainBodyAccelerationJerkSignalXAxis + 
                                         MeanFrequencyDomainBodyAccelerationJerkSignalYAxis + 
                                         MeanFrequencyDomainBodyAccelerationJerkSignalZAxis + 
                                         MeanFrequencyDomainBodyGyroSignalXAxis + MeanFrequencyDomainBodyGyroSignalYAxis + 
                                         MeanFrequencyDomainBodyGyroSignalZAxis + MeanMagnitudeOfBodyAccelerationFrequencyDomainSignal + 
                                         MeanMagnitudeOfBodyAccelerationJerkFrequencyDomainSignal + 
                                         MeanMagnitudeOfBodyGyroFrequencyDomainSignal + MeanMagnitudeOfBodyGyroJerkFrequencyDomainSignal + 
                                         StdBodyAccelerationSignalXAxis + StdBodyAccelerationSignalYAxis + StdBodyAccelerationSignalZAxis + 
                                         StdGravityAccelerationSignalXAxis + StdGravityAccelerationSignalYAxis + 
                                         StdGravityAccelerationSignalZAxis + StdBodyAccelerationJerkSignalXAxis + 
                                         StdBodyAccelerationJerkSignalYAxis + StdBodyAccelerationJerkSignalZAxis + StdBodyGyroSignalXAxis + 
                                         StdBodyGyroSignalYAxis + StdBodyGyroSignalZAxis + StdBodyGyroJerkSignalXAxis + 
                                         StdBodyGyroJerkSignalYAxis + StdBodyGyroJerkSignalZAxis + StdMagnitudeOfBodyAccelerationSignal + 
                                         StdMagnitudeOfGravityAccelerationSignal + StdMagnitudeOfBodyAccelerationJerkSignal + 
                                         StdMagnitudeOfBodyGyroSignal + StdMagnitudeOfBodyGyroJerkSignal + 
                                         StdFrequencyDomainBodyAccelerationSignalXAxis + StdFrequencyDomainBodyAccelerationSignalYAxis + 
                                         StdFrequencyDomainBodyAccelerationSignalZAxis + StdFrequencyDomainBodyAccelerationJerkSignalXAxis + 
                                         StdFrequencyDomainBodyAccelerationJerkSignalYAxis + StdFrequencyDomainBodyAccelerationJerkSignalZAxis + 
                                         StdFrequencyDomainBodyGyroSignalXAxis + StdFrequencyDomainBodyGyroSignalYAxis + 
                                         StdFrequencyDomainBodyGyroSignalZAxis + StdMagnitudeOfBodyAccelerationFrequencyDomainSignal + 
                                         StdMagnitudeOfBodyAccelerationJerkFrequencyDomainSignal + StdMagnitudeOfBodyGyroFrequencyDomainSignal + 
                                         StdMagnitudeOfBodyGyroJerkFrequencyDomainSignal
                                        ~ volunteerid + activityname, data=combined_tidy)
        
        #################################################################
        # Rename the columns to remove the ".mean"
        #################################################################
        library(data.table)
        setnames(average_tidy, colnames(average_tidy), gsub(".mean", "", colnames(average_tidy)))

        
        new_vars = c() 
        for (i in colnames(average_tidy[3:ncol(average_tidy)])){
                new_vars = c(new_vars, paste0("averageof",i))
        }
        colnames(average_tidy)[3:ncol(average_tidy)] = new_vars
        
        
################################################################# 
# Generate a codebook for the combined tidy data set 
# And a separate data set for the average tidy data set
#################################################################        
        library(dataMaid)        
        makeCodebook(combined_tidy)
        makeCodebook(average_tidy)
        
#################################################################
# Please upload the tidy data set created in step 5 of the instructions. 
# Please upload your data set as a txt file created with write.table() 
# using row.name=FALSE 
# (do not cut and paste a dataset directly into the text box, as this may cause errors saving your submission).
#################################################################        
        write.table(average_tidy, file = "C:/Users/ajohns34/Box/Data Science Specialization/Assignment 5/average_tidy.txt", row.names = FALSE)
        
        #If a reviewer wants to read the file back in, they can do so by using the following code:
        average_tidy_text = read.table("C:/Users/ajohns34/Box/Data Science Specialization/Assignment 5/average_tidy.txt", header = TRUE) 
        