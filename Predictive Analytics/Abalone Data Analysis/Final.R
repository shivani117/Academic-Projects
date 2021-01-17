
bac<-read.csv("C:/Users/Shivani Adsar/OneDrive/Desktop/Northeastern University/Predictive Analytics/Module 1/kc_house_data.csv")
bac

str(bac)
bac <- bac[-1]
table(bac$condition)
#bac$condition <- factor(bac$condition, levels = c("1", "2","3","4","5"),
#                         labels = c("poor", "bad","better","good","best"))
#bac$condition
round(prop.table(table(bac$condition)) * 100, digits = 1)

# summarize three numeric features
summary(bac[c("sqft_living", "sqft_living15", "sqft_basement")])

# create normalization function
normalize <- function(x) {
  return ((x - min(x)) / (max(x) - min(x)))
}
normalize
# test normalization function - result should be identical
normalize(c(1, 2, 3, 4, 5))
normalize(c(10, 20, 30, 40, 50))
summary(bac)
bac[18] <- lapply(bac[18], abs)
bac
# normalize the wbcd data
bac_n <- as.data.frame(lapply(bac[2:20], normalize))
# confirm that normalization worked
summary(bac_n$sqft_living)
# create training and test data
bac_train <- bac_n[1:20000, ]
bac_test <- bac_n[20001:21613, ]
bac_train_labels <- bac[1:20000, 1]
bac_test_labels <- bac[20001:21613, 1]
# load the "class" library
install.packages("class")
library(class)
bac_test_pred <- knn(train = bac_train, test = bac_test,
                      cl = bac_train_labels, k=10)
bac_test_pred
# load the "gmodels" library
install.packages("gmodels")
library(gmodels)
# Create the cross tabulation of predicted vs. actual
CrossTable(x = bac_test_labels, y = bac_test_pred,
           prop.chisq=FALSE)
## Step 5: Improving model performance ----

# use the scale() function to z-score standardize a data frame
bac_z <- as.data.frame(scale(bac[-1]))
# confirm that the transformation was applied correctly
summary(bac_z$sqft_living)
# create training and test datasets
bac_train <- bac_z[1:469, ]
bac_test <- bac_z[470:569, ]
bac_test_pred <- knn(train = bac_train, test = bac_test,
                      cl = bac_train_labels, k=21)
CrossTable(x = bac_test_labels, y = bac_test_pred,
           prop.chisq=FALSE)
# try several different values of k
bac_train <- bac_n[1:469, ]
bac_test <- bac_n[470:569, ]
bac_test_pred <- knn(train = bac_train, test = bac_test, cl = bac_train_labels, k=1)
CrossTable(x = bac_test_labels, y = bac_test_pred, prop.chisq=FALSE)

