galaxy-s-accelerometer
======================

Getting and Cleaning Data - Course Project Submission

The R script "run_analysis.R" was developed according the requirements defined in the Course Project page. The requirements defined the following steps:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The script performs these steps in the following sequence: 1 -> 4 -> 2 -> 3-> 5. Labelling was performed earlier to aid the extraction process in Step 2. 

The script generates an object named "completemeans" that is a 180 x 65 matrix.



NOTE: For the script to run properly, the following requirements must be met:
1. The working directory must include the folder "UCI HAR Dataset"
2. The reshape2 package must be installed and loaded