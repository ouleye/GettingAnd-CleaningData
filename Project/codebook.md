Codebook
========

Variable list and descriptions
------------------------------

Variable name    | Description
-----------------|------------ 
SubjectID        | Identifier of the 30 subjects 
Activity         | Activity name
Domain           | Domain signal
component        | Acceleration signal Component
Instrument       | Measuring instrument
Jerk             | Jerk signal
Magnitude        | Magnitude of the signals calculated using the Euclidean norm
Axis             | 3-axial signals in the X, Y and Z directions
Measure          | type of measure
Value            | Average for each observation

Variable Value
------------------------------

Variable name    | Values
-----------------|------------ 
SubjectID        | Rang from 1 to 30
Activity         | WALKING,WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
Domain           | Time , Frequency
Component        | Body , Gravity
Instrument       | Accelerometer , Gyroscope
Jerk             | TRUE, FALSE
Magnitude        | TRUE, FALSE
Axis             | X, Y, Z, NA
Measure          | Mean Value, Standard Deviation
Value            | type = number


Dataset structure
-----------------

```r
str(tidy_data)
```

```
Classes ‘data.table’ and 'data.frame':	11880 obs. of  10 variables:
 $ SubjectID : Factor w/ 30 levels "1","2","3","4",..: 1 1 1 1 1 1 1 1 1 1 ...
 $ Activity  : Factor w/ 6 levels "LAYING","SITTING",..: 1 1 1 1 1 1 1 1 1 1 ...
 $ Domain    : Factor w/ 2 levels "Frequency","Time": 1 1 1 1 1 1 1 1 1 1 ...
 $ Component : Factor w/ 2 levels "Body","Gravity": 1 1 1 1 1 1 1 1 1 1 ...
 $ Instrument: Factor w/ 2 levels "Accelerometer",..: 1 1 1 1 1 1 1 1 1 1 ...
 $ Jerk      : logi  FALSE FALSE FALSE FALSE FALSE FALSE ...
 $ Magnitude : logi  FALSE FALSE FALSE FALSE FALSE FALSE ...
 $ Axis      : Factor w/ 3 levels "X","Y","Z": 1 1 2 2 3 3 NA NA 1 1 ...
 $ Measure   : Factor w/ 2 levels "Mean Value","Standard Deviation": 1 2 1 2 1 2 1 2 1 2 ...
 $ value     : num  -0.939 -0.924 -0.867 -0.834 -0.883 ...
 - attr(*, "sorted")= chr  "SubjectID" "Activity" "Domain" "Component" ...
 - attr(*, ".internal.selfref")=<externalptr>
```

Variable breaking process
------------------------------
The aim of this part is to explain how the feature information has been broken into 7 (seven) columns in order to have one observation by column.


 Feature              | Domain    | Component    | Instrument    | Jerk      | Magnitude    | Axis      | Measure    
----------------------|-----------|--------------|---------------|-----------|--------------|-----------|-----------
tBodyAccMag-mean()-Y  | Time      | Body         | Accelero.     | FALSE     | TRUE         | Y         | Mean. 
tGravityGyro-mean()   | Time      | Gravity      | Gyroscope     | FALSE     | FALSE        | NA        | Mean. 
fBodyAccJerk-std()-Z  | Frequen.  | Body         | Accelero.     | TRUE      | FALSE        | Z         | Standard Deviation 



Save to file
------------

Save data table objects to a tab-delimited text file called `tidy_data.txt`. Available on Coursera Course project Page

