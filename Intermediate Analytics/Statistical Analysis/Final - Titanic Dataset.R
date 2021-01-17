library(datasets)
str(attitude)
summary(attitude)
View(attitude)
dat1 = attitude[,c(3,4)]
plot(dat1, main = "% of favourable responses to
     Learning and Privilege", pch =20, cex =2)
set.seed(7)
km1 = kmeans(dat1, 2, nstart = 100)
plot(dat1, col =(km1$cluster +1) , main="K-Means result with 2 clusters", pch=20, cex=2)

km1$cluster
mydata <- dat1
wss <- (nrow(mydata)-1)*sum(apply(mydata,2,var))
for (i in 2:15) wss[i] <- sum(kmeans(mydata,
                                     centers=i)$withinss)
plot(1:15, wss, type="b", xlab="Number of Clusters",
     ylab="Within groups sum of squares",
     main="Assessing the Optimal Number of Clusters with the Elbow Method",
     pch=20, cex=2)
set.seed(7)
km3 = kmeans(dat1, 6, nstart=100)
km3
plot(dat1, col =(km3$cluster +1) , main="K-Means result with 6 clusters", pch=20, cex=2)
#----------------------------------------------------------------
Titanic_ds1<- read.csv("C:/Users/Shivani Adsar/OneDrive/Desktop/Imarticus/Dataset files/Titanictrain.csv")
str(titanic)
summary(titanic)
dat=titanic[,c(3,8)]
plot(dat1,main="Favourable responses",pch=20,cex=2,xlab="Pclass",ylab="Survived")
set.seed(7)
km1=kmeans(na.omit(dat1),2,nstart = 100)
View(dat)
plot(dat1,col=(km1$cluster +1), main="k-means",pch=20,cex=2,xlab="Pclass",ylab="Survived")
km1$cluster
mydata<-dat
wss<-(nrow(mydata)-1)*sum(apply(mydata,2,var))
for(i in 2:15)wss[i]<-sum(kmeans(na.omit(mydata),centers=i)$withinss)
plot(1:15,wss,type="b",xlab="Number of Clusters",
     ylab="Sum of squares",
     main="Optimal number of clusters elbow method",
     pch=20,cex=2)
set.seed(7)
#km2=kmeans(na.omit(dat),6,nstart=100)
#km2
#plot(dat,col=(km2$cluster +1), main="k-means", pch=20, cex=2)
km3 = kmeans(dat1, 6, nstart=100)
km3
plot(dat1, col =(km3$cluster +1) , main="K-Means result with 6 clusters", pch=20, cex=2,xlab="Pclass",ylab="Survived")

#-------------------------------------------------------------------------------------

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

