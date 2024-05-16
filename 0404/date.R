Sys.timezone()
Sys.Date()
Sys.time()
x = c('2021-07-01', '2021-08-01', '2021-09-01')
x_date = as.Date(x)
str(x_date)

y = c('07/01/2015', '08/01/2015', '09/01/2015')
as.Date(y, format = '%m/%d/%Y')

# install.packages("lubridate")

library(lubridate)
x = c('2021-07-01', '2021-08-01', '2021-09-01')
y = c('07/01/2015', '08/01/2015', '09/01/2015')
ymd(x)
mdy(y)

x = c('2021-07-01', '2021-08-01', '2021-09-01')
year(x)
month(x)
week(x)

z = '2021-09-15'
yday(z)
mday(z)
wday(z)

x = ymd('2021-07-01', '2021-08-01', '2021-09-01')
x + years(1) - days(c(2, 9, 21))

seq(ymd('2015-01-01'), ymd('2021-01-01'), by ='years')
seq(ymd('2021-09-01'), ymd('2021-09-30'), by ='2 days')




