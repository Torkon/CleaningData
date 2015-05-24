run_analysis <- function(){
        
        ## Loading required libraries
        library(dplyr);library(plyr)
        
        ## Checks if the UCI HAR Dataset directory is in the working directory
        if(!file.exists("./UCI HAR Dataset")) {stop("Provide the UCI HAR Dataset directory in working directory!")}
        
        ## Loading files into data table
        activitylabels<-read.table("./UCI HAR Dataset/activity_labels.txt",stringsAsFactors = FALSE)
        features<-read.table("./UCI HAR Dataset/features.txt",stringsAsFactors =FALSE)			
        subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")
        subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")
        x_test<-read.table("./UCI HAR Dataset/test/x_test.txt")
        y_test<-read.table("./UCI HAR Dataset/test/y_test.txt")
        x_train<-read.table("./UCI HAR Dataset/train/x_train.txt")
        y_train<-read.table("./UCI HAR Dataset/train/y_train.txt")
        
        ## 1) Merges the training and the test sets to create one data set.
        combinedtesttrainset<-rbind(x_test,x_train)
        combinedy <- rbind(y_test,y_train)
        combinedsubjectid <- rbind(subject_test,subject_train)
        names(combinedsubjectid) <- "Subject_ID"
        
        ## 4) Appropriately labels the data set with descriptive variable names. 
        features$V3 <- make.names(features$V2)
        colnames(combinedtesttrainset) <- features$V3
        
        ## Adds Activity and Subject_ID to combined data file 
        combinedtesttrainset <- cbind(combinedy,combinedtesttrainset)
        combinedtesttrainset <- cbind(combinedsubjectid,combinedtesttrainset)
        
        ## 3) Uses descriptive activity names to name the activities in the data set
        combinedtesttrainset<-merge(activitylabels,combinedtesttrainset,by="V1")
        combinedtesttrainset<-select(combinedtesttrainset, -V1)
        combinedtesttrainset<-rename(combinedtesttrainset,c("V2"="Activity"))
        
        ## 2) Extracts only the measurements on the mean and standard deviation for each measurement. 
        columnnames<-select(features,-(1:2))
        columnnames<-filter(columnnames, grepl('Mean|mean|MEAN|std|STD|Std', V3))
        columnnames<-rbind("Activity","Subject_ID",columnnames)
        combinedtesttrainset<-combinedtesttrainset[,colnames(combinedtesttrainset)%in%columnnames$V3]
        
        ## 5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
        tidyfinaldataset <- group_by(combinedtesttrainset, Subject_ID, Activity) %>% summarise_each(funs(mean))
        
        ## Writes table to working directory
        write.table(tidyfinaldataset,file = "./tidyfinaldataset.txt",row.name=FALSE)
}