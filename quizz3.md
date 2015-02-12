Question 1
==========

`download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv',destfile = './hid.csv')
data <- read.csv('./hid.csv')`

Creation of a logical vector indicating how each row in the dataset respond or not to the conditions
`agricultureLogical <- data$ACR == 3 & data$AGS == 6`
`# EX of result (not accurate) => head(agricultureLogical) : [1] FALSE  NA FALSE TRUE FALSE FALSE  NA FALSE TRUE FALSE`

Display the indices where the elements of agricultureLogical == TRUE
`which(agricultureLogical)`
        `#Result on  the dataset   [1]  125  238  262  470 ...`
