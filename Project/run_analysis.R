library("data.table")

# GET THE DATA
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipfile <- "UCIHARDataset.zip"

if(!file.exists("./Project")) {dir.create("Project")}
download.file(url, destfile = file.path("Project", zipfile),method="curl")
setwd("./Project")

unzip(zipfile)
setwd("./UCI HAR Dataset") #Set the final working Directory
# use list.files(getwd(), recursive = TRUE), to check ALL the files in WD.


#WORKING THE DATA
# 1- Merges the training and the test sets to create one data set.
#Train data
SubjectTrain <- fread(file.path(getwd(), "train", "subject_train.txt"))
YTrain <- fread(file.path(getwd(), "train", "Y_train.txt"))
XTrain <- data.table(read.table(file.path(getwd(), "train", "X_train.txt"),sep="",header=FALSE))
#Merge Train Data
TrainData <- cbind(subjectID=SubjectTrain,activityID=YTrain) #Add column with subjectID and ActivityID
TrainData <- cbind(TrainData,XTrain) #Add subject and activity to the recorded info

#Test data
SubjectTest<- fread(file.path(getwd(), "test", "subject_test.txt"))
YTest <- fread(file.path(getwd(), "test", "Y_test.txt"))
XTest <- data.table(read.table(file.path(getwd(), "test", "X_test.txt"),sep="",header=FALSE))
#Merge Test Data
TestData <- cbind(subjectID=SubjectTest,activityID=YTest) #Add column with subjectID and ActivityID
TestData <- cbind(TestData,XTest) #Add subject and activity to the recorded info

#ACTUAL MERGE OF ALL THE DATAu
AllData <- rbind(TrainData,TestData)

# LABELISATION OF THE FULL DATASET
#Appropriately labels the data set with descriptive variable names. 
#Labels
labels<- fread(file.path(getwd(),"features.txt"))
column_names <-c("SubjectID","ActivityID",as.character(labels$V2))
setnames(AllData,column_names)        

#Extracts only the measurements on the mean and standard deviation for each measurement. 
col_select  <- column_names[grepl("SubjectID|ActivityID|mean\\(\\)|std\\(\\)",column_names)]
mean_std_data  <- subset(AllData,select = col_select)


#Uses descriptive activity names to name the activities in the data set
activities  <- fread(file.path(getwd(),"activity_labels.txt"))
setnames(activities,c('ActivityID','Activity'))
setkey(mean_std_data,ActivityID)
setkey(activities,ActivityID)
Data1  <- merge(mean_std_data,activities)
setkey(Data1,SubjectID,Activity)


#From the data set in step 4, creates a second, independent tidy data set with 
#the average of each variable for each activity and each subject.
tidy_data  <- Data1[,lapply(.SD,mean),by=key(Data1)]

#correct the variable names
names <- names(tidy_data)
names <- gsub('-mean', 'Mean', names) # Replace `-mean' by `Mean'
names <- gsub('-std', 'Std', names) # Replace `-std' by 'Std'
names <- gsub('[()-]', '', names) # Remove the parenthesis and dashes
names <- gsub('BodyBody', 'Body', names) # Replace `BodyBody' by `Body'
setnames(tidy_data, names)
