library(dplyr)

df <- read.csv('Election updated.csv')
head(df)

#Take the comma off the column
df$population_estimate <- as.numeric(gsub(",","",df$population_estimate))

#Create a new column with the sum of all crimes
df <- mutate(df, sum_crimes = MURDER+RAPE+ROBBERY+AGASSLT+BURGLRY+LARCENY+MVTHEFT+ARSON)

# Crimes as a percentage of total population
df$sum_crimes <- (df$sum_crimes/df$population_estimate)*100

#Bring votes to same percentage scale
df$Trump_points <- df$Trump_points*100
df$Clinton_points <- df$Clinton_points*100
df$point_diff <- df$Trump_points-df$Clinton_points

#New Dataframe with just some columns
df2 <- df %>% select(countyID, county, state, point_diff, 
                     female., white, black, native, asian, 
                     hawaiian, multiple_races, hispanic, 
                     foreign_born, perc_poverty, population_estimate, 
                     unemployment, less_than_hs, highschool, 
                     associate, bachelor_or_higher, sum_crimes)

#Dataframe to new csv file
write.csv(df2, file = "Election2.csv")
