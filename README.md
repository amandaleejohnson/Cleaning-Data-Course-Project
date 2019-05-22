# GettingandCleaningDataAssignment
# Peer-graded Assignment: Getting and Cleaning Data Course Project
The purpose of this project is to demonstrate my ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. I was required to submit: 1) a tidy data set, 2) a link to a Github repository with my script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that I performed to clean up the data called CodeBook.md. This README.md in the repository explains how all of the scripts work and how they are connected. 

An incredibly helpful guide that I found from the course forum is available here: https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/ 

I also found this paper by Hadley Wickham on tidy data to be immensely helpful: http://vita.had.co.nz/papers/tidy-data.pdf

# Getting Started
The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

For more information contact: activityrecognition@smartlab.ws

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.
Each record contains the following: triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration, triaxial angular velocity from the gyroscope, a 561-feature vector with time and frequency domain variables, an activity label, and an identifier of the subject who carried out the experiment. Features are normalized and bounded within [-1,1].
## Prerequisite Packages ##
If not already installed, be sure to install the following packages in R: dplyr, doBy, data.table, dataMaid. There is code included 
install.packages(c("dplyr", "doBy", "data.table", "dataMaid"))

# Tasks
I created one R script called run_analysis.R that does the following: 
1.	Explores the feature and activity_label files
2.	For each of the training and test sets, combines the data and labels into one data.frame
3.	Merges the training and the test sets to create one data set.
*	Reads in the subject id's that are in each sample
*	Add a column (as the last column) to signify the sample (test or training)
4.	Extracts only the measurements on the mean and standard deviation for each measurement. 
*	Use “grep” to see which variables contain the word "mean" and std". Although there are extra vars that contain "meanFreq()", according to the features_info.txt, “meanFreq(): Weighted average of the frequency components to obtain a mean frequency”. Therefore, I am not interested in these extra variables. 
*	**NOTE**: grep is included in base R so there is no library to read in.        
5.	Uses descriptive activity names to name the activities in the data set
*	activityname = Name of activity (e.g., Walking, Laying, etc.)
*	activitynumber = Numerical value of activity from 
6.	Appropriately labels the data set with descriptive variable names. 
*	From course notes on tips for naming variables:
    1.	Use lowercase whenever possible
    2.	Use descriptive names (Diagnosis vs. Dx)
    3.	Don’t include underscores or dots or white spaces
*	From the “features_info.txt” file: *"The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). These signals were used to estimate variables of the feature vector for each pattern: '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions."*
  *	Therefore, my process for appropriately labeling the data set was as follows:
    * Expand each word as follows so they are descriptive:
        1.	Acc = Acceleration
        2.	Mag = Magnitude
        3.	–X = X Axis
        4.	–Y = Y Axis
        5.	–Z = Z Axis
        6.	Jerk = Jerk Signal
        7.	fBody = Frequency Domain Body
    *	Maintain the lack of white spaces
    *	For readability, capitalizing each word (I found the variable names in all lowercase to be difficult to read).
7.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
    * Being someone who is most experienced in Stata, I found a great resource that explains how the Stata command “collapse” can be equivalently completed in R using the doBy package: https://stats.idre.ucla.edu/r/faq/how-can-i-collapse-my-data-in-r/        
8.	Creates codebooks for the combined and average tidy data sets using dataMaid
    * The codebook includes information about the study design, variables (including units!) in the data set not contained in the tidy data, information about the summary choices you made, and information about the experimental study design you used
9.	Uploads the average tidy data set as a txt file created with write.table()
# Acknowledgments
•	Thank you to David Hood and his helpful blog, https://thoughtfulbloke.wordpress.com


