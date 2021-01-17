install.packages("randomForest")
library(randomForest)
library(MASS)

glass<-fgl
glass
str(glass)
set.seed(17)
fgl.rf <- randomForest(type ~ ., data = glass, mtry = 2, importance = TRUE, do.trace = 100)
print(fgl.rf)
library(ipred)
set.seed(131)
error.RF <- numeric(10)
for(i in 1:10) error.RF[i] <- errorest(type ~ ., data = glass, model = randomForest, mtry = 2)$error
summary(error.RF)
library(e1071)
set.seed(563)
error.SVM <- numeric(10)
for (i in 1:10) error.SVM[i] <- errorest(type ~ ., data = glass,model = svm, cost = 10, gamma = 1.5)$error
summary(error.SVM)
#install.packages("ggplot2")
library(ggplot2)
#install.packages("DescTools")
library(DescTools)
par(mfrow = c(2, 2))

for (i in 1:4) 
    plot(sort(fgl.rf$importance[,i], dec = TRUE), type = "h", main = paste("Measure", i))

