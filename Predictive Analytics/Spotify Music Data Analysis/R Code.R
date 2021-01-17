#----------------------------------------------Spotify Dataset-------------------------------------------------
#--------------------------------------------Naive Bayes Algorithm---------------------------------------------
spotify_raw <- read.csv("C:/Users/Shivani Adsar/OneDrive/Desktop/Northeastern University/Predictive Analytics/Module 6/Final Project/Spotify.csv", stringsAsFactors = FALSE)
str(spotify_raw)
spotify_raw["Category"]<-spotify_raw$target
head(spotify_raw)
View(spotify_raw)
spotify_raw$Category<-replace(spotify_raw$Category,spotify_raw$Category==0,"Flop")
spotify_raw$Category<-replace(spotify_raw$Category,spotify_raw$Category==1,"Hit")
View(spotify_raw)
spotify_raw$Category
str(spotify_raw)
spotify_raw$Category <- factor(spotify_raw$Category)
str(spotify_raw$Category)
table(spotify_raw$Category)
install.packages("tm")
library(tm)
spotify_corpus <- Corpus(VectorSource(spotify_raw$artist))
print(spotify_corpus)
inspect(spotify_corpus[1:3])
corpus_clean <- tm_map(spotify_corpus, tolower)
corpus_clean <- tm_map(corpus_clean, removeNumbers)
corpus_clean <- tm_map(corpus_clean, removeWords, stopwords())
corpus_clean <- tm_map(corpus_clean, removePunctuation)
corpus_clean <- tm_map(corpus_clean, stripWhitespace) 
corpus_clean
nrow(spotify_raw)
spotify_dtm <- DocumentTermMatrix(corpus_clean)
spotify_raw_train <- spotify_raw[1:30000, ]
spotify_raw_test  <- spotify_raw[30001:41106, ]
spotify_dtm_train <- spotify_dtm[1:30000, ]
spotify_dtm_test  <- spotify_dtm[30001:41106, ]
spotify_corpus_train <- corpus_clean[1:30000]
spotify_corpus_test  <- corpus_clean[30001:41106]
prop.table(table(spotify_raw_train$Category))
prop.table(table(spotify_raw_test$Category))
install.packages("wordcloud")
library(wordcloud)
wordcloud(spotify_corpus_train, min.freq = 80, random.order = FALSE)
Flop <- subset(spotify_raw_train, Category == "Flop")
Hit <- subset(spotify_raw_train, Category == "Hit")
wordcloud(Flop$artist, max.words = 40, scale = c(3, 0.5)) 
wordcloud(Hit$artist, max.words = 40, scale = c(3, 0.5))
findFreqTerms(spotify_dtm_train, 5)
spotify_dict <- c(findFreqTerms(spotify_dtm_train, 5))
spotify_train <- DocumentTermMatrix(spotify_corpus_train,    list(dictionary = spotify_dict))
spotify_test  <- DocumentTermMatrix(spotify_corpus_test,    list(dictionary = spotify_dict))
convert_counts <- function(x) {
  x <- ifelse(x > 0, 1, 0)
  x <- factor(x, levels = c(0, 1), labels = c("No", "Yes"))
}
spotify_train <- apply(spotify_train, MARGIN = 2, convert_counts)
spotify_test  <- apply(spotify_test, MARGIN = 2, convert_counts)
install.packages("e1071")
library(e1071)
spotify_classifier <- naiveBayes(spotify_train, spotify_raw_train$Category)
spotify_test_pred <- predict(spotify_classifier, spotify_test)
install.packages("gmodels")
library(gmodels)
CrossTable(spotify_test_pred, spotify_raw_test$Category, prop.chisq = FALSE, prop.t = FALSE,    dnn = c('predicted', 'actual')) 
spotify_classifier2 <- naiveBayes(spotify_train, spotify_raw_train$Category,    laplace = 1) 
spotify_test_pred2 <- predict(spotify_classifier2, spotify_test)
CrossTable(spotify_test_pred2, spotify_raw_test$Category,    prop.chisq = FALSE, prop.t = FALSE, prop.r = FALSE,    dnn = c('predicted', 'actual'))

#------------------------------------------------Logistic Regression------------------------------------------
# importing data
spotify <- read.csv("C:/Users/Shivani Adsar/OneDrive/Desktop/Northeastern University/Predictive Analytics/Module 6/Final Project/Spotify.csv")

#Check first 6 rows of data
head(spotify)

#Check structure of data
str(spotify)

install.packages("dplyr")
library(dplyr)
spotify

#Let's view data
View(spotify)

#Check all values replace properly or not
id1<-spotify[spotify$target==1,]
id1

#Taking count of salary above $50K 

#Check class bias
table(spotify$target)

#Creating training and testing data

install.packages("caret")
library(caret)
set.seed(9999)
index<-spotify[sample(nrow(spotify),20000),]
partioned.spotify<-createDataPartition(
  index$target,
  times=1,
  p=0.8,
  list=F
)
spotify_training=index[partioned.spotify,]
spotify_test=index[-partioned.spotify,]
View(spotify)

#find information value
factor_vars<-NULL
for(factor_var in factor_vars){
  spotify[[factor_var]] <- WOE(X=spotify[, factor_var], Y=spotify$target)
}
head(spotify)

#Compute information values
install.packages("smbinning")
library(smbinning)

factor_vars <- c ("target","mode")
continuous_vars <- c("danceability","energy","key","loudness","speechiness","acousticness","instrumentalness","liveness","valence","duration_ms","time_signature","chorus_hit")

iv_df <- data.frame(VARS=c(factor_vars, continuous_vars), IV=numeric(14))  # init for IV results

# compute IV for categoricals
for(factor_var in factor_vars){
  smb <- smbinning.factor(spotify_training, y="target", x=factor_var)  # WOE table
  if(class(smb) != "character"){ # heck if some error occured
    iv_df[iv_df$VARS == factor_var, "IV"] <- smb$iv
  }
}

# compute IV for continuous vars
for(continuous_var in continuous_vars){
  smb <- smbinning(spotify_training, y="target", x=continuous_var)  # WOE table
  if(class(smb) != "character"){  # any error while calculating scores.
    iv_df[iv_df$VARS == continuous_var, "IV"] <- smb$iv
  }
}

iv_df <- iv_df[order(-iv_df$IV), ]  # sort
iv_df

# build logit model and predict

logitMod <- glm(target ~ instrumentalness +loudness +liveness+acousticness+valence+speechiness, data=spotify_training, family=binomial(link="logit"))

predicted <- predict(logitMod, spotify_test, type="response")  # predicted scores
predicted
#predicted <- plogis(predict(logitMod, spotify_testData))
predicted
#Decide on optimal prediction probability cutoff for the model
install.packages("InformationValue")
library(InformationValue)
optcutoff <- optimalCutoff(spotify_test$target, predicted)[1] 
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
misClassError(spotify_test$target, predicted, threshold = optcutoff)

#Receiver Operating Characteristics Curve
plotROC(spotify_test$target, predicted)

#Concordance
Concordance(spotify_test$target, predicted)

# Sensitivity
sensitivity(spotify_test$target, predicted, threshold = optcutoff)

#Specificity
specificity(spotify_test$target, predicted, threshold = optcutoff)

#Confusion Matrix
confusionMatrix(spotify_test$target, predicted, threshold = optcutoff)

#---------------------------------------K-Nearest Neighbors Algorithm----------------------------------------
## Example: Classifying Spotify Samples ----
## Step 2: Exploring and preparing the data ---- 

# import the CSV file
spotify <- read.csv("C:/Users/Ronak Duduskar/R files/spotify.csv", stringsAsFactors = FALSE)

# examine the structure of the spotify data frame
str(spotify)

# drop the id feature
spotify <- spotify[-1:-3]
spotify <- spotify[-4]

# table of target
table(spotify$target)
spotify$target <- replace(spotify$target, spotify$target==0, "Flop")
spotify$target <- replace(spotify$target, spotify$target==1, "Hit")
# recode diagnosis as a factor
#spotify$target <- factor(spotify$target, levels = c("H", "F"),
#labels = c("Hits", "Flops"))
#spotify$target
# table or proportions with more informative labels
round(prop.table(table(spotify$target)) * 100, digits = 1)

# summarize three numeric features
summary(spotify)
View(spotify)

# create normalization function
normalize <- function(x) {
  return ((x - min(x)) / (max(x) - min(x)))
}
normalize

# test normalization function - result should be identical
normalize(c(1, 2, 3, 4, 5))
normalize(c(10, 20, 30, 40, 50))

# normalize the spotify data
spotify_n <- as.data.frame(lapply(spotify[1:14], normalize))

# confirm that normalization worked
summary(spotify_n$energy)

# create training and test data
spotify_train <- spotify_n[1:28775, ]
spotify_test <- spotify_n[28776:41106, ]

# create labels for training and test data

spotify_train_labels <- spotify[1:28775, 15]
spotify_test_labels <- spotify[28776:41106, 15]

## Step 3: Training a model on the data ----

# load the "class" library
install.packages("class")
library(class)

spotify_test_pred <- knn(train = spotify_train, test = spotify_test,cl = spotify_train_labels, k=200)
spotify_test_pred
## Step 4: Evaluating model performance ----

# load the "gmodels" library

install.packages("gmodels")
library(gmodels)


# Create the cross tabulation of predicted vs. actual
CrossTable(x = spotify_test_labels, y = spotify_test_pred,
           prop.chisq=FALSE)
## Step 5: Improving model performance ----

# use the scale() function to z-score standardize a data frame
spotify_z <- as.data.frame(scale(spotify[-15]))

# confirm that the transformation was applied correctly
summary(spotify_z$target)

# create training and test datasets
spotify_train <- spotify_z[1:28775, ]
spotify_test <- spotify_z[28776:41106, ]

# re-classify test cases
spotify_test_pred <- knn(train = spotify_train, test = spotify_test,
                         cl = spotify_train_labels, k=200)

# Create the cross tabulation of predicted vs. actual
CrossTable(x = spotify_test_labels, y = spotify_test_pred,
           prop.chisq=FALSE)

# try several different values of k
spotify_train <- spotify_n[1:28775, ]
spotify_test <- spotify_n[28776:41106, ]

spotify_test_pred <- knn(train = spotify_train, test = spotify_test, cl = spotify_train_labels, k=210)
CrossTable(x = spotify_test_labels, y = spotify_test_pred, prop.chisq=FALSE)

spotify_test_pred <- knn(train = spotify_train, test = spotify_test, cl = spotify_train_labels, k=190)
CrossTable(x = spotify_test_labels, y = spotify_test_pred, prop.chisq=FALSE)

spotify_test_pred <- knn(train = spotify_train, test = spotify_test, cl = spotify_train_labels, k=180)
CrossTable(x = spotify_test_labels, y = spotify_test_pred, prop.chisq=FALSE)


