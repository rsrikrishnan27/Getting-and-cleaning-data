
#UCI HAR Dataset has been downloaded and placed in the working directory


#Reading activity labels
activity_labels = read.table("./UCI HAR Dataset/activity_labels.txt")
activity_labels[,2] = as.character(activity_labels[,2])

#Reading features
features = read.table("./UCI HAR Dataset/features.txt")
features[,2] = as.character(features[,2])

#Extracting the locations/indexes where mean or std is present
feature_req <- grep(".*mean.*|.*std.*", features[ ,2])
feature_req_names<- features[feature_req,2]

#Removing junks
feature_req_names = gsub('-mean', 'Mean', feature_req_names)
feature_req_names = gsub('-std', 'Std', feature_req_names)
feature_req_names <- gsub('[-()]', '', feature_req_names)

#Importing Train data
train <- read.table("./UCI HAR Dataset/train/X_train.txt")[feature_req]
train_Activities <- read.table("./UCI HAR Dataset/train/Y_train.txt")
train_Subjects <- read.table("./UCI HAR Dataset/train/subject_train.txt")
train <- cbind(train_Subjects, train_Activities, train)

#Importing Test data
test <- read.table("./UCI HAR Dataset/test/X_test.txt")[feature_req]
test_Activities <- read.table("./UCI HAR Dataset/test/Y_test.txt")
test_Subjects <- read.table("./UCI HAR Dataset/test/subject_test.txt")
test <- cbind(test_Subjects, test_Activities, test)

#Merging datasets train and test
all_Data <- rbind(train, test)
colnames(all_Data) <- c("subject", "activity", feature_req_names)

#Naming the activities
all_Data$activity <- factor(all_Data$activity, levels = activity_labels[,1], labels = activity_labels[,2])
all_Data$subject <- as.factor(all_Data$subject)

#Creating independent tidy data set with the average of each variable for each activity and each subject.
library(reshape2) 
#melt and decast functions are available in "reshape2" package
all_Data.melted <- melt(all_Data, id = c("subject", "activity"))
all_Data.mean <- dcast(all_Data.melted, subject + activity ~ variable, mean)

write.table(all_Data.mean,"./tidy.txt", row.names = FALSE, quote = FALSE)


