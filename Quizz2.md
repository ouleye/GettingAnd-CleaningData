Question 5

```r
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for",destfile = "./x.for",method = "curl")
y<-read.fwf("x.for",widths=c(-1,9,-5,4,4,-5,4,4,-5,4,4,-5,4,4),skip = 4)
sum(df[,4])
```r


