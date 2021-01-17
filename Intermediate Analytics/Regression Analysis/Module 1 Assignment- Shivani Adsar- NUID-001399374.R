#Part A
# Invoke R and use the "Tree" dataset
View(trees)

#Find the 5 summary numbers in the data
summary(trees)

#Graph a straight line regression
data("trees")
attach(trees)
head(trees)
str(trees)

plot(Girth,Volume,ylab="Volume (cubic ft)",xlab="Girth (in)",col="blue",pch=16,main="Girth vs Volume")
(mymod<-lm(Volume~Girth))
plot(Girth,Volume,ylab="Volume (cubic ft)",xlab="Girth (in)",col="blue",pch=16,main="Girth vs Volume")
abline(lm(Volume ~ Girth))

plot(Height,Volume,ylab="Volume (cubic ft)",xlab="Height (in)",col="red",pch=16,main="Height vs Volume")
(mymod<-lm(Volume~Height))
plot(Height,Volume,ylab="Volume (cubic ft)",xlab="Height (in)",col="red",pch=16,main="Height vs Volume")
abline(lm(Volume ~ Height))

plot(Girth,Height,ylab="Height (cubic ft)",xlab="Girth (in)",col="black",pch=16,main="Girth vs Height")
(mymod<-lm(Height~Girth))
plot(Girth,Height,ylab="Height (cubic ft)",xlab="Girth (in)",col="black",pch=16,main="Girth vs Height")
abline(lm(Height ~ Girth))

#Create Histograms and density plots


hist(trees$Height, # histogram
     col="light blue", # column color
     border="black",
     prob = TRUE, # show densities instead of frequencies
     xlab = "Height",
     main = "Histogram and Density Plot for Height")

#d <- density(trees$Height) # returns the density data
#plot(d, main="Density Plot for Height",xlab="Height")
#polygon(d, col="red", border="blue")

lines(density(trees$Height), # density plot
    lwd = 2, # thickness of line
      col = "chocolate3")
hist(trees$Volume, # histogram
     col="light green", # column color
     border="black",
     prob = TRUE, # show densities instead of frequencies
     xlab = "Volume",
     main = "Histogram and Density Plot for Volume")

#d <- density(trees$Volume) # returns the density data
#plot(d, main="Density Plot for Volume",xlab="Volume")
#polygon(d, col="Blue", border="Black")

lines(density(trees$Volume), # density plot
      lwd = 2, # thickness of line
      col = "chocolate3")
hist(trees$Girth, # histogram
     col="orange", # column color
     border="black",
     prob = TRUE, # show densities instead of frequencies
     xlab = "Girth",
     main = "Histogram and Density Plot for Girth")


#d <- density(trees$Girth) # returns the density data
#plot(d, main="Density Plot for Girth",xlab="Girth")
#polygon(d, col="Green", border="Black")

lines(density(trees$Girth), # density plot
      lwd = 2, # thickness of line
      col = "chocolate3")

#Create Boxplots 

boxplot(trees$Girth, trees$Height, trees$Volume,
        main = "Boxplots for Height, Girth and Volume",
        at = c(1,3,5),
        names = c("Girth", "Height", "Volume"),
        las = 2,
        col = c("blue","orange","green"),
        border = "brown",
        horizontal = TRUE,
        notch = FALSE
)

#Normal probability plots

qqnorm(trees$Height,pch=16,col="red",main="Normal Probability Plot for Height")
qqline(trees$Height,col="blue")

qqnorm(trees$Volume,pch=16,col="blue",main="Normal Probability Plot for Volume")
qqline(trees$Volume,col="black")

qqnorm(trees$Girth,pch=16,col="orange",main="Normal Probability Plot for Girth")
qqline(trees$Girth,col="black")

#------------------------------------------------------------------------------------------------

#Part B

install.packages("DAAG")
library(MASS)
pairs(Rubber)

Rubber.lm <- lm(loss~hard+tens, data=Rubber)
options(digits=3)
summary(Rubber.lm)

par(mfrow=c(1,2))
termplot(Rubber.lm, partial=TRUE, smooth=panel.smooth)


library(ggcorrplot)
library(MASS)
library(DAAG)
data(oddbooks)
oddbooks

logbooks <- log(oddbooks) 
logbooks.lm1<-lm(weight~thick,data=logbooks)
summary(logbooks.lm1)$coef

logbooks.lm2<-lm(weight~thick+height,data=logbooks)
summary(logbooks.lm2)$coef

logbooks.lm3<-lm(weight~thick+height+breadth,data=logbooks)
summary(logbooks.lm3)$coef

par(mfrow=c(1,1))
library(ggplot2)
library(ggcorrplot)
ggcorrplot(cor(oddbooks))

