
train.X<-read.table("D:/Program Files/RStudio/UCI HAR Dataset/train/X_train.txt")
test.X<-read.table("D:/Program Files/RStudio/UCI HAR Dataset/test/X_test.txt")

train.y<-read.table("D:/Program Files/RStudio/UCI HAR Dataset/train/y_train.txt")
test.y<-read.table("D:/Program Files/RStudio/UCI HAR Dataset/test/y_test.txt")

subject_train<-read.table("D:/Program Files/RStudio/UCI HAR Dataset/train/subject_train.txt")
subject_test<-read.table("D:/Program Files/RStudio/UCI HAR Dataset/test/subject_test.txt")

activity_labels<-read.table("D:/Program Files/RStudio/UCI HAR Dataset/activity_labels.txt")
features<-read.table("D:/Program Files/RStudio/UCI HAR Dataset/features.txt")

#Merges the training and the test sets to create one data set.

x_total<-rbind(train.X,test.X)
y_total<-rbind(train.y,test.y)
subject_total<-rbind(subject_train,subject_test)

#Extracts only the measurements on the mean and standard deviation for each measurement.
selected_var <- variable.names[grep("mean\\(\\)|std\\(\\)",variable.names[,2]),]
x_total <- x_total[,selected_var[,1]]

#Uses descriptive activity names to name the activities in the data set.
colnames(y_total)="activity"
y_total$activitylabel<-factor(y_total$activity,labels = as.character(activity_labels[,2]))
activitylabel<-y_total[,-1]

#Appropriately labels the data set with descriptive variable names.

colnames(x_total)<-variable.names[selected_var[,1],2]

#From the data set in step 4, creates a second, independent tidy data set with the average of 
#each variable for each activity and each subject.


colnames(subject_total)<-"subject"
total<-cbind(x_total,activitylabel,subject_total)
totalmean<-total %>% group_by(activitylabel,subject) %>% summarise_each(funs(mean))

write.table(totalmean,file ="D:/Program Files/RStudio/UCI HAR Dataset/tidydataset.txt",row.names = F,col.names = T)




