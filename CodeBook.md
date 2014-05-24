### CodeBook
## The codebook lists in detail the steps performed b script  run_analysis.R along with variables, data & transformations 

The script does following steps:
1.	The data files - folder 'UCI HAR Dataset' should be present in working directory

2.	Read files X_test, X_train.y_test, y_train, Subject_test, Subject_train, features and activity_lables text files into below respective dataframes.
	i.	'features.txt': List of all features. -> features
	ii.	'activity_labels.txt': Links the class labels with their activity name -> act
	iii.	'train/X_train.txt': Training set. -> x_train 
	iv.	'train/y_train.txt': Training labels. -> y_train
	v.	'test/X_test.txt': Test set. -> x_test
	vi.	'test/y_test.txt': Test labels. -> y_test
	vii.	'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. -> subject_train
	viii.	'train/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. -> subject_test

3.	Column bind Dataframes y_test and subject_test and add column names Activity and Subject to it. -> dataframe A (2947 obs. of  2 variables)

4.	Column bind Dataframes y_train and subject_train and add column names Activity and Subject to it. -> dataframe B (7352 obs. of  2 variables)

5.	Merge/Row bind A (test activity and subject) and B(train activity and subject) -> dataframe C  (10299 obs. of  2 variables)

6.	Merge/Row bind test(x_test) and train(x_train) data readings -> dataframe D (10299 obs. of  561 variables)

7.	Change column names of D from features dataframe
8.	Eliminate columns from D which do not have "mean ()" or "std ()" in the column names. i.e create dataframe E which has only columns containing mean and std ->E (10299 obs. of  79 variables)

9.	Column bind C (Activity, subject) and E(mean and std columns) -> F (10299 obs. of  81 variables)

10.	Install package data.table if it’s not already installed

11.	Convert data.frame F into data.table F1 

12.	Take mean of observations in F1 for all columns (except activity and subject) per activity per subject. -> meanF (180 obs. of  81 variables)

13.	Join meanF and act(activity labels dataset) on primary key(Activity) & merge them into -> finalmeanF (180 obs. of  81 variables)

14.	Replace activity numbers with Activity names/labels from activity_lables.txt (act dataframe) in -> finalmeanF

15.	write.table finalmeanF (which is tidy dataset output) in a file called tidydataset.txt in working directory (180 obs. of  81 variables)


