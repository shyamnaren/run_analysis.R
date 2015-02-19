
#Load Train & Training text
train.x<-read.table("./data/UCI HAR Dataset/train/X_train.txt")
test.x<-read.table("./data/UCI HAR Dataset/test/X_test.txt")

train.y<-read.table("./data/UCI HAR Dataset/train/y_train.txt")
test.y<-read.table("./data/UCI HAR Dataset/test/y_test.txt")

Subject_train<-read.table("./data/UCI HAR Dataset/train/subject_train.txt")
Subject_test<-read.table("./data/UCI HAR Dataset/test/subject_test.txt")

#Load activity lables & Features
activity_labels<-read.table("./data/UCI HAR Dataset/activity_labels.txt")
features<-read.table("./data/UCI HAR Dataset/features.txt")

#Merge training and the test sets
all.x<-rbind(train.x,test.x)

#Extracts measurements on the mean and standard deviation for each measurement.
colnames(all.x) <- c(as.character(features[,2]))

Mean<-grep("mean()",colnames(all.x),fixed=TRUE)

SD<-grep("std()",colnames(all.x),fixed=TRUE)

MeanSD<-all.x[,c(Mean,SD)]


all.y<-rbind(train.y,test.y)

all.activity<-cbind(all.y,MeanSD)

colnames(all.activity)[1] <- "Activity"

#labels data set with descriptive activity names
activity_labels[,2]<-as.character(activity_labels[,2])

for(i in 1:length(all.activity[,1])){
  all.activity[i,1]<-activity_labels[all.activity[i,1],2]
}

#Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Subject_all<-rbind(Subject_train,Subject_test)

all<-cbind(Subject_all,all.activity)

colnames(all)[1] <- "Subject"

Tidy <- aggregate( all[,3] ~ Subject+Activity, data = all, FUN= "mean" )

for(i in 4:ncol(all)){
  Tidy[,i] <- aggregate( all[,i] ~ Subject+Activity, data = all, FUN= "mean" )[,3]
}

colnames(Tidy)[3:ncol(Tidy)] <- colnames(MeanSD)

write.table(Tidy, file = "FinalData.txt")