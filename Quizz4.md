question 1
----------

```
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv', destfile = './datasshid.csv')
datasshid <-read.csv('./datasshid.csv')
```r

```
names(datasshid)
```r

```
a <-strsplit(names(datasshid),'wgtp')
 (return a list)
```r

```
a[[123]]
[1] ""   "15"
```r
