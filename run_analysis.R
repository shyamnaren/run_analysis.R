
#Load Train & Training text
train.x<-read.table("./run_data/UCI HAR run_dataset/train/X_train.txt")
test.x<-read.table("./run_data/UCI HAR run_dataset/test/X_test.txt")

train.y<-read.table("./run_data/UCI HAR run_dataset/train/y_train.txt")
test.y<-read.table("./run_data/UCI HAR run_dataset/test/y_test.txt")

Subject_train<-read.table("./run_data/UCI HAR run_dataset/train/subject_train.txt")
Subject_test<-read.table("./run_data/UCI HAR run_dataset/test/subject_test.txt")

#Load activity labels & Features
activity_labels<-read.table("./run_data/UCI HAR run_dataset/activity_labels.txt")
features<-read.table("./run_data/UCI HAR run_dataset/features.txt")

#Merge training and the test sets
all.x<-rbind(train.x,test.x)

#Extracts measurements on the mean and standard deviation for each measurement.
colnames(all.x) <- c(as.character(features[,2]))
Mean<-grep("mean()",colnames(all.x),fixed=TRUE)
StDev<-grep("std()",colnames(all.x),fixed=TRUE)

MeanStDev<-all.x[,c(Mean,StDev)]

all.y<-rbind(train.y,test.y)
all.activity<-cbind(all.y,MeanStDev)

colnames(all.activity)[1] <- "Activity"

#labels run_data set with descriptive activity names
activity_labels[,2]<-as.character(activity_labels[,2])

for(i in 1:length(all.activity[,1])){
  all.activity[i,1]<-activity_labels[all.activity[i,1],2]
}

#Creates a second, independent tidy run_data set with the average of each variable for each activity and each subject.

Subject_all<-rbind(Subject_train,Subject_test)

all<-cbind(Subject_all,all.activity)

colnames(all)[1] <- "Subject"

Tidy <- aggregate( all[,3] ~ Subject+Activity, run_data = all, FUN= "mean" )

for(i in 4:ncol(all)){
  Tidy[,i] <- aggregate( all[,i] ~ Subject+Activity, run_data = all, FUN= "mean" )[,3]
}

colnames(Tidy)[3:ncol(Tidy)] <- colnames(MeanStDev)

write.table(Tidy, file = "tidyrun_data.txt")