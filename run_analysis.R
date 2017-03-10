# Pre-graded sssignment - Getting and cleaning data - 3rd course
library(dplyr)

# 1: Add path to file
path <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
 
# 2: Check if exist folder "data" 
if(!file.exists("./data")){
  dir.create("./data")
}
  
# 3: Check if exist file "data.zip" 
if(!file.exists("./data/data.zip")){
  mfile <- download.file(path, destfile = "./data/data.zip", mode = "wb")
  unzip("./data/data.zip", exdir = "./data")
}

# 4: Read training data
training.data <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
training.labels <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
training.subjects <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

# 5: Add subjects and labels to main training data
training.data$label <- training.labels$V1
training.data$subject <- training.subjects$V1

# 6: Read test data
test.data <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
test.labels <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
test.subjects <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

# 7: Add subjects and labels to main test data
test.data$label <- test.labels$V1
test.data$subject <- test.subjects$V1

# 8. Bind training and test datasets
common.data <- rbind(training.data, test.data)

# 9: Read features file
features <- read.table("./data/UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)

# 10: Removing unnecessary big datasets
rm(test.data)
rm(test.labels)
rm(training.data)
rm(training.labels)

# 11: Change columns names
colnames(common.data) <- c(features$V2, "label", "subject")

# 12: Read activity labels
activity.labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)

# 13: Assign col names
colnames(activity.labels) <- c("label", "activity")

# 14: Merge our main dataset with activity and change "activity" column to factor
common.data <- merge(common.data, activity.labels, by = "label")
common.data$activity <- as.factor(common.data$activity)

# 15: Extract only mean and std from data by labels
mean_std.data <- common.data[, c(features[grepl("mean", features$V2)|grepl("std", features$V2),]$V2, "subject", "activity")]

# 16: Get grouped dataset
grouped.data <- mean_std.data %>% group_by(activity, subject) %>% summarize_all(mean)

# 17: Write output.txt file from main grouped dataset
write.table(grouped.data, file = "output.txt", row.names = FALSE)


















