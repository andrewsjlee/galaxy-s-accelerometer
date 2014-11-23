# Read the following data into R: X_train, X_test, subject_train, subject_test, y_train, y_test, features, and activity_labels

X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
features <- read.table("UCI HAR Dataset/features.txt")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")


# Merge the sensor data (X_train and X_test) data and pass it to a new object called "X_traintest"

X_traintest <- rbind(X_train, X_test)


# Rename the sensor variable names using the labels from the "features" table

names(X_traintest) <- features$V2


# Subset the variables that measure means and standard deviations and pass them to a new object called "x_tidy."

average <- grep("mean", names(X_traintest))
meandata <- X_traintest[, average]
std <- grep("std", names(X_traintest))
stddata <- X_traintest[, std]

X_meanstd <- cbind(meandata, stddata)

meanFreq <- grep("meanFreq", names(X_meanstd))
X_tidy <- X_meanstd[, -meanFreq]


# Merge the subject data from subject_train and subject_test and pass and pass the data frame to a new object called "subject_traintest." Name the variable "subject."

subject_traintest <- rbind(subject_train, subject_test)
names(subject_traintest) <- "subject"


# Merge the y_train and y_test data and pass it to a new object called "y_traintest." Name the variable "activity."

y_traintest <- rbind(y_train, y_test)
names(y_traintest) <- "activity"


# Merge the sensor data, subject data, and activity data together and pass it to a new data frame called "complete."

complete <- cbind(X_tidy, subject_traintest, y_traintest)


# Tidy the variable names

names(complete) <- make.names(names(complete))

# Add an activity descriptions variable called "activitydesc," which takes the data from the "activity" variable and turns it into a qualitative descriptor. Drop the "activity" variable afterwards.

complete$activitydesc <- "Walking"
complete$activitydesc[complete$activity == 2] <- "Walking_Upstairs"
complete$activitydesc[complete$activity == 3] <- "Walking_Downstairs"
complete$activitydesc[complete$activity == 4] <- "Sitting"
complete$activitydesc[complete$activity == 5] <- "Standing"
complete$activitydesc[complete$activity == 6] <- "Laying"

complete$activity <- NULL

# "Melt" the data so that there is a line for each measurement by subject and activity type. "Recast" the data so that the means are reported for each measurement, by subject and activity type.

mdata <- melt(complete, id= c("subject", "activitydesc"))
completemeans <- dcast(mdata, subject + activitydesc ~ variable, mean)


