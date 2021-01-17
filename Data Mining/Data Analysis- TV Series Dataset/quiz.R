getwd()
setwd("E:\\NIKHIL\\CPS\\Quarter 2\\Data Mining\\Week 4")
getwd()

library(tidyverse)
library(caret)
library(glmnet)

gameofthrones<-read.csv(file.choose())
gameofthrones


mydata<-gameofthrones
mydata


view(mydata)

#data<-select(mydata,-c(Death.Year,Book.of.Death,Death.Chapter,Book.Intro.Chapter))

#data

#str(data)


livecharacter<-mydata$Death.Year
charcterlive_not<-livecharacter > 1
mydata$charcterlive_not<-charcterlive_not
mydata$charcterlive_not
mydata$charcterlive_not[is.na(mydata$charcterlive_not)]<-0

mydata

view(mydata)

str(mydata)
mydata$charcterlive_not<-as.factor(mydata$charcterlive_not)

train_data<-mydata[1:700,]
test_data<-mydata[701:917,]

model <- glm(charcterlive_not ~Gender+Nobility+GoT+CoK+SoS+FfC+DwD,family=binomial ,data=train_data)
summary(model)

result<-predict.glm(model, newdata=test_data, type='response')

result <- ifelse(result > 0.5,1,0)
result<-as.factor(result)


confusionMatrix(data=result,reference = test_data$charcterlive_not)


misclasificrrror <- mean(result != test_data$charcterlive_not)
print(paste('Accuracy',1-misclasificrrror))

-------------------------------------------------------------------------------------------------------

library("leaps")
library("MASS")
attach(mydata)
dmy<-dummyVars("~ Allegiances",data = mydata)
trsf<- data.frame(predict(dmy,newdata = mydata))
View(trsf)
length(trsf)
mydata<-cbind(mydata,trsf)
library("leaps")
library("MASS")
train_got<-mydata[1:700,]
test_got<-mydata[701:917,]

fullModel<- glm(charcterlive_not  ~Gender+Nobility+GoT+CoK+SoS+FfC+DwD,family=binomial ,data=train_data)
summary(fullModel)
stepModel <-stepAIC(fullModel,direction="both",trace=FALSE)
summary(stepModel)
resultStepwise<- predict.glm(stepModel,newdata = test_got,type = 'response')
resultStepwise <- ifelse(resultStepwise > 0.5,1,0)
resultStepwise<-as.factor(resultStepwise)

length(resultStepwise)

length(test_got$charcterliveornot)

library(caret)
library(e1071)
confusionMatrix(data=resultStepwise, reference=test_got$charcterliveornot)

