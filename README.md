# Getting and Cleaning Data - Course project

## Summary
Course Project of "Getting and Cleaning Data" course provided by [Coursera](https://www.coursera.org/) 
Given a [source data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip), run the script "run_analysis.R" (R language) to create a tidy data set. 

## Data preparation 
1. Download the [original data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). 
2. Unzip the data in the working directory. A directory named "UCI HAR Dataset" is created that includes all the files of the data source. 
3. Run the scrip "run_analysis.R" in the working directory to create a tidy data set.  



## How does the script work
### 1. Merges the training and the test sets to create one data set. 
The training and test data sets are combined in a single data set. The first two columns of the data set identify the subject id ("Subject.ID") and the activity ID ("Activity.ID"), while the remaining columns display the measurements/calculations performed in all the signals measured. 

### 2. Extracts only the measurements on the mean and standard deviation for each measurement.
Only the measurements on the mean and standard deviation are extracted. This includes the signals that have the labels "mean()" or "std()" on their name ("meanFreq()" is not included). All the signals are properly identified by their name in the data set. 

### 3. Uses descriptive activity names to name the activities in the data set
The Activity.ID column is replaced by a column with the name of the activity ("activity_Name"). 

### 4. Appropriately labels the data set with descriptive variable names. 
Performed in the two previous steps. 

### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Since a person and its activities have several rows in the data set, the data is averaged according to the activity and subject id. The tidy data set is saved in file "tidy_data.txt"; each row presents the data averaged for a given person and a given activity. The final data set has 180 rows (30 person each with 6 activities) and 68 columns (2 columns that identify the person and the activity, plus 66 for the different signals/measurements). For more info see CodeBook.md
