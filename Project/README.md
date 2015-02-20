Getting and Cleaning Data Project
=====================================
by Ouleyematou GUEYE


Introduction
--------------------------

> The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  
> 
> One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 
> 
> http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
> 
> Here are the data for the project: 
> 
> https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
> 
> You should create one R script called run_analysis.R that does the following. 
> 
> 1. Merges the training and the test sets to create one data set.
> 2. Extracts only the measurements on the mean and standard deviation for each measurement.
> 3. Uses descriptive activity names to name the activities in the data set.
> 4. Appropriately labels the data set with descriptive activity names.
> 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

What is inside the run_analysis.r script
-------------------------------

There are two functions in this script

1. **download_unzip_data** 
       * Create a *Project* Directory to store the dataset
       * Download the UCI HAR Dataset from the web
       * Unzip the file containing the dataset

2. **generate_tidy_data**
       * Load the needed Packages : *data.table* and *reshape2*
       * Check if the *UCI HAR Dataset* exists, if not the process is stopped
       * All the train data are collected and merged
       * All the Test data are collected and merged
       * The Train and Test data are merged in a data frame 
       * The colunmn names of the data frame are set thanks to the features info provided
       * The mean and standard deviation value are subsetted
       * Activity names are added
       * The dataset is melted in order to obtain the info by subjectId and Activity name
       * The Feature info is broken in order to obtain on column per variable (see thevariable breaking process in the `codebook.md`)
       *  Creation of the `tidy_UCIHAR Dataset` by calculation the average for each observation.



How to use the run_analysis.r script
-------------------------------

* Open the R script `run_analysis.r` using in RStudio
* Source the script by using the `source()` function

      * If the data **have not been downloaded**, launch the command `download_unzip_data()` in RStudio.
      * If the data **have been downloaded and unzipped**, identify the directory where the UCI HAR Dataset directory is, set this parent directory as the working directory with `setwd()` 

* launch the command `generate_tidy_data()` in RStudio


Details on the Output
-------------------------------
informations on the tidy_UCIHARDataset file generated can be found in the `codebook.md` file.
