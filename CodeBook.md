# --------------
# CodeBook.md
# --------------

Data Source: [1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

Process:
The purpose of this exercise is to generate a tidy data set from [1] as per requested by the Coursera Fetting and Cleaning Data Course project. The final product should be a tidy data set ready for analysis.

The only script, run_analysis.R, consist of 5 distinct steps:
1. Data from the source is provided in distinct files (X, Y and subject) from two different sets (train and test). The first step merges all these data into one single data frame. All temporary data frames are then removed to save ressources.

2. Only the Mean and Standard Deviation variables are required for this exercise. The full list of variable (features) is read from source file and the index of the requested fields are saved i order to filter only the rerquested variabled from our data frame

3. During step 3. for the sake of simplicity and clarity, all variable names are formated and data frame updated accordingly

4. During step 4. for the sake of simplicity and clarity, the data frame activity variable is casted to a factor vector, including labels as per the activity_labels.txt file

5. At last we summarise (average) all variable by subject (30) and by activity (6), into a new data set (180 observations). The data set is exported to 'means.txt' included in this repo

Source files:
UCI HAR Dataset/train/X_train.txt, UCI HAR Dataset/train/subject_train.txt, UCI HAR Dataset/train/y_train.txt, UCI HAR Dataset/test/X_test.txt , UCI HAR Dataset/test/subject_test.txt, UCI HAR Dataset/test/y_test.txt, UCI HAR Dataset/features.txt, UCI HAR Dataset/activity_labels.txt

Variable and data:
<train|test>traindata, <train|test>subject, <train|test>activity are temprary data frames used to read data from files in order to generated the merged 'data' data frame

'mean_std', storing the index of the mean and stadard deviation variables, is generated from the full list of 'features' read from file. It is used to filtered the variables requested from the 'data' data frame and to retrieve the corresponding variable names, stored in 'var_names'

'var_names' is processed to reformat the variable names and update our 'data' column names accordingly

dlpyr is used to summarise the data set grouped by subject and activity, stored in 'summary', exported to 'means.txt' included in the repo
 	
