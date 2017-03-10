Coursera, get and clean data, course project

1: Add path to file
"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

2: Check if exist folder "data"
Create it if it doesn't exist

3: Check if exist file "data.zip" - if doesn't - it means we have to download it and unpack

4: Read training data from file

5: Add subjects and labels to main training data
Columns names are "label" and "subject"

6: Read test data from file

7: Add subjects and labels to main test data. Columns names are "label" and "subject"

8: Bind training and test datasets

9: Read features file

10: Removing unnecessary big datasets (not necessarily but possible)

11: Change columns names

12: Read activity labels

13: Assign col names

14: Merge our main dataset with activity and change "activity" column to factor

15: Extract only mean and std from data by labels

16: Get grouped dataset

17: Write output.txt file from main grouped dataset






