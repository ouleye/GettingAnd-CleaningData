FOR REVIEWER INFORMATION,


# GET THE DATA
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipfile <- "UCIHARDataset.zip"

if(!file.exists("./Project")) {dir.create("Project")}
download.file(url, file.path("Project", zipfile))
setwd("./Project")

unzip(zipfile)
setwd("./UCI HAR Dataset") #Set the final working Directory
                           # use list.files(getwd(), recursive = TRUE), to check ALL the files in WD.
      

#WORKING THE DATA
# 1- Merges the training and the test sets to create one data set.
#Train data
SubjectTrain <- read.table(file.path(getwd(), "train", "subject_train.txt"),header=FALSE)
YTrain <- read.table(file.path(getwd(), "train", "Y_train.txt"),header=FALSE)
XTrain <- read.table(file.path(getwd(), "train", "X_train.txt"),sep="",header=FALSE)
        #Merge Train Data
        TrainData <- cbind(subject=SubjectTrain,activty=YTrain) #Add column with subjectID and ActivityID
        TrainData <- cbind(TrainData,XTrain) #Add subject and activity to the recorded info

#Test data
SubjectTest<- read.table(file.path(getwd(), "test", "subject_test.txt"),header=FALSE)
YTest <- read.table(file.path(getwd(), "test", "Y_test.txt"),header=FALSE)
XTest <- read.table(file.path(getwd(), "test", "X_test.txt"),sep="",header=FALSE)
        #Merge Test Data
        TestData <- cbind(SubjectTest,YTest) #Add column with subjectID and ActivityID
        TestData <- cbind(TestData,XTest) #Add subject and activity to the recorded info

#ACTUAL MERGE OF ALL THE DATA
AllData <- rbind(TrainData,TestData)

# LABELISATION OF THE FULL DATASET
#Appropriately labels the data set with descriptive variable names. 
        #Labels
        labels<- read.table(file.path(getwd(),"features.txt"),sep="",header=FALSE)
        column_names <-c("SubjectID","ActivityID",as.character(labels$V2))
colnames(AllData) <- column_names        

#Extracts only the measurements on the mean and standard deviation for each measurement. 

#Uses descriptive activity names to name the activities in the data set



#From the data set in step 4, creates a second, independent tidy data set with the average of 
#each variable for each activity and each subject.
