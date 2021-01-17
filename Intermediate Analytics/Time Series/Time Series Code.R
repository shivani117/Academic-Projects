##Kings
kings <- scan("http://robjhyndman.com/tsdldata/misc/kings.dat",skip=3)
kings
kingstimeseries <- ts(kings)
kingstimeseries
births <- scan("http://robjhyndman.com/tsdldata/data/nybirths.dat")
birthsts <- ts(births, frequency=12, start=c(1946,1))
birthsts
souvenir <- scan("http://robjhyndman.com/tsdldata/data/fancy.dat")
souvenirtimeseries <- ts(souvenir, frequency=12, start=c(1987,1))
souvenirtimeseries
plot.ts(kingstimeseries)
plot.ts(birthstimeseries)
plot.ts(souvenirtimeseries)
logsouvenirtimeseries <- log(souvenirtimeseries)
plot.ts(logsouvenirtimeseries)
install.packages("TTR")
library("TTR")
kingstimeseriesSMA3 <- SMA(kingstimeseries,n=3)
plot.ts(kingstimeseriesSMA3)
kingstimeseriesSMA8 <- SMA(kingstimeseries,n=8)
plot.ts(kingstimeseriesSMA8)
birthstsc <- decompose(birthsts)
birthstsc$seasonal
plot(birthstsc)
birthstsc <- decompose(birthsts)
birthstimeseriesseasonallyadjusted <- birthstimeseries - birthstimeseriescomponents$seasonal
plot(birthstimeseriesseasonallyadjusted)


birthstsc<- decompose(birthsts)
plot(birthstsc)

birthstsc <- decompose(birthstimeseries)
birthstimeseriesseasonallyadjusted <- birthsts - birthstsc$seasonal
plot(birthstimeseriesseasonallyadjusted)

##Rain
rain <- scan("http://robjhyndman.com/tsdldata/hurst/precip1.dat",skip=1)
rainseries <- ts(rain,start=c(1813))
plot.ts(rainseries)
rainseriesforecasts <- HoltWinters(rainseries, beta=FALSE, gamma=FALSE)
rainseriesforecasts
rainseriesforecasts$fitted
plot(rainseriesforecasts)
rainseriesforecasts$SSE
HoltWinters(rainseries, beta=FALSE, gamma=FALSE, l.start=23.56)
install.packages("forecast")
library("forecast")
#rainseriesforecasts2 <- forecast.HoltWinters(rainseriesforecasts, h=8)<- This didn't work
rainseriesforecasts2 <- forecast:::forecast.HoltWinters(rainseriesforecasts, h=8)
rainseriesforecasts2
#plot.forecast(rainseriesforecasts2)<- This didn't work
forecast:::plot.forecast(rainseriesforecasts2)
#acf(rainseriesforecasts2$residuals, lag.max=20)<- This didn't work
acf(x = rainseriesforecasts2$residuals,lag.max = 20,na.action=na.pass)
acf
Box.test(rainseriesforecasts2$residuals, lag=20, type="Ljung-Box")
plot.ts(rainseriesforecasts2$residuals)
plotForecastErrors <- function(forecasterrors)
{
  # make a histogram of the forecast errors:
  mybinsize <- IQR(forecasterrors)/4
  mysd   <- sd(forecasterrors)
  mymin  <- min(forecasterrors) - mysd*5
  mymax  <- max(forecasterrors) + mysd*3
  # generate normally distributed data with mean 0 and standard deviation mysd
  mynorm <- rnorm(10000, mean=0, sd=mysd)
  mymin2 <- min(mynorm)
  mymax2 <- max(mynorm)
  if (mymin2 < mymin) { mymin <- mymin2 }
  if (mymax2 > mymax) { mymax <- mymax2 }
  # make a red histogram of the forecast errors, with the normally distributed data overlaid:
  mybins <- seq(mymin, mymax, mybinsize)
  hist(forecasterrors, col="red", freq=FALSE, breaks=mybins)
  # freq=FALSE ensures the area under the histogram = 1
  # generate normally distributed data with mean 0 and standard deviation mysd
  myhist <- hist(mynorm, plot=FALSE, breaks=mybins)
  # plot the normal curve as a blue line on top of the histogram of forecast errors:
  points(myhist$mids, myhist$density, type="l", col="blue", lwd=2)
}  
sum(is.na(rainseriesforecasts2$residuals))
#forecasterrors <- rainseriesforecasts2$residuals

plotForecastErrors(na.omit(rainseriesforecasts2$residuals))
plotForecastErrors(rainseriesforecasts2$residuals)
skirts <- scan("http://robjhyndman.com/tsdldata/roberts/skirts.dat",skip=5)
skirtsseries <- ts(skirts,start=c(1866))
plot.ts(skirtsseries)
skirtsseriesforecasts <- HoltWinters(skirtsseries, gamma=FALSE)
skirtsseriesforecasts
skirtsseriesforecasts$SSE
plot(skirtsseriesforecasts)
HoltWinters(skirtsseries, gamma=FALSE, l.start=608, b.start=9)
skirtsseriesforecasts2 <- forecast:::forecast.HoltWinters(skirtsseriesforecasts, h=19)
forecast:::plot.forecast(skirtsseriesforecasts2)
acf(x = skirtsseriesforecasts2$residuals, lag.max=20,na.action = na.pass)
Box.test(skirtsseriesforecasts2$residuals, lag=20, type="Ljung-Box")
plot.ts(skirtsseriesforecasts2$residuals)            # make a time plot
plotForecastErrors(skirtsseriesforecasts2$residuals) # make a histogram


kingtimeseriesdiff1 <- diff(kingstimeseries, differences=1)
plot.ts(kingtimeseriesdiff1)
acf(kingtimeseriesdiff1, lag.max=20)             # plot a correlogram
acf(kingtimeseriesdiff1, lag.max=20, plot=FALSE) # get the autocorrelation values
#Autocorrelations of series 'kingtimeseriesdiff1', by lag

pacf(kingtimeseriesdiff1, lag.max=20)             # plot a partial correlogram
pacf(kingtimeseriesdiff1, lag.max=20, plot=FALSE) # get the partial autocorrelation values
#Partial autocorrelations of series 'kingtimeseriesdiff1', by lag
