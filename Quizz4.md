Question 1
----------
>The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:

>https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
>and load the data into R. The code book, describing the variable names is here:

>https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf

>Apply strsplit() to split all the names of the data frame on the characters "wgtp". What is the value of the 123 element of the resulting list?


```
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv', destfile = './datasshid.csv')
datasshid <-read.csv('./datasshid.csv')
```

```
names(datasshid)
```

```
a <-strsplit(names(datasshid),'wgtp')
 (return a list)
```

```
a[[123]]
[1] ""   "15"
```


Question 2
----------
>Load the Gross Domestic Product data for the 190 ranked countries in this data set:

>https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv

>Remove the commas from the GDP numbers in millions of dollars and average them. What is the average?

>Original data sources: http://data.worldbank.org/data-catalog/GDP-ranking-table 


```
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv', destfile = './fgdp.csv')

```

After taking a look at the file,I can see that the 4 rows of csv can be skipped and only the 190 next rows are relevant as per the question informations :
   >Load the Gross Domestic Product data for the **190** ranked countries in this data set: 

I also prevent the read.csv function to create variable as factors.
```
fgdp <- read.csv('./fgdp.csv', skip=4, nrows=190, stringsAsFactors = FALSE)
```


I had colnames to the fgdp dataframe, in order to work more easily
```
colnames(fgdp) <-  c("CountryCode", "rankingGDP",'RandomInfo', "Long.Name", "gdp")
```


```
str(fgdp)
'data.frame':	190 obs. of  10 variables:
 $ CountryCode: chr  "USA" "CHN" "JPN" "DEU" ...
 $ rankingGDP : int  1 2 3 4 5 6 7 8 9 10 ...
 $ RandomInfo : logi  NA NA NA NA NA NA ...
 $ Long.Name  : chr  "United States" "China" "Japan" "Germany" ...
 $ gdp        : chr  " 16,244,600 " " 8,227,103 " " 5,959,718 " " 3,428,131 " ...
 $ NA         : chr  "" "" "" "" ...
 $ NA         : logi  NA NA NA NA NA NA ...
 $ NA         : logi  NA NA NA NA NA NA ...
 $ NA         : logi  NA NA NA NA NA NA ...
 $ NA         : logi  NA NA NA NA NA NA ...
```


The structure shows that the gdp variable is a string
I will then, remove the commas in gdp variable and transform it as numeric
```
fgdp$gdp <- as.numeric(gsub(',','',fgdp$gdp))
```


Calculate the mean
```
mean(fgdp$gdp, na.rm = TRUE)
[1] 377652.4
```




Question 3
-----------
>In the data set from Question 2 what is a regular expression that would allow you to count the number of countries whose name begins with "United"? Assume that the variable with the country names in it is named countryNames. How many countries begin with United?

`grep("^United",countryNames), 3`


Question 4
-----------

>Load the Gross Domestic Product data for the 190 ranked countries in this data set:

>https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv

>Load the educational data from this data set:

>https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv

>Match the data based on the country shortcode. Of the countries for which the end of the fiscal year is available, how many end in June?

>Original data sources:
>http://data.worldbank.org/data-catalog/GDP-ranking-table
>http://data.worldbank.org/data-catalog/ed-stats

