# importing data
incomedata <- read.csv("C:/Users/Shivani Adsar/OneDrive/Desktop/Northeastern University/Predictive Analytics/Module 5/adult.data.csv")

#Check first 6 rows of data
head(incomedata)

#Check structure of data
str(incomedata)

#If saary lessthan $50K replace itby zer or keep that as one
install.packages("dplyr")
library(dplyr)
incomedata<-incomedata %>%
  mutate(salary=ifelse(salary=="<=50K",0, 1))
incomedata

#Let's view data
View(incomedata)

#Check all values replace properly or not
id1<-incomedata[incomedata$salary==1,]
id1

#Taking count of salary above $50K 
count(id1)

#Check class bias
table(incomedata$salary)

#Creating training and testing data

# Create Training Data
income_ones <- incomedata[which(incomedata$salary == 1), ]  # all 1's
income_zeros <- incomedata[which(incomedata$salary == 0), ]  # all 0's

set.seed(100)  # for repeatability of samples
income_ones_training_rows <- sample(1:nrow(income_ones), 0.7*nrow(income_ones))  # 1's for training
income_zeros_training_rows <- sample(1:nrow(income_zeros), 0.7*nrow(income_ones))  # 0's for training. Pick as many 0's as 1's

income_training_ones <- income_ones[income_ones_training_rows, ]  
income_training_zeros <- income_zeros[income_zeros_training_rows, ]

income_trainingData <- rbind(income_training_ones, income_training_zeros)  # row bind the 1's and 0's 


# Create Test Data
income_test_ones <- income_ones[-income_ones_training_rows, ]
income_test_zeros <- income_zeros[-income_zeros_training_rows, ]
income_testData <- rbind(income_test_ones, income_test_zeros)  # row bind the 1's and 0's 


#find information value
factor_vars<-NULL
for(factor_var in factor_vars){
  incomedata[[factor_var]] <- WOE(X=incomedata[, factor_var], Y=incomedata$salary)
}
head(incomedata)

#Compute information values
install.packages("smbinning")
library(smbinning)

factor_vars <- c ("workclass", "education", "marital.status", "occupation", "relationship", "race", "sex", "native.country")
continuous_vars <- c("age", "fnlwgt","education.num", "hours.per.week", "capital.gain", "capital.loss")

iv_df <- data.frame(VARS=c(factor_vars, continuous_vars), IV=numeric(14))  # init for IV results

# compute IV for categoricals
for(factor_var in factor_vars){
  smb <- smbinning.factor(income_trainingData, y="salary", x=factor_var)  # WOE table
  if(class(smb) != "character"){ # heck if some error occured
    iv_df[iv_df$VARS == factor_var, "IV"] <- smb$iv
  }
}

# compute IV for continuous vars
for(continuous_var in continuous_vars){
  smb <- smbinning(income_trainingData, y="salary", x=continuous_var)  # WOE table
  if(class(smb) != "character"){  # any error while calculating scores.
    iv_df[iv_df$VARS == continuous_var, "IV"] <- smb$iv
  }
}

iv_df <- iv_df[order(-iv_df$IV), ]  # sort
iv_df

# build logit model and predict

logitMod <- glm(salary ~ relationship + age + capital.gain + occupation + education.num, data=income_trainingData, family=binomial(link="logit"))

predicted <- predict(logitMod, income_testData, type="response")  # predicted scores
predicted
#predicted <- plogis(predict(logitMod, income_testData))
predicted
#Decide on optimal prediction probability cutoff for the model
install.packages("InformationValue")
library(InformationValue)
optcutoff <- optimalCutoff(income_testData$salary, predicted)[1] 
optcutoff

#Model Diagnostics
summary(logitMod)

#Check for multicolinearity
install.packages("car")
library(car)
install.packages("VIF")
library(VIF)
vif(logitMod)

#Misclassification Error
misClassError(income_testData$salary, predicted, threshold = optcutoff)

#Receiver Operating Characteristics Curve
plotROC(income_testData$salary, predicted)

#Concordance
Concordance(income_testData$salary, predicted)

# Sensitivity
sensitivity(income_testData$salary, predicted, threshold = optcutoff)

#Specificity
specificity(income_testData$salary, predicted, threshold = optcutoff)

#Confusion Matrix
confusionMatrix(income_testData$salary, predicted, threshold = optcutoff)
