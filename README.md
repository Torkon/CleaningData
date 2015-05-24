# Markdown file for run_analysis.

## Data set requirements

The UCI HAR Dataset folder needs can be downloaded from "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" Download that file and unzip it in the working directory of R. For for information about that original dataset, please read "http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones".

The "UCI HAR Dataset" folder needs to be  in the working directory. In the "UCI HAR Dataset" folder
there need to be the following 2 files.
* "activity_labels.txt" containing the table with the activities labeling
* "features.txt" containing the column labels

Under the "UCI HAR Dataset" folder there should be two folders called "test" and "train". Each of those
folders contains the data for the test and training set respectively. That is stored in the files.

* "subjects_test.txt" containing the subject IDs for the test set
* "X_test.txt" containing the variable data for the test set
* "y_test.txt" containing the activity data per subject id and observation

* "subjects_train.txt" containing the subject IDs for the test set
* "X_train.txt" containing the variable data for the test set
* "y_train.txt" containing the activity data per subject id and observation

## Program Structure

1. First the required packages / libraries are loaded plyr and dplyr.
2. The script checks if the "UCI HAR Dataset" is in the working directory. If it is not in the working directory, it stops execution.
3. The script loads all the data files mentioned above into data frames.
4. The program comines the test and train sets. This is done by joining the data for the variables, for the activities, and for the subject IDs, then the program labels the subject ID column as "Subject_ID"
5. The program labels the variables columns with readable labels. The column names are extracted from the "features.txt" file and converted into R compatible labels. This is necessary since only certain characters are allowed as in labeling.
6. The script adds the Subject_ID column and the Activity column to the combined data set data frame.
7. The program file Uses descriptive activity names to name the activities in the data set and removes not needed columns.
8. The program keeps only columns from the original data set which has mean and standard deviation for each measurement in the name. For that purpose it checks if the measurement column name contains "Mean" or "mean" or "MEAN" or "Std" or "STD" or "std". All other columnes are removed. This is the combined cleaned up data set in the wide form. From there on the next step summarizes the data.
9. The program creates now a second, independent tidy data set with the average of each variable for each activity and each subject using the group funtion.
10. The last step in the script is writing this tidy data set into a file called "tidyfinaldataset.txt" in the working directory.



