# Pre-graded sssignment - Getting and cleaning data - 3rd course
library(dplyr)

# Trying to load file
path <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  
if(!file.exists("./data")){
  dir.create("./data")
}
  
if(!file.exists("./data/data.zip")){
  mfile <- download.file(path, destfile = "./data/data.zip", mode = "wb")
  unzip("./data/data.zip", exdir = "./data")
}

# Pathes to files
TrainDataPathX <- "./data/UCI HAR Dataset/train/X_train.txt"
TrainDataPathY <- "./data/UCI HAR Dataset/train/y_train.txt"
TestDataPathY <- "./data/UCI HAR Dataset/test/y_test.txt"
TestDataPathX <- "./data/UCI HAR Dataset/test/X_test.txt"

# Reading train data
trainingLabels <- read.table(TrainDataPathY)
trainingSet <- read.table(TrainDataPathX)

# Add subject
trainingSet$subject <- trainingLabels$V1

# Add type data - may be it will be usefull later
trainingSet$type <- "train"

# Reading test data
testLabels <- read.table(TestDataPathY)
testSet <- read.table(TestDataPathX)

# Add subject
testSet$subject <- testLabels$V1

# Add type data - may be it will be usefull later
testSet$type <- "test"

labels <- read.table("./data/UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
str(labels[2])

# 1. Binding two datasets
data <- rbind(trainingSet, testSet)

# Removing unnecessary datasets
rm(testSet)
rm(testLabels)
rm(trainingSet)
rm(trainingLabels)

# 3. Name columns
names(data) <- c(labels$V2, "subject", "type")

# 4. Merging with activity labels
activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)
data <- merge(data, activity_labels, by.x = "subject", by.y = "V1", all = TRUE)

# Change new column name
colnames(data)[564] <- "activity"
data$activity <- as.factor(data$activity)

# 2. Extract only mean and std from data by labels
mean_std_data <- data[, c(labels[grepl("mean", labels$V2)|grepl("std", labels$V2),]$V2, "activity")]

# 5. grouped dataset
gr_data <- mean_std_data %>% group_by(activity) %>% summarize_all(mean)



















