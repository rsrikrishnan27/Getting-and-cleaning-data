#Getting and cleaning the data 

This project is a part of Getting and Cleaning the data courserwork. The R script *R-script.R" performs the following. 

* Loads the download activity labels and features datasets into R. 
* Finds the locations of rows that contains mean/std dv in features. 
* Loads training and test datasets keeping only the columns mean or std dv. 
* Loads the activiy and subject data for training and test. Merges them with training and test. 
* Merges training and test
* Converts activtity and subject columns to factors. 
* Creates a tidy dataset using *melt* and *decast*. The tidy dataset contains the average of each variable for each activity and each subject.


Final result = tidy.txt