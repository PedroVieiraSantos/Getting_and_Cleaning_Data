library(data.table)
library(dplyr)

remove(list = ls())

# 1. Merges the training and the test sets to create one data set.

tmp1 <- data.table(read.table("UCI HAR Dataset/test/subject_test.txt"))
tmp2 <- data.table(read.table("UCI HAR Dataset/train/subject_train.txt"))
tmp_subject <- rbind(tmp2, tmp1)
setnames(tmp_subject, "V1", "Subject.ID")

tmp1 <- data.table(read.table("UCI HAR Dataset/test/y_test.txt"))
tmp2 <- data.table(read.table("UCI HAR Dataset/train/y_train.txt"))
tmp_activity <- rbind(tmp2, tmp1)
setnames(tmp_activity, "V1", "Activity.ID")

tmp1  <- data.table(read.table("UCI HAR Dataset/test/X_test.txt"))
tmp2 <- data.table(read.table("UCI HAR Dataset/train/X_train.txt"))
DT <- rbind(tmp2, tmp1)

DT <- cbind(tmp_subject, tmp_activity, DT)

remove(tmp1, tmp2, tmp_subject, tmp_activity)


# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#    note includes "*meanFreq*"

DT_features <- data.table(read.table("UCI HAR Dataset/features.txt"))
setnames(DT_features, names(DT_features), c("ID_feature","feature_Name"))

tmp <- grep("-mean\\(\\)|-std\\(\\)", DT_features$feature_Name)
DT_features <- DT_features[tmp,]

DT_features$names_DT <- paste("V", sep="", DT_features$ID_feature)

select_col <- c("Subject.ID","Activity.ID",DT_features$names_DT)
DT <- DT[,select_col,with=FALSE]
setnames(DT, DT_features$names_DT, as.character(DT_features$feature_Name))


# 3. Uses descriptive activity names to name the activities in the data set

DT_activity_lable <- data.table(read.table("UCI HAR Dataset/activity_labels.txt"))
setnames(DT_activity_lable, names(DT_activity_lable), c("ID_Activity", "activity_Name"))

DT$Activity.ID <- DT_activity_lable[DT$Activity.ID,"activity_Name",with=FALSE]
setnames(DT, "Activity.ID", "activity_Name")


# 4. Appropriately labels the data set with descriptive variable names. 
# - already done in step 2,3


# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

DT_tidy <- DT %>% group_by(Subject.ID, activity_Name) %>% summarise_each(funs(mean))

DT_tidy <- DT_tidy %>% ungroup() %>% arrange(Subject.ID, activity_Name) # just to sort table (1st by Subject.ID, 2nd by activity_Name)

write.table(DT_tidy, file = "tidy_data.txt", row.name=FALSE)

