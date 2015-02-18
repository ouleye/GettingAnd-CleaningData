library("data.table")
library("reshape2")

# GET THE DATA
#download_unzip_data  <- function() {
      #  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
       # zipfile <- "UCIHARDataset.zip"

        #if(!file.exists("./Project")) {dir.create("Project")}
        #download.file(url, destfile = file.path("Project", zipfile),method="curl")

        #setwd("./Project")
        #unzip(zipfile)
 #                               }
#
#WORKING THE DATA
# 1- Merges the training and the test sets to create one data set.
#Train data
#generate_tidy_data <- function() {
if(!file.exists("./UCI HAR Dataset")) { print("manque repertoire UCI HAR Dataset") 
break}
setwd("./UCI HAR Dataset")
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
col_select  <- column_names[grepl("SubjectID|ActivityID|[Mm]ean\\(\\)|std\\(\\)",column_names)]
mean_std_data  <- subset(AllData,select = col_select)


#Uses descriptive activity names to name the activities in the data set
activities  <- fread(file.path(getwd(),"activity_labels.txt"))
setnames(activities,c('ActivityID','Activity'))
setkey(mean_std_data,ActivityID)
setkey(activities,ActivityID)
Data1  <- merge(mean_std_data,activities)
setkey(Data1,SubjectID,ActivityID,Activity)


Data3 <- melt(Data1,id =c("SubjectID","ActivityID","Activity"))

Data3$Domain  <- as.factor(ifelse(substr(Data3$variable,1,1) == 't',"Time","Frequency"))
Data3$Component  <- ifelse(grepl('*[Bb]ody*',Data3$variable),"Body"," ")
Data3$Component  <- as.factor(ifelse(grepl('*[Gg]ravity*',Data3$variable),"Gravity",Data3$Component))
Data3$Instrument  <- ifelse(grepl('*[Aa]cc*',Data3$variable),"Accelerator"," ")
Data3$Instrument  <- as.factor(ifelse(grepl('*[Gg]yro*',Data3$variable),"Gyroscope",Data3$Instrument))
Data3$Jerk  <- as.logical(ifelse(grepl('*[Jj]erk*',Data3$variable),"TRUE","FALSE"))
Data3$Measure  <- ifelse(grepl('*[Mm]ean*',Data3$variable),"Mean"," ")
Data3$Measure  <- as.factor(ifelse(grepl('*[Ss]td*',Data3$variable),"Std",Data3$Measure))
Data3$Magnitude  <- as.logical(ifelse(grepl('*[Ma]g*',Data3$variable),"TRUE","FALSE"))
Data3$Axis  <- ifelse(grepl('*X$*',Data3$variable),"X",NA)
Data3$Axis  <- ifelse(grepl('*Y$*',Data3$variable),"Y",Data3$Axis)
Data3$Axis  <- as.factor(ifelse(grepl('*Z$*',Data3$variable),"Z",Data3$Axis))
Data3$variable  <- NULL

Data3$SubjectID  <- as.factor(Data3$SubjectID)
Data3$ActivityID  <- NULL
Data3$Activity  <- as.factor(Data3$Activity)
        

setkey(Data3,SubjectID,Activity,Domain,Component,Instrument,Jerk,Magnitude,Axis,Measure)
tidy_data  <- Data3[,lapply(.SD,mean),by=key(Data3)]
write.csv(tidy_data, file = '../tidydata.txt',row.names = FALSE, quote = FALSE)
#}
