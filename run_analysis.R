library(dplyr)
library(data.table)

# Get Column Headers
headers_file<-read.table("features.txt",sep=" ")
headerNames<-headers_file$V2

#Load and Merge Test Files
X_test_File<-read.table("test/X_test.txt")
y_test_File<-read.table("test/y_test.txt")
subject_test_File<-read.table("test/subject_test.txt")
X_test_File$Obs<-y_test_File$V1
X_test_File$subject<-subject_test_File$V1

#Load Training Files and Create a Table from it
X_train_File<-read.table("train/X_train.txt")
y_train_File<-read.table("train/y_train.txt")
subject_train_File<-read.table("train/subject_train.txt")
X_train_File$Obs<-y_train_File$V1
X_train_File$subject<-subject_train_File$V1

#Append one table to the other to create the complete dataset
total_dataset<-rbind(X_test_File,X_train_File)

#Get Column numbers for the Std and Mean
colnumbers<-grep(paste(c("std","mean"),collapse="|"),headerNames)

#Clean header columns for Total Dataset
newheaderNames<-headerNames[colnumbers]
cleanheaderNames<-gsub("-","_",newheaderNames)
cleanheaderNames<-gsub("[()]","",newheaderNames)

#Select mean and std from the dataset to create new dataset
new_data_set<-select(total_dataset,colnumbers)

#append obs and subject number to the dataset from total_dataset
colnames(new_data_set)<-cleanheaderNames
new_data_set$Obs<-total_dataset$Obs
new_data_set$subject<-total_dataset$subject

new_data_set1<-tbl_df(new_data_set)

#Read activity labels file for renaming obs with activity names
activity_name<-read.table("activity_labels.txt")

#Lookup Obs and join with Activity Names
new_data_set1<-tbl_df(new_data_set)
new_data_set2<-inner_join(new_data_set1,activity_name,by=c("Obs"="V1"))

#Remove obs column and replace with activity_name
new_data_set3<-select(new_data_set2,-Obs)
new_data_set<-setnames(new_data_set3,"V2","activity_name")

#Clean dataset created
final_data_set<-tbl_df(new_data_set)

#Summarize the above dataset by grouping subject and activity name 
#and finding mean of the remaining variables

summarized_data_set<-final_data_set %>%
  group_by(subject,activity_name) %>%
  summarise_each(funs(mean))

#Write the above summarized dataset back to a text file
write.table(summarized_data_set,"summary_data_set.txt", row.names = FALSE)