if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip",method="curl")

unzip(zipfile="./data/Dataset.zip",exdir="./data")

prf <- file.path("./data" , "UCI HAR Dataset")
files<-list.files(prf, recursive=TRUE)

## Reading the Activity files
dActTest  <- read.table(file.path(prf, "test" , "Y_test.txt" ),header = FALSE)
dActTrain <- read.table(file.path(prf, "train", "Y_train.txt"),header = FALSE)

## Reading the Features
dFeaTest  <- read.table(file.path(prf, "test" , "X_test.txt" ),header = FALSE)
dFeaTrain <- read.table(file.path(prf, "train", "X_train.txt"),header = FALSE)

## Reding the Subject files
dSubTrain <- read.table(file.path(prf, "train", "subject_train.txt"),header = FALSE)
dSubTest  <- read.table(file.path(prf, "test" , "subject_test.txt"),header = FALSE)