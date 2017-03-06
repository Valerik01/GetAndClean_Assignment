# GetAndClean_Assignment
Coursera, get and clean data, course project

We have to download data, with checking existing directories

First we merge test and train data, and get column names from separate file (file "features.txt") as "labels" dataset

We set descriptive variable names to dataset "data", add an activity column with values from y_train and y_test, and merge data with activity_labels for getting string activity names and use it as factor

By grepl We reveal all column names which consists with "std" and "mean" words and create new data set mean_std_data

At last we group mean_std_data by activity and get mean value for all columns





