

#Importing the Titanic Data Set
TitanicDS <- read.csv("C:/Users/Shivani Adsar/OneDrive/Desktop/Imarticus/Dataset files/Titanictrain.csv")
TitanicDS
View(TitanicDS)
library(dplyr)
mean(Titanic)
?Titanic

#Mean
mean(TitanicDS$Fare) #On an average, passengers paid $32 for boarding the titanic
#Mode
mode(TitanicDS$Age)
updated_mode <- table(TitanicDS$Age)
updated_mode
#Inorder to find the most frequent value
names(updated_mode)[updated_mode == max(updated_mode)]
#Median
median(TitanicDS$Fare)
#Range
range(TitanicDS$Fare)
#BoxPlot
boxplot(TitanicDS$Age ~ TitanicDS$Pclass, xlab = "Class", ylab = "Age", col = c("Green"))

#Histogram and Density Plot
hist(TitanicDS$Fare, # histogram
     col="light blue", # column color
     border="black",
     prob = TRUE, # show densities instead of frequencies
     xlab = "Fare",ylab = "Frequency",
     main = "Fare per person")
lines(density(TitanicDS$Fare), # density plot
      lwd = 2, # thickness of line
      col = "chocolate3")

#BarPlot
barplot(prop.table(table(TitanicDS$Survived)), names.arg=c('Didn\'t Survive', 'Survived'), main="Proportion of Survivors", col=c('Orange','lightseagreen'))

#Z-Test

train<- subset(TitanicDS,subset = (TitanicDS$Pclass=="1"))
train
View(train)
z.testfun = function(a, b, n){
  sample_mean = mean(a)
  pop_mean = mean(b)
  c = nrow(n)
  var_b = var(b)
  zeta = (sample_mean - pop_mean) / (sqrt(var_b/c))
  return(zeta)
}
z.testfun(train$Survived, TitanicDS$Survived, train)


#Chi-Square Test

chisq.test(TitanicDS$Survived, TitanicDS$Sex)
