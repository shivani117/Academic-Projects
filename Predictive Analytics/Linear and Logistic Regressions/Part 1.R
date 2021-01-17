##### Generalized linear models and logistic regressions ######

## Example: Classifying Forensic Glass Dataset ----
## Step 2: Exploring and preparing the data ---- 


#Using rats data from survival package

library(survival)

#Getting rats data and stored in vector rat
rat<-rats

#Checking structure of data
str(rat)
View(rat)
nrow(rat)

#Building the logistic model
fit<-glm(cbind(status,1-status)~rx, family = binomial,data = rats)
fit

#Taking summary of coefficients
summary(fit)$coef

#standard error is found as sqrt of diagonal in variance
sqrt(diag(summary(fit)$cov.scaled))


c(fit$deviance, -2*logLik(fit))

#Null deviance is -2times 
c(fit$null.deviance, -2*logLik(update(fit, formula = .~1)))

#Use update to change fit modelwithin binomial family
fit2<-update(fit, family=binomial(link = "probit"))

rbind(logit=fit$coefficients, probit=fit2$coefficients, rescale.probit=fit2$coefficients/0.5513)

#Model Quality
fit3<-update(fit, formula=.~. + I(log(time)))

summary(rats$time[rats$status==1])
summary(rats$time[rats$status==0])

#new modelfor significance of coefficient
cbind(rats[1:10,], model.matrix(fit3)[1:10,])

#coefficients of new model
summary(fit3)$coefficients

#Compare veviances
c(2*(logLik(fit3)-logLik(fit)),fit$deviance-fit3$deviance)

#compare with 1 df
1-pchisq(20.226,1)

#Try different method to get different p-value
fit4<-update(fit3, .~. + I(rx*log(time))+I(log(time)^2))

#get summary of ths fit4 model
summary(fit4)$coefficients

#Check deviance
fit3$deviance-fit4$deviance


anova(fit4)


devs<-c(fit$null.deviance, fit$deviance, fit3$deviance, update(fit3, .~.+I(rx*log(time)))$deviance, fit4$deviance)
devs

round(-diff(devs), 3)
