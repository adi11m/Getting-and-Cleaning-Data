## Concatenate the data tables row-wise
dSub <- rbind(dSubTrain, dSubTest)
dAct<- rbind(dActTrain, dActTest)
dFea<- rbind(dFeaTrain, dFeaTest)

## Set names to variables
names(dSub)<-c("subject")
names(dAct)<- c("activity")
dFeaNames <- read.table(file.path(prf, "features.txt"),head=FALSE)
names(dFea)<- dFeaNames$V2

## Merge columns to get the data frame Data for all data
dCom <- cbind(dSub, dAct)
Data <- cbind(dFea, dCom)

## Subset Name of Features by measurements on the mean and standard deviation
subdFeaNames<-dFeaNames$V2[grep("mean\\(\\)|std\\(\\)", dFeaNames$V2)]

## Subset the data frame Data by selected names of Features
selectedNames<-c(as.character(subdFeaNames), "subject", "activity" )
Data<-subset(Data,select=selectedNames)

## Read descriptive activity names from “activity_labels.txt”
activityLabels <- read.table(file.path(prf, "activity_labels.txt"),header = FALSE)

names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))

library(plyr);
Data2<-aggregate(. ~subject + activity, Data, mean)
Data2<-Data2[order(Data2$subject,Data2$activity),]
write.table(Data2, file = "tidydata.txt",row.name=FALSE)
