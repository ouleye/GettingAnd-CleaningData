# GET THE DATA
download_unzip_data  <- function() {
        url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        zipfile <- "UCIHARDataset.zip"

        if(!file.exists("./Project")) {dir.create("Project")}
        download.file(url, destfile = file.path("Project", zipfile),method="curl")

        setwd("./Project")
        unzip(zipfile)
                               }

#PREPARE TIDY DATA
generate_tidy_data <- function() {
#Load the required package
library("data.table")
library("reshape2")

	if(!file.exists("./UCI HAR Dataset")) { print("'UCI HAR Dataset' directory is missing") break}

	setwd("./UCI HAR Dataset")
	
#Train data
	SubjectTrain <- fread(file.path(getwd(), "train", "subject_train.txt"))#SubjectID
	YTrain <- fread(file.path(getwd(), "train", "Y_train.txt"))#ActivityID
	XTrain <- data.table(read.table(file.path(getwd(), "train", "X_train.txt"),sep="",header=FALSE))#Measures
		#Merge Train Data
			TrainData <- cbind(subjectID=SubjectTrain,activityID=YTrain) 
			TrainData <- cbind(TrainData,XTrain) 

#Test data
	SubjectTest<- fread(file.path(getwd(), "test", "subject_test.txt")) #SubjectID
	YTest <- fread(file.path(getwd(), "test", "Y_test.txt")) #ActivityID
	XTest <- data.table(read.table(file.path(getwd(), "test", "X_test.txt"),sep="",header=FALSE)) #Measures
		#Merge Test Data
			TestData <- cbind(subjectID=SubjectTest,activityID=YTest) 
			TestData <- cbind(TestData,XTest) 

#Merge Train and Test Data
	Data <- rbind(TrainData,TestData)

# Labelisation of the full DataSet
	labels<- fread(file.path(getwd(),"features.txt"))
	column_names <-c("SubjectID","ActivityID",as.character(labels$V2))
	setnames(Data,column_names)        

#Extracts only the measurements on the mean and standard deviation for each measurement. 
	Data  <- subset(Data,select = col_select)


#Uses descriptive activity names to name the activities in the data set
	activities  <- fread(file.path(getwd(),"activity_labels.txt"))
	setnames(activities,c('ActivityID','Activity'))
	setkey(Data,ActivityID)
	setkey(activities,ActivityID)
	Data <- merge(Data,activities)
#Set subjectId and Activity as factor - Remove the ActivityId column
	Data$SubjectID  <- as.factor(Data$SubjectID)
	Data$ActivityID  <- NULL
	Data$Activity  <- as.factor(Data$Activity)

#Reshaping the DataSet by melting Data
	Data <- melt(Data1,id =c("SubjectID","ActivityID","Activity"))
	
#Creation of a column per variable
	#Variable Domain (either Time or Frequency)
		Data$Domain  <- as.factor(ifelse(substr(Data$variable,1,1) == 't',"Time","Frequency"))
	#Variable Component (either Body or Gravity)
		Data$Component  <- ifelse(grepl('*[Bb]ody*',Data$variable),"Body"," ")
		Data$Component  <- as.factor(ifelse(grepl('*[Gg]ravity*',Data$variable),"Gravity",Data$Component))
	#Variable Instrument (either Accelerometer or Gyroscope)
		Data$Instrument  <- ifelse(grepl('*[Aa]cc*',Data$variable),"Accelerometer"," ")
		Data$Instrument  <- as.factor(ifelse(grepl('*[Gg]yro*',Data$variable),"Gyroscope",Data$Instrument))
	#Variable Jerk (logical)
		Data$Jerk  <- as.logical(ifelse(grepl('*[Jj]erk*',Data$variable),"TRUE","FALSE"))
	#Variable Measure (either Mean value or Standard Deviation)
		Data$Measure  <- ifelse(grepl('*[Mm]ean*',Data$variable),"Mean Value"," ")
		Data$Measure  <- as.factor(ifelse(grepl('*[Ss]td*',Data$variable),"Standard Deviation",Data$Measure))
	#Variable Magnitude (Logical)
		Data$Magnitude  <- as.logical(ifelse(grepl('*[Ma]g*',Data$variable),"TRUE","FALSE"))
	#Variable Axis (either X,Y,Z or NA)
		Data$Axis  <- ifelse(grepl('*X$*',Data$variable),"X",NA)
		Data$Axis  <- ifelse(grepl('*Y$*',Data$variable),"Y",Data$Axis)
		Data$Axis  <- as.factor(ifelse(grepl('*Z$*',Data$variable),"Z",Data$Axis))
	#Remove the column named variable
		Data$variable  <- NULL

	
# Aggregation of the DATA DataSet by calculating the mean by key
	setkey(Data,SubjectID,Activity,Domain,Component,Instrument,Jerk,Magnitude,Axis,Measure)
	tidy_data  <- Data[,lapply(.SD,mean),by=key(Data)]
	
# Extration of the tidy_data in tidy_data.txt file.
write.csv(tidy_data, file = '../tidy_data.txt',row.names = FALSE, quote = FALSE)
}
