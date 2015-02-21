Input Data
The R script assumes that the UCI dataset is extracted into ./run_data/

Output Data
The resulting ./data/tidydata.txt dataset includes mean and std deviation variables for the following variables - tBodyAcc, tGravityAcc, tBodyAccJerk, tBodyGyro, tBodyGyroJerk, tBodyAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag, fBodyAcc, fBodyAccJerk, fBodyGyro, fBodyAccMag, fBodyBodyAccJerkMag, fBodyBodyGyroMag, fBodyBodyGyroJerkMag. 

Transformations
The script, 'run_analysis.R', does the following

-Loads the various files which constitute the UCI dataset
-Merges the test and train files into a single table
-Creates a smaller second dataset, containing only mean and std variables
-Computes the means of this secondary dataset, group by subject/activity.

The output of this last dataset is saved to "./data/tidydata.txt"