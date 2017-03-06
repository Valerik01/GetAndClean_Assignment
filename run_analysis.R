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
trainSubjects <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

# Add subjects and labels to train
trainingSet$label <- trainingLabels$V1
trainingSet$subject <- trainSubjects$V1

# Reading test data
testLabels <- read.table(TestDataPathY)
testSet <- read.table(TestDataPathX)
testSubjects <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

# Add subjects and labels
testSet$label <- testLabels$V1
testSet$subject <- testSubjects$V1

labels <- read.table("./data/UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)

# 1. Binding two datasets
data <- rbind(trainingSet, testSet)

# Removing unnecessary datasets
rm(testSet)
rm(testLabels)
rm(trainingSet)
rm(trainingLabels)

# 3. Name columns
names(data) <- c(labels$V2, "label", "subject")


# 4. Merging with activity labels
activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)
colnames(activity_labels) <- c("label", "activity")
data <- merge(data, activity_labels, by = "label")
data$activity <- as.factor(data$activity)

# 2. Extract only mean and std from data by labels
mean_std_data <- data[, c(labels[grepl("mean", labels$V2)|grepl("std", labels$V2),]$V2, "subject", "activity")]

# 5. grouped dataset
gr_data <- mean_std_data %>% group_by(activity, subject) %>% summarize_all(mean)

write.table(gr_data, file = "output.txt", row.names = FALSE)
summary(gr_data)

















