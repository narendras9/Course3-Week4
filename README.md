# Course3Assignment
The code cleans data and summarizes it

The two main sections of the code.
1. The first part combines the data sets to create a clean and tidy dataset
2. The second part summarizes the data as required by the assignment

##First Part: Clean,Label and Combine the data from the different text files
The headers for the test and training data is read from the features.txt file.
The respective observation and the subject file are then added to the test and training data.
Finally the training and test data are merged together to arrive at the final dataset
The next step is to select the mean and std columns from the dataset along with the observation and subjects.
The observations are then replaced with activity names to create the final dataset.

##Second Part: Summarize the data above
The dataset is first grouped by the subject and activity name
This is followed by creating a summary consisting of the average of the variables of the dataset.




