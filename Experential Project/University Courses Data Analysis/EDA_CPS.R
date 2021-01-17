## Step 1: Exploring and preparing the data ---- 
# Import Libraries
library(tidyverse)
library(janitor)
library(readxl)
library(sjmisc)
library(wordcloud)
library(tm)
getwd()
setwd("C:\\Users\\mishr\\Google Drive\\NEU\\Quarter 5\\XN")
getwd()

# import courses and skills file
course_skills_raw<- read_xlsx("XN Project_Skills by Course_4.2020.xlsx",sheet = 2)
course_skills_raw
# Now, we want to first convert from wide to long, and then from long to “traditional” wide
# to do that we need a part of the title of the columns with skills to be the same, as pivot_longer(starts_with("Skill Labels") needs a starts with

course_skills_raw_colnames<-colnames(course_skills_raw)
course_skills_raw_colnames
getrownumber<-array()
#Then I got how numbers that have "..." in their title, as those are the ones we want to replace with skill labels
for (i in 1:length(course_skills_raw_colnames)) {
  if (str_contains(course_skills_raw_colnames[i],"..." )) {
    getrownumber[i]<-i
  }
}
getrownumber
s<-na.omit(getrownumber)
s
temp<- array()
#Then we put Skill lables in our data header
for (i in 1:length(s)) {
  temp[i]<-paste("Skill Labels ", toString(i))
  names(course_skills_raw)[s[i]]<-temp[i]
}
colnames(course_skills_raw)
# Then we convert our data into long format, using pivot all the columns taht start with skill lables
course_skills_long <- course_skills_raw %>% pivot_longer(starts_with("Skill Labels"), values_drop_na = TRUE)
course_skills_long
course_skills_long %>% tabyl(value)
# Then we convert our data into long format, using pivot using Course Code as identifier
course_skills_wide <- course_skills_long %>% 
  mutate(checked = 1) %>% # Used for creating a binary 1/0 variable for each value
  pivot_wider(
    id_cols = "Course Code",
    names_from = value,
    values_from = checked,
    values_fill = list(checked = 0) # Fills in 0 for any value not "checked" above by the `mutate()` function
  )
course_skills_wide
#Then we check if that worked
nrow(course_skills_long)
nrow(course_skills_wide)
nrow(course_skills_raw)
#Then create a CSV file to use in tableau
write.csv(course_skills_wide,"course_skills_wide.csv")
write.csv(course_skills_long,"course_skills_long.csv")

# import courses and skills file
course_skills_with_program_raw<- read.csv("Course_Skills_Long_For_R.csv")
course_skills_with_program_raw

course_skills_with_program_long <- course_skills_with_program_raw %>% pivot_longer(starts_with("Program"), values_drop_na = TRUE)
course_skills_with_program_long
course_skills_with_program_long %>% tabyl(value)
#Then we check if that worked
nrow(course_skills_with_program_long)
nrow(course_skills_with_program_raw)
#Then create a CSV file to use in tableau
write.csv(course_skills_with_program_long,"course_skills_with_program_long.csv")

#Word Cloud to find out the highest occuring skill

corpus <- Corpus(VectorSource(course_skills_long$value))
print(corpus)
corpus_clean <- tm_map(corpus, tolower)
corpus_clean <- tm_map(corpus_clean, removeNumbers)
corpus_clean <- tm_map(corpus_clean, removeWords, stopwords()) 
corpus_clean <- tm_map(corpus_clean, removePunctuation) 
corpus_clean <- tm_map(corpus_clean, stripWhitespace) 
dtm <- DocumentTermMatrix(corpus_clean)                 
wordcloud(corpus, min.freq = , random.order = FALSE, colors=brewer.pal(6, "Dark2"))
#In description
corpus_desc <- Corpus(VectorSource(course_skills_long$Description))
print(corpus)
corpus_desc_clean <- tm_map(corpus_desc, tolower)
corpus_desc_clean <- tm_map(corpus_desc_clean, removeNumbers)
corpus_desc_clean <- tm_map(corpus_desc_clean, removeWords, stopwords()) 
corpus_desc_clean <- tm_map(corpus_desc_clean, removePunctuation) 
corpus_desc_clean <- tm_map(corpus_desc_clean, stripWhitespace) 
dtm <- DocumentTermMatrix(corpus_desc_clean)                 
wordcloud(corpus_desc_clean, min.freq = , random.order = FALSE, colors=brewer.pal(6, "Dark2"))
