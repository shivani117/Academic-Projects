
# Read the file
data <- read.csv("D:/Data/Northeastern University/Applications of AI/Module 1/Customers.csv", stringsAsFactors = FALSE)
data
colnames(data) <- c("customerNumber", "customerName",
                    "contactLastName",
                    "contactFirstName",
                    "phone",
                    "addressLine1",
                    "addressLine2",
                    "city",
                    "state",
                    "postalCode",
                    "country",
                    "salesRepEmployeeNumber",
                    "creditLimit")
write.csv(data, file = "D:/Data/Northeastern University/Applications of AI/Module 1/cust.csv")

#Dimensions of the dataset-number of rows and columns

dim(data)

#Datatypes of various data elements using sapply and class

typeof(data)
sapply(data, class)

#The frequency distribution of the following variables: country 

install.packages('freqdist')
library(freqdist)
freqdist(data$country)
table(data$country)
barplot(table(data$country))


#The frequency distribution of the following variables: state

install.packages('freqdist')
library(freqdist)
freqdist(data$state)
table(data$state)
barplot(table(data$state))

#Mean of the credit limit
mean(data$creditLimit)

#Summary of the data
summary(data)
