#Set working directory
#getwd()
#setwd("C:\Users\Shivani Adsar\OneDrive\Desktop\Northeastern University\Enterprise Analytics\Module 6")
#getwd()


var <- read.csv("C:/Users/Shivani Adsar/OneDrive/Desktop/Northeastern University/Enterprise Analytics/Module 6/honeywell.csv")
var
#honeywell<-read_csv(file.choose())
#honeywell
str(var)

mydata<-var[,c("Open","High","Low","Close","Volume")]
mydata

install.packages("hpfilter")
library(hpfilter)
install.packages("mFilter")
require("mFilter")
#library(mfilter)
#library(quantmod)
stock<-hpfilter(log(mydata$Close),freq = 1600)
stock

#Q.3
plot(stock)

#Q.3 Cyclic
plot(stock$cycle)
plot(stock$trend)

#Q5
plot(stock$trend,mydata$Close, type = "line")

