#Libraries loading
library(MASS)
install.packages("GGally")
library(GGally)
install.packages("corrplot")
library(corrplot)
library(glmnet)
install.packages("dplyr")
library(dplyr)
install.packages("leaps")
library(leaps)

#Data Exploration
data(Boston)
?Boston
Boston
dim(Boston)
cormat=cor(Boston)
corrplot(cormat, type = "upper", method="number")
Boston$chas<-as.factor(Boston$chas)
plot(medv~lstat, data=Boston)
plot(medv~rm, data=Boston)
counts <- table(Boston$chas)
barplot(counts, main="", xlab="chas")

#Splitting the Test and Train data
set.seed(123)
index <- sample(nrow(Boston),nrow(Boston)*0.80) #80-20 split
Boston.train <- Boston[index,]
Boston.test <- Boston[-index,]

#Linear Regression Model
model0<- lm(medv~lstat, data = Boston.train)
model1<- lm(medv~., data=Boston.train)
model2<- lm(medv~. -indus -age, data=Boston.train)
AIC(model0)
anova(model2, model1)
summary(model2)

#Subset Selection
model.subset<- regsubsets(medv~.,data=Boston.train, nbest=1, nvmax = 13)
subset_fit=summary(model.subset)
subset_fit

#Stepwise Selection
null.model<-lm(medv~1, data=Boston)
full.model<-lm(medv~., data=Boston.train)
result<-step(null.model, scope=list(lower=null.model, upper=full.model), k = 2, direction="forward")

result$anova

result<-step(full.model, scope=list(lower=null.model, upper=full.model), k = 2, direction="backward")
result$anova
result<-step(null.model, scope=list(lower=null.model, upper=full.model), k = 2, direction="both")
result$anova

#LASSO Regression

Boston$chas<-as.numeric(Boston$chas)
#Standardize covariates before fitting LASSO
Boston.X.std<- scale(select(Boston,-medv))
X.train<- as.matrix(Boston.X.std)[index,]
X.test<-  as.matrix(Boston.X.std)[-index,]
Y.train<- Boston[index, "medv"]
Y.test<- Boston[-index, "medv"]

lasso.fit<- glmnet(x=X.train, y=Y.train, family = "gaussian", alpha = 1)
plot(lasso.fit, xvar = "lambda", label=TRUE)

#Cross- Validation in Lasso
cv.lasso<- cv.glmnet(x=X.train, y=Y.train, family = "gaussian", alpha = 1, nfolds = 10)
plot(cv.lasso)

cv.lasso$lambda.min
cv.lasso$lambda.1se

pred.lasso.train<- predict(lasso.fit, newx = X.train, s=cv.lasso$lambda.min)
pred.lasso.min<- predict(lasso.fit, newx = X.test, s=cv.lasso$lambda.min)
pred.lasso.1se<- predict(lasso.fit, newx = X.test, s=cv.lasso$lambda.1se)

mean((Y.train-pred.lasso.train)^2)

mean((Y.test-pred.lasso.min)^2)
mean((Y.test-pred.lasso.1se)^2)

#Big Lasso
?colon
data(colon)
install.packages("biglasso")
library(biglasso)
require(biglasso)
data(colon)
X <- colon$X
y <- colon$y
dim(X)
X.bm <- as.big.matrix(X)
str(X.bm)
colon

cvfit <- cv.biglasso(X.bm, y, family = 'binomial', seed = 1234, ncores = 2)
fit <- biglasso(X.bm, y, screen = "SSR-BEDPP")

plot(fit)
par(mfrow = c(2, 2))
plot(cvfit, type = 'all')
summary(cvfit)
