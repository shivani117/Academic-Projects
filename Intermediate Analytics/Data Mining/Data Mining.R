#--------------------------------------------------1st Part--------------------------------------------
install.packages("factoextra")
library(factoextra)
install.packages("nbclust")
library(NbClust)
#--------------------------------------------------2nd Part---------------------------------------------
Titanic<- read.csv("C:/Users/Shivani Adsar/OneDrive/Desktop/Imarticus/Dataset files/Titanictrain.csv")
Titanic
class(Titanic)
str(Titanic)
Titanic$Survived = factor(Titanic$Survived)
Titanic$Pclass = factor(Titanic$Pclass)
install.packages("Amelia")
require(Amelia)
missmap(Titanic, main="Titanic Data - Missings Map", col=c("red", "green"),
        legend=FALSE)
sum(is.na(Titanic$Age) == TRUE) /  length(Titanic$Age)
sapply(Titanic, function(attribute) {sum(is.na(attribute)==TRUE)/ length(attribute)
  ;})
table(Titanic$Embarked, useNA = "always")
Titanic$Embarked[which(is.na(Titanic$Embarked))] = 'S';
table(train.data$Embarked, useNA = "always")
Titanic$Name = as.character(Titanic$Name)
table_words = table(unlist(strsplit(Titanic$Name, "\\s+")))
sort(table_words [grep('\\.',names(table_words))], decreasing=TRUE)
library(stringr) 
tb_data = cbind(Titanic$Age, str_match(Titanic$Name, " [a-zA-Z]+\\."))
table(tb_data[is.na(tb_data[,1]),2])
table(Titanic$Sex)
barplot(table(Titanic$Sex), col=c("orange","lightgreen"), names= c("Female", "Male"), main="Breakdown by Gender")
split.data = function(data, p = 0.7, s = 666){
  set.seed(s)
  index = sample(1:dim(data)[1])
  trainingdataset = data[index[1:floor(dim(data)[1] * p)], ]
  testingdataset = data[index[((ceiling(dim(data)[1] * p)) + 1):dim(data)[1]], ]
  return(list(trainingdataset = trainingdataset, testingdataset = testingdataset))
} 
allset= split.data(Titanic, p = 0.7) 
titanic_trainingdataset = allset$trainingdataset 
titanic_testingdataset = allset$testingdataset
install.packages('party')
require('party')
train.ctree = ctree(Survived ~ Pclass + Sex + Age + SibSp + Fare + Parch + Embarked, data=titanic_trainingdataset)
train.ctree
plot(train.ctree, main="Applying cTree on Titanic Dataset", tp_args = list(fill = c("green","red")))

ctree.predict = predict(train.ctree, titanic_testingdataset)
install.packages("e1071")
install.packages("caret")
require(caret)
confusionMatrix(ctree.predict, titanic_testingdataset$Survived)

#---------------------------------------------3rd Part------------------------------------

titanic  = read.csv("C:/Users/Shivani Adsar/OneDrive/Desktop/Imarticus/Dataset files/Titanictrain.csv", na.strings=c("NA", ""))
titanic$Embarked[titanic$Embarked == ""] <- "S" 
titanic$FamilySize <- 1 + titanic$SibSp + titanic$Parch    #(3) 
titanic$AgeMissing <- ifelse(is.na(titanic$Age),       #(4)
                             "Y", "N")
titanic$Survived <- as.factor(titanic$Survived)
titanic$Pclass <- as.factor(titanic$Pclass)
titanic$Sex <- as.factor(titanic$Sex)
titanic$Embarked <- as.factor(titanic$Embarked)
titanic$AgeMissing <- as.factor(titanic$AgeMissing)
titanic$Age[is.na(titanic$Age)] <- median(titanic$Age, 
                                          na.rm = TRUE)
features <- c("Pclass", "Sex", "Age",
              "SibSp", "Parch", "Fare", "Embarked",
              "FamilySize", "AgeMissing")
dummy.vars <- dummyVars(~ ., titanic[, features])
View(titanic.dummy)
titanic.dummy <- predict(dummy.vars, titanic[, features])
titanic.dummy <- scale(titanic.dummy)
clusters.sum.squares <- rep(0.0, 14)
cluster.params <- 2:15
set.seed(893247)
for (i in cluster.params) {
  kmeans.temp <- kmeans(na.omit(titanic.dummy), centers = i)
  clusters.sum.squares[i - 1] <- sum(kmeans.temp$withinss)
}
clusters.sum.squares
ggplot(NULL, aes(x = cluster.params, y = clusters.sum.squares)) +
  theme_bw() +
  geom_point() +
  geom_line() +
  labs(x = "Number of Clusters",
       y = "Cluster Sum of Squared Distances",
       title = "Titanic Training Data Scree Plot")

Titanic_db
#----------------------------------------------------4TH Part------------------------------------------
install.packages("dbscan")
library(dbscan)

install.packages("fpc")
library("fpc")
dbscan(Titanic, eps, MinPts = 5, scale = FALSE, method = c("hybrid", "raw", "dist"))
data("multishapes", package = "factoextra")
df <- multishapes[, 1:2]
set.seed(123)
db <- fpc::dbscan(df, eps = 0.15, MinPts = 5)  
plot(db, df, main = "DBSCAN", frame = FALSE)

#-----------------------------------------------------5th Part--------------------------------------------

set.seed(7)
km2 = kmeans(na.omit(titanic.dummy), 6, nstart=100)

km2$cluster <- as.factor(km2$cluster)
table(na.omit(titanic.dummy), km2$cluster)
library(ggplot2)
ggplot(na.omit(titanic.dummy), aes(Pclass.1,Pclass.2,color = irisCluster$cluster)) + geom_point()



set.seed(7)
km2 = kmeans(na.omit(titanic.dummy), 6, nstart=100)


# Examine the result of the clustering algorithm
km2

plot(na.omit(titanic.dummy), col =(km2$cluster +4) , main="K-Means result with 6 clusters", pch=20, cex=2)


