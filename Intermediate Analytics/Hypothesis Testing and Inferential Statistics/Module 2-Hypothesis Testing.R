# Assignment : Hypothesis Testing
# ---------------------------------------Part A---------------------------------------------
library(MASS)

#----------------------------------------Part B--------------------------------------------
data("chem")
View(chem)
?chem
mean(chem)
#t.test(chem, mu= 4.280417)
#Ho: mu<=1
#Ha: mu>1
#alpha:0.05
t.test(chem, mu=1, alternative = "greater")
#p-value=0.0029
#t=3.0337
#Since, the p-value is lesser than the significance level, we will reject the null hypothesis 

#----------------------------------------Part C-------------------------------------------
data("cats")
View(cats)
?cats
male <-subset(cats, subset=(cats$Sex=="M"))
male
female <-subset(cats, subset=(cats$Sex=="F"))
female

#H0: Male and female have same body weight
#Ha: Male and Female do not have the same body weight

t.test(male$Bwt, female$Bwt, alternative = "two.sided")

# We will reject the null hypothesis since the p-value is smaller than the Significance Level

#---------------------------------------Part D----------------------------------------------
data("shoes")
View(shoes)
#Ho: muA-muB <= 0
#Ha: muA-muB > 0
t.test(shoes$A,shoes$B, paired=TRUE, alternative = "greater")
#Since the p-value is greater than significance level, we fail to reject null hypothesis

#---------------------------------------Part E------------------------------------------------
#data("bacteria")
#View(bacteria)
#?bacteria
#Ho: p<0.5
#Ha: p>0.5
library(MASS)
data(bacteria)
prop=bacteria[[1]]
table(prop)
x=0
n=length(prop)
for(i in 1:n)
{ if(prop[i]=="y")
  x=x+1 #to calculate number of cases with presence of bacteria
}
prop.test(x=x,n=n,p=0.5,alternative='greater')

#-------------------------------------------Part F--------------------------------------------------
data("cats")
#Ho: V1/V2 equal to 1
#Ha: V1/V2 not equal to 1
var.test(male$Bwt, female$Bwt)
          