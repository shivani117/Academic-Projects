#Author:Shivani Adsar
#1.Given Data:
unit.cost	<- 77
#2.Uncontrollable Inputs:
order.cost<-225
#3.Decision Variable:
increase.cost.holding<- 19/100
holding.cost<- increase.cost.holding*unit.cost
holding.cost#[1] 14.63
#4.The specification of the triangular distribution:
a<-13000 #Loweer Limit
b<-18000 #Upper Limit
c<-16000 #Peak

#5.To Generate 1000 random variables
#5.1.cdf()

ptriangular<-function(x,a,b,c) 
{ KK<-(1/((b-a)*(c-a)))*(x-a)^2 
PP<-1-(1/((b-a)*(b-c)))*(b-x)^2 
prob<-ifelse(x<c,KK,PP) 
return(prob) }

#5.2.calculate the corresponding value (q) of the triangular random variable
qtriangular<-function(p,a,b,c) 
{ QQ<-a+sqrt((b-a)*(c-a)*p) 
qq<-b-sqrt((b-a)*(b-c)*(1-p)) 
q<-ifelse(p<(c-a)/(b-a),QQ,qq) 
return(q) }

#5.3.generate 1000 triangular random values according to the triangular distribution of our example: 
set.seed(1)
annual_number_of_orders<-qtriangular(runif(1000),a,b,c)

#6.Calculate the minimum total cost for each occurrence
total_cost_array<-NULL
Order_Quantity.array<-NULL
for (i in annual_number_of_orders) {

  Order_Quantity=sqrt((2*i*order.cost)/holding.cost)
  Order_Quantity.array=append(Order_Quantity.array,Order_Quantity)
  annual.order.cost=(order.cost*i)/Order_Quantity
  average_annual_demand=i/12
  holding.cost.for.i=increase.cost.holding*average_annual_demand
  total.cost=holding.cost.for.i+average_annual_demand
  total_cost_array=append(total_cost_array,total.cost)
}


total_cost_array
Order_Quantity.array
#7. Create a relative frequency histogram along with the plot of the density function of the simulated values: 
hist(total_cost_array,freq=F,main="Distribution of the Simulation for Total Cost") 
lines(density(total_cost_array),lwd=2,col="red")
hist(Order_Quantity.array,freq=F,main="Distribution of the Simulation for Order Quantity") 
lines(density(Order_Quantity.array),lwd=2,col="red")
hist(annual_number_of_orders,freq=F,main="Distribution of the Simulation for Annual Number of Orders") 
lines(density(annual_number_of_orders),lwd=2,col="red")
#-----------------------------------------------------------------------------------------#

