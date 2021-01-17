install.packages("randomForest")
library(randomForest)
library(MASS)


abalone <- read.csv("C:/Users/Shivani Adsar/OneDrive/Desktop/Northeastern University/Predictive Analytics/Module 1/abalone.csv")
abalone

str(abalone)
abalone$Sex<-as.factor(abalone$Sex)
sum(is.na(abalone))
set.seed(17)
abalone.rf <- randomForest(Sex ~ ., data = abalone, mtry = 2, importance = TRUE, do.trace = 100)
print(abalone.rf)
library(ipred)
set.seed(131)
error.RF <- numeric(10)
for(i in 1:10) error.RF[i] <- errorest(Sex ~ ., data = abalone, model = randomForest, mtry = 2)$error
summary(error.RF)
library(e1071)
set.seed(563)
error.SVM <- numeric(10)
for (i in 1:10) error.SVM[i] <- errorest(Sex ~ ., data = abalone,model = svm, cost = 10, gamma = 1.5)$error
summary(error.SVM)
#install.packages("ggplot2")
library(ggplot2)
#install.packages("DescTools")
library(DescTools)
par(mfrow = c(2, 2))

for (i in 1:4) 
  plot(sort(abalone.rf$importance[,i], dec = TRUE), Sex = "h", main = paste("Measure", i))
