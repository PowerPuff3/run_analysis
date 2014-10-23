 ###You should create one R script called run_analysis.R that does the following. 
#1)Merges the training and the test sets to create one data set.
#2)Extracts only the measurements on the mean and standard deviation for each measurement. 
#3)Uses descriptive activity names to name the activities in the data set
#4)Appropriately labels the data set with descriptive variable names. 
#5)From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

###
# Get the data  and load to global environment
setwd("C:/Users/Citrus/Desktop/R Directory/Getting and Cleaning Data/HAR Dataset")
 x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
 y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
 subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

 labels <- read.table("UCI HAR Dataset/activity_labels.txt")
 features <- read.table("UCI HAR Dataset/features.txt")

 x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
 y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
 subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt") 

# Build a data set for the Activities
y <- rbind(y_train, y_test)
colnames(y) <- c("ID")
colnames(labels) <- c("ID", "Activities")

ylabel <- data.frame(labels[y$ID, "Activities"])
colnames(ylabel) <- c("Activities")

# Build a data set for the Measurements/ Features
x <- rbind(x_train, x_test)
colnames(x) <- features[[2]]

x <- rbind(x_train,x_test)
colnames(x) <- features[[2]]
subject <- rbind(subject_train,subject_test)
colnames(subject) <- c("Volunteers")
 
# Merge data  to create one dataset(Subjects, Activities and Measurements)      
dataset <- cbind(subject,ylabel)
dataset2 <- cbind(dataset,x)
 
# Get the measurements for the mean and standard deviation      
tidy <-dataset2[c(1,2,grep("mean\\(", colnames(dataset2)),
                      grep("std\\(", colnames(dataset2)))]

# Create an aggregate dataset (mean) 
tidy.mean <- aggregate(tidy[3:68], 
                       by=list(Volunteers=tidy$Volunteers,
                       Activities=tidy$Activities),FUN=mean)

# Create final 2 files
write.csv(tidy, "tidy.csv", row.names=FALSE)
write.csv(tidy.mean, "tidy.mean.csv", row.names=FALSE)
