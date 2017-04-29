library(dplyr)
library(ggplot2)
library(ggthemes)
library(corrplot)
library(corrgram)
library(caTools)

# Import the dataset
df <- read.csv('Election2.csv')
names(df)

#Create a column called result which just stores 
#the values 1 for Republican and 0 for Democrat
df$result <- ifelse(df$point_diff > 0,1,0)
df %>% select(result) %>% count(result)
#Check if any NA value
any(is.na(df))

#Correlation with all the numeric values
num.cols <- sapply(df, is.numeric)
cor.data <- cor(df[,num.cols]);cor.data

#Two types of ploting the correlation
corrplot(cor.data,method='color')
corrgram(df,order=TRUE, lower.panel=panel.shade, upper.panel=panel.pie, text.panel=panel.txt)

#Histogram of Points Difference
ggplot(df,aes(x=result)) + geom_histogram(bins=25,alpha=0.5,fill='blue') + theme_minimal()
df$result <- factor(df$result)

# Spliting Data
sample <- sample.split(df$result, SplitRatio = 0.70) 
# Training Data
# SplitRatio =  sample==TRUE
train = subset(df, sample == TRUE)
# Test Data
test = subset(df, sample == FALSE)

#Build and run the model
model <- glm(formula=result ~ state + female. + white + black + native + asian + hawaiian + multiple_races + 
             hispanic + foreign_born + perc_poverty + population_estimate + unemployment + less_than_hs +
             highschool + associate + bachelor_or_higher + sum_crimes, family = binomial(link='logit'), train)
summary(model)

#Calculating the predictions
fittedProbabilities <- predict(model,newdata=test,type='response')

#Transform the results in to 0, 1
fittedResults <- ifelse(fittedProbabilities > 0.5,1,0)

#Checking model accuracy
misClasificError <- mean(fittedResults != test$result)
acc <- paste(c(round(1-misClasificError, 6)*100,"%"), collapse="")
paste('ACCURACY', acc)

#Confusion Matrix
table(test$result, fittedProbabilities > 0.5)

