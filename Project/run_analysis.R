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

	if(!file.exists("./UCI HAR Dataset")) { print("'UCI HAR Dataset' directory is missing"); break}

	setwd("./UCI HAR Dataset")
	
#Train data
	SubjectTrain <- fread(file.path(getwd(), "train", "subject_train.txt"))#SubjectID
	YTrain <- fread(file.path(getwd(), "train", "Y_train.txt"))#ActivityID
	XTrain <- data.table(read.table(file.path(getwd(), "train", "X_train.txt"),sep="",header=FALSE))#Measures
		#Merge Train Data
			TrainData <- cbind(cbind(subjectID=SubjectTrain,activityID=YTrain),XTrain)

#Test data
	SubjectTest<- fread(file.path(getwd(), "test", "subject_test.txt")) #SubjectID
	YTest <- fread(file.path(getwd(), "test", "Y_test.txt")) #ActivityID
	XTest <- data.table(read.table(file.path(getwd(), "test", "X_test.txt"),sep="",header=FALSE)) #Measures
		#Merge Test Data
			TestData <- cbind(cbind(subjectID=SubjectTest,activityID=YTest),XTest) 

#Merge Train and Test Data
	Data <- rbind(TrainData,TestData)

# Labelisation of the full DataSet
	labels<- fread(file.path(getwd(),"features.txt"))
	column_names <-c("SubjectID","ActivityID",as.character(labels$V2))
	setnames(Data,column_names)        


#Extracts only the measurements on the mean and standard deviation for each measurement.
	col_select <- column_names[grepl("SubjectID|ActivityID|[Mm]ean\\(\\)|[Ss]td\\(\\)",column_names)]
	Data1  <- subset(Data,select = col_select)

#Uses descriptive activity names to name the activities in the data set
	activities  <- fread(file.path(getwd(),"activity_labels.txt"))
	setnames(activities,c('ActivityID','Activity'))
	setkey(Data1,ActivityID)
	setkey(activities,ActivityID)
	Data2 <- merge(Data1,activities)
	
#Set SubjectId and Activity as factor
	Data2$SubjectID  <- as.factor(Data2$SubjectID)
	Data2$Activity  <- as.factor(Data2$Activity)
	Data2$ActivityID  <- as.factor(Data2$ActivityID)

#Reshaping the DataSet by melting Data
	melted_Data <- melt(Data2,id =c("SubjectID","ActivityID","Activity"))
	
#Creation of a column per variable
	#Variable Domain (either Time or Frequency)
        melted_Data$Domain  <- ifelse(substr(melted_Data$variable,1,1) == 't',"Time",NA)
        melted_Data$Domain  <- as.factor(ifelse(substr(melted_Data$variable,1,1) == 'f',"Frequency",NA))
	#Variable Component (either Body or Gravity)
        melted_Data$Component  <- ifelse(grepl('*[Bb]ody*',melted_Data$variable),"Body"," ")
        melted_Data$Component  <- as.factor(ifelse(grepl('*[Gg]ravity*',melted_Data$variable),"Gravity",melted_Data$Component))
	#Variable Instrument (either Accelerometer or Gyroscope)
        melted_Data$Instrument  <- ifelse(grepl('*[Aa]cc*',melted_Data$variable),"Accelerometer"," ")
        melted_Data$Instrument  <- as.factor(ifelse(grepl('*[Gg]yro*',melted_Data$variable),"Gyroscope",melted_Data$Instrument))
	#Variable Jerk (logical)
        melted_Data$Jerk  <- as.logical(ifelse(grepl('*[Jj]erk*',melted_Data$variable),"TRUE","FALSE"))
	#Variable Measure (either Mean value or Standard Deviation)
        melted_Data$Measure  <- ifelse(grepl('*[Mm]ean*',melted_Data$variable),"Mean Value"," ")
        melted_Data$Measure  <- as.factor(ifelse(grepl('*[Ss]td*',melted_Data$variable),"Standard Deviation",melted_Data$Measure))
	#Variable Magnitude (Logical)
        melted_Data$Magnitude  <- as.logical(ifelse(grepl('*[Mm]ag*',melted_Data$variable),"TRUE","FALSE"))
	#Variable Axis (either X,Y,Z or NA)
        melted_Data$Axis  <- ifelse(grepl('*X$*',melted_Data$variable),"X",NA)
        melted_Data$Axis  <- ifelse(grepl('*Y$*',melted_Data$variable),"Y",melted_Data$Axis)
        melted_Data$Axis  <- as.factor(ifelse(grepl('*Z$*',melted_Data$variable),"Z",melted_Data$Axis))
	#Remove the column named variable and ActivityID
        melted_Data$variable  <- NULL
        melted_Data$ActivityID  <- NULL

	
# Aggregation of the DATA DataSet by calculating the Average by key
	setkey(melted_Data,SubjectID,Activity,Domain,Component,Instrument,Jerk,Magnitude,Axis,Measure)
	tidy_data  <- melted_Data[,lapply(.SD,mean),by=key(melted_Data)]
	
# Extration of the tidy_data in tidy_UCIHARDataset.txt file.
write.csv(tidy_data, file = '../tidy_UCIHARDataset.txt',row.names = FALSE, quote = FALSE)
}
