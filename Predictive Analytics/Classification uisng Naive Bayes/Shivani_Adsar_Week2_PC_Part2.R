#--------------------------------------IMDB Dataset-----------------------

library(tm)
library(wordcloud)
library(e1071)
library(gmodels)

#Importing the Dataset
imdb <- read.csv("C:/Users/Shivani Adsar/OneDrive/Desktop/Northeastern University/Predictive Analytics/Module 2/IMDB Dataset.csv")
str(imdb)
#Factorisation
imdb$sentiment <- factor(imdb$sentiment)
table(imdb$sentiment)
#Storing in Corpus
imdb_corpus <- Corpus(VectorSource(imdb$review))
print(imdb_corpus)
#install.packages("tm")
library(tm)
#Cleaning
corpus_clean <- tm_map(imdb_corpus, tolower)
corpus_clean <- tm_map(corpus_clean, removeNumbers)
corpus_clean <- tm_map(corpus_clean, removeWords, stopwords()) 
corpus_clean <- tm_map(corpus_clean, removePunctuation) 
corpus_clean <- tm_map(corpus_clean, stripWhitespace) 
imdb_dtm <- DocumentTermMatrix(corpus_clean)
imdb_raw_train <- imdb[1:3000, ] 
imdb_raw_test  <- imdb[3001:4000, ] 
imdb_dtm_train <- imdb_dtm[1:3000, ] 
imdb_dtm_test  <- imdb_dtm[3001:4000, ] 
imdb_corpus_train <- corpus_clean[1:3000]
imdb_corpus_test  <- corpus_clean[3001:4000]
prop.table(table(imdb_raw_train$sentiment))
prop.table(table(imdb_raw_test$sentiment))
#Building Word Cloud
#install.packages("wordcloud")
library(wordcloud)
wordcloud(imdb_corpus_train, min.freq = 50, random.order = FALSE) 
positive <- subset(imdb_raw_train, sentiment == "positive")
negative <- subset(imdb_raw_train, sentiment == "negative")
wordcloud(positive$review, max.words = 40, scale = c(3, 0.5)) 
wordcloud(negative$review, max.words = 40, scale = c(3, 0.5))
findFreqTerms(imdb_dtm_train, 5) 

imdb_dict <- c(findFreqTerms(imdb_dtm_train, 5))

imdb_train <- DocumentTermMatrix(imdb_corpus_train,    list(dictionary = imdb_dict)) 
imdb_test  <- DocumentTermMatrix(imdb_corpus_test,    list(dictionary = imdb_dict)) 
convert_counts <- function(x) {
  x <- ifelse(x > 0, 1, 0)
  x <- factor(x, levels = c(0, 1), labels = c("No", "Yes"))
}
imdb_train <- apply(imdb_train, MARGIN = 2, convert_counts)
imdb_test  <- apply(imdb_test, MARGIN = 2, convert_counts)
#Naive Bayes Classifier
#install.packages("e1071")
library(e1071)
imdb_classifier <- naiveBayes(imdb_train, imdb_raw_train$sentiment)
imdb_test_pred <- predict(imdb_classifier, imdb_test) 
library(gmodels)
CrossTable(imdb_test_pred, imdb_raw_test$sentiment,    prop.chisq = FALSE, prop.t = FALSE,    dnn = c('predicted', 'actual')) 
imdb_classifier2 <- naiveBayes(imdb_train, imdb_raw_train$sentiment,    laplace = 1) 
imdb_test_pred2 <- predict(imdb_classifier2, imdb_test)
CrossTable(imdb_test_pred2, imdb_raw_test$sentiment,    prop.chisq = FALSE, prop.t = FALSE, prop.r = FALSE,    dnn = c('predicted', 'actual')) 
