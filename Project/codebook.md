Codebook
========

Variable list and descriptions
------------------------------

Variable name    | Description
-----------------|------------ 
subject          | Identifier of the subject. Range from 1 to 30.
activity         | Activity name
Domain           | Domain signal (Time or Frequency)
component        | Acceleration signal Component (Body or Gravity)
Instrument       | Measuring instrument (Accelerometer or Gyroscope)
Measure          | type of measure (Mean Value or Standard Deviation)
Jerk             | Jerk signal (True or False)
Magnitude        | Magnitude of the signals calculated using the Euclidean norm (True or False)
Axis             | 3-axial signals in the X, Y and Z directions (X, Y, or Z)
Value            | Average for each observation




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


Save to file
------------

Save data table objects to a tab-delimited text file called `tidy_data.txt`. Available on Coursera Course project

