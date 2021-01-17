

mushrooms <- read.csv("C:/Users/Shivani Adsar/OneDrive/Desktop/Northeastern University/Predictive Analytics/Module 3/mushrooms.csv")
#$ veil_type : Factor w/ 1 level "partial": 1 1 1 1 1 1 ... 
mushrooms$veil_type <- NULL
View(mushrooms)
table(mushrooms$class)
plot(mushrooms$class)
install.packages("RWeka")
library(RWeka)
install.packages("rJava")
library(rJava)
install.packages("OneR")
library(OneR)
mushroom_1R <- OneR(class ~ ., data = mushrooms)
#mushroom_1R <- OneR(veil-type ~ ., data = mushrooms)
mushroom_1R
summary(mushroom_1R)
install.packages("rpart")
#library(ctree)
install.packages("partykit")
library("partykit")
mushrooms_ctree<-ctree(odor ~ class,data=mushrooms)
mushrooms_ctree
plot(mushrooms_ctree)
mushrooms_ctreeall <- ctree(class ~ odor + gill.size , data = mushrooms)
plot(mushrooms_ctreeall)
mushroom_JRip <- JRip(class ~ ., data = mushrooms)
mushroom_JRip
