getwd()
setwd("E:\\NIKHIL\\CPS\\Quarter 2\\Data Mining\\Week 1")
getwd()

library(tidyverse)
library(caret)

healthcare<-read.csv(file.choose())
healthcare
view(healthcare)
str(healthcare)

healthcare$smoking_status<-as.character(healthcare$smoking_status)
healthcare$gender<-as.character(healthcare$gender)

str(healthcare)

summary(healthcare)

#Taking mean of BMI
mean_bmi<-mean(healthcare$bmi,na.rm = T)
mean_bmi

#Filling blank by mean of BMI
healthcare<-healthcare %>%
  mutate(bmi=ifelse(is.na(bmi),mean_bmi,bmi))
healthcare

attach(healthcare)

healthcare$smoking_status<-ifelse((healthcare$smoking_status==""),"NA",healthcare$smoking_status)
view(healthcare$smoking_status)

#1.	Glucose level of male and female?
glucose<-group_by(healthcare,gender)
glucose
summarise(glucose, mean_glucose=mean(avg_glucose_level))%>%
ggplot(aes(y=mean_glucose, x=gender,fill=gender))+geom_col()+
  xlab("Gender") + ylab("Average Glucose level")+
  ggtitle("Average glucose level as per Gender")+
  theme(plot.title = element_text(hjust = 0.5),
        axis.title = element_text(colour = "Blue", size=15),
        axis.title.y=element_text(color="Red",size=15),
        axis.text.x=element_text(size=15, angle = 20),
        axis.text.y=element_text(size=15),
        legend.title=element_text(size=15),
        legend.text=element_text(size=15),
        legend.position=("right"),
        legend.justification=c(1,1))
------------------------------------------------------------------------------------------------------------

#3.	Average glucose level of people as per work type?
glucose_work_type<-group_by(healthcare,work_type)
glucose_work_type
summarise(glucose_work_type, mean_glucose=mean(avg_glucose_level))%>%
  ggplot(aes(y=mean_glucose, x=work_type,fill=work_type))+geom_col()+
  xlab("Work type") + ylab("Average Glucose level")+
  ggtitle("Average glucose level as per work type")+
  theme(plot.title = element_text(hjust = 0.5),
        axis.title = element_text(colour = "Blue", size=15),
        axis.title.y=element_text(color="Red",size=15),
        axis.text.x=element_text(size=15, angle = 20),
        axis.text.y=element_text(size=15),
        legend.title=element_text(size=15),
        legend.text=element_text(size=15),
        legend.position=("right"),
        legend.justification=c(1,1))
-----------------------------------------------------------------------------------------------------------
#4.	Average age as per smoking status? 
age_smoking_status<-group_by(healthcare,smoking_status)
age_smoking_status
summarise(age_smoking_status, mean_glucose=mean(age))%>%
  ggplot(aes(y=mean_glucose, x=smoking_status,fill=smoking_status))+geom_col()+
  xlab("Smoking Status") + ylab("Average age")+
  ggtitle("Average age level as per smoking status")+
  theme(plot.title = element_text(hjust = 0.5),
        axis.title = element_text(colour = "Blue", size=15),
        axis.title.y=element_text(color="Red",size=15),
        axis.text.x=element_text(size=15, angle = 20),
        axis.text.y=element_text(size=15),
        legend.title=element_text(size=15),
        legend.text=element_text(size=15),
        legend.position=("right"),
        legend.justification=c(1,1))

#5.	Age as per smoking status? 
smoking_status_age<-ggplot(data=healthcare,aes(x=smoking_status,y=age, fill=smoking_status))
smoking_status_age

smoking_status_age+geom_boxplot()+
xlab("Smoking Status")+ylab("age")+
  ggtitle("Smoking status as per age")+
  theme(plot.title = element_text(hjust = 0.5),
        axis.title = element_text(colour = "Blue", size=15),
        axis.title.y=element_text(color="Red",size=15),
        axis.text.x=element_text(size=15, angle = 20),
        axis.text.y=element_text(size=15),
        legend.title=element_text(size=15),
        legend.text=element_text(size=15),
        legend.position=("right"),
        legend.justification=c(1,1))

----------------------------------------------------------------------------------------------------------
#7.	How many people have hypertension as per smoking status?
smoking_status_hyp1<-group_by(healthcare,smoking_status)
smoking_status_hyp1
filter(healthcare,hypertension==1)%>%
  ggplot(aes(y=hypertension, x=smoking_status,fill=smoking_status))+geom_col()+
  xlab("Smoking Status") + ylab("Hypertension")+
  ggtitle("Hypertension as per smoking status")+
  theme(plot.title = element_text(hjust = 0.5),
        axis.title = element_text(colour = "Blue", size=15),
        axis.title.y=element_text(color="Red",size=15),
        axis.text.x=element_text(size=15, angle = 20),
        axis.text.y=element_text(size=15),
        legend.title=element_text(size=15),
        legend.text=element_text(size=15),
        legend.position=("right"),
        legend.justification=c(1,1))
---------------------------------------------------------------------------------------------------------
#8.	How many people have heart disease as per smoking status?
smoking_status_heart<-group_by(healthcare,smoking_status)
smoking_status_heart
filter(healthcare,heart_disease==1)%>%
  ggplot(aes(y=heart_disease, x=smoking_status,fill=smoking_status))+geom_col()+
  xlab("Smoking Status") + ylab("Heart Disease count")+
  ggtitle("Heart disease as per smoking status")+
  theme(plot.title = element_text(hjust = 0.5),
        axis.title = element_text(colour = "Blue", size=15),
        axis.title.y=element_text(color="Red",size=15),
        axis.text.x=element_text(size=15, angle = 20),
        axis.text.y=element_text(size=15),
        legend.title=element_text(size=15),
        legend.text=element_text(size=15),
        legend.position=("right"),
        legend.justification=c(1,1))
-----------------------------------------------------------------------------------------------------------
# 9. BMI as per work type
bmi_work_type<-group_by(healthcare,work_type)
bmi_work_type
summarise(bmi_work_type, mean_bmi=mean(bmi))%>%
  ggplot(aes(y=mean_bmi, x=work_type,fill=work_type))+geom_col()+
  xlab("Work Type") + ylab("Average BMI")+
  ggtitle("Average BMI as per work status")+
  theme(plot.title = element_text(hjust = 0.5),
        axis.title = element_text(colour = "Blue", size=15),
        axis.title.y=element_text(color="Red",size=15),
        axis.text.x=element_text(size=15, angle = 20),
        axis.text.y=element_text(size=15),
        legend.title=element_text(size=15),
        legend.text=element_text(size=15),
        legend.position=("right"),
        legend.justification=c(1,1))
---------------------------------------------------------------------------------------------------------------
#Stroke staus as per residence status
stroke_status_residence<-group_by(healthcare,Residence_type)
stroke_status_residence
filter(healthcare, Residence_type=="Rural" | Residence_type=="Urban")%>%
  ggplot(aes(y=stroke, x=Residence_type,fill=Residence_type))+geom_col()+
  xlab("Resident type") + ylab("Stroke count")+
  ggtitle("Stroke count as per resident type")+
  theme(plot.title = element_text(hjust = 0.5),
        axis.title = element_text(colour = "Blue", size=15),
        axis.title.y=element_text(color="Red",size=15),
        axis.text.x=element_text(size=15, angle = 20),
        axis.text.y=element_text(size=15),
        legend.title=element_text(size=15),
        legend.text=element_text(size=15),
        legend.position=("right"),
        legend.justification=c(1,1))

-------------------------------------------------------------------------------------------------------
#Stroke status as per hypertension and heart disese
stroke_status<-group_by(healthcare,stroke)
stroke_status
filter(healthcare, hypertension==1)%>%
  ggplot(aes(y=hypertension, x=stroke,fill=stroke))+geom_col()+
  xlab("Stroke") + ylab("Hypertension count")+
  ggtitle("Stroke count as per hypertension")+
  theme(plot.title = element_text(hjust = 0.5),
        axis.title = element_text(colour = "Blue", size=15),
        axis.title.y=element_text(color="Red",size=15),
        axis.text.x=element_text(size=15, angle = 20),
        axis.text.y=element_text(size=15),
        legend.title=element_text(size=15),
        legend.text=element_text(size=15),
        legend.position=("right"),
        legend.justification=c(1,1))

------------------------------------------------------------------------------------------------------------
#Stroke status as per age
stroke_age<-ggplot(data=healthcare,aes(x=as.factor(stroke),y=age, fill=gender))
stroke_age

stroke_age+geom_boxplot()+
  xlab("stroke")+ylab("age")+
  ggtitle("Stroke status as per age")+
  theme(plot.title = element_text(hjust = 0.5),
        axis.title = element_text(colour = "Blue", size=15),
        axis.title.y=element_text(color="Red",size=15),
        axis.text.x=element_text(size=15),
        axis.text.y=element_text(size=15),
        legend.title=element_text(size=15),
        legend.text=element_text(size=15),
        legend.position=("right"),
        legend.justification=c(1,1))

------------------------------------------------------------------------------------------------------
#if age us <18,change smoking status to never smoked
neversmoked<-healthcare %>%
  mutate(smoking_status=ifelse(age<18 & smoking_status == "NA","never smoked",smoking_status))
neversmoked

view(neversmoked)

str(neversmoked)

id<-neversmoked[neversmoked$id==47350,]
id
 
#if age<18 replace work type as Never worked 
neversmoked$work_type<-as.character(neversmoked$work_type)

neversmoked1<-neversmoked %>%
  mutate(work_type=ifelse(age<18 & work_type == "Never_worked","Children",work_type))
neversmoked1

id1<-neversmoked1[neversmoked$id==16556,]
id1


view(neversmoked1)
---------------------------------------------------------------------------------------------------------

neversmoked1 %>%
  filter(smoking_status=="never smoked" )

neversmoked1 %>% 
  count(smoking_status=="NA")

neversmoked1 %>%
  count(smoking_status=="never smoked" )