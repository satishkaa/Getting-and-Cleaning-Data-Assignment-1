CodeBook
========================================================

Summary
-------

The input provided contains two data sets

 - Test Data
 - Train Data
 
Each data set is an observation of a human activity measurement. The activities involved are 
 
 - Walking
 - Walking Upstairs
 - Walking Downstairs
 - Sitting
 - Standing
 - Laying
 
The observations are measured for 30 subjects.
 
 Each observation has 561 attributes. These attributes are different level of aggregations for the following signals.
 
 - tBodyAcc-XYZ
 - tGravityAcc-XYZ
 - tBodyAccJerk-XYZ
 - tBodyGyro-XYZ
 - tBodyGyroJerk-XYZ
 - tBodyAccMag
 - tGravityAccMag
 - tBodyAccJerkMag
 - tBodyGyroMag
 - tBodyGyroJerkMag
 - fBodyAcc-XYZ
 - fBodyAccJerk-XYZ
 - fBodyGyro-XYZ
 - fBodyAccMag
 - fBodyAccJerkMag
 - fBodyGyroMag
 - fBodyGyroJerkMag
 
*Note : xyz indicates measures for x, y and z axis
 
As part of the assignment we present a tidy data set for each observation. The tidy data set contains the following attributes
 
 - Subject : Id of the participant
 - Activity ID : ID of the acitivty measured
 - Activity Name : Name of the activity
 - Mean of above mentioned 33 signals
 - Standard Deviation of above mentioned 33 signals
 
Dimensions of the tidy data set are 10299 rows and 69 columns
 
We also present mean values of the 66 measurements (33 x 2) aggregated at the level of Subject and Activity.
 
The Dimensions of aggregated data set are 180 rows (30 x 6) and 69 columns
 
 
 
Working
-------
 
 - List of 561 attributes are extracted from features.txt file
 - List of 6 activities are extracted from activity_labels.txt file
 - List of relevant attributes (66) are pulled from the 561 list by pikcing only mean or standard deviation measures
 - We read the train data into data frame only for these 66 attributes
 - We appended the subject id and activity id at the begining to the train data set using files subject_train.txt and y_train.txt
 - Similar process is followed for test data also.
 - We clubbed both the data sets
 - Activity name is added to the list by doing lookup on activity list data frame
 - We ordered the rows on basis of subject and activity
 - Final tidy data set is saved in tidydata data frame
 - Aggregation of 66 measurements for each combination of subject and activity is obtained by using aggregate function.
 - Activity name is added to the aggregated output and rows are ordered on basis of subject and activity.
 
 
