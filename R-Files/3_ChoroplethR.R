library(choroplethr)
library(choroplethrMaps)
library(dplyr)

dfTemp <- read.csv('Election2.csv')
names(dfTemp)

#ELECTION MAP
df <- dfTemp %>% select(region =  countyID , value = point_diff)
county_choropleth(df, title = "U.S COUNTY LEVEL ELECTIONS 2016", 
                  legend = "US Elections 2016", num_colors = 9)

#CRIME MAP
df <- dfTemp %>% select(region =  countyID , value = sum_crimes)
county_choropleth(df, title = "U.S COUNTY LEVEL CRIME REPORT MAP", 
                  legend = "All Crimes reported", num_colors = 9)

#FOREIGN MAP
df <- dfTemp %>% select(region =  countyID , value = foreign_born)
county_choropleth(df, title = "U.S COUNTY LEVEL IMMIGRANT MAP", 
                  legend = "IMMIGRANT MAP", num_colors = 9)

#UNEMPLOYMENT MAP
df <- dfTemp %>% select(region =  countyID , value = unemployment)
county_choropleth(df, title = "U.S COUNTY LEVEL UNEMPLOYMENT MAP", 
                  legend = "UNEMPLOYMENT MAP", num_colors = 9)

#POVERTY MAP
df <- dfTemp %>% select(region =  countyID , value = perc_poverty)
county_choropleth(df, title = "U.S COUNTY LEVEL POVERTY MAP", 
                  legend = "POVERTY MAP", num_colors = 9)

#EDUCATION MAP LESS HIGH
df <- dfTemp %>% select(region =  countyID , value = less_than_hs)
county_choropleth(df, title = "U.S COUNTY LEVEL EDUCATION MAP", 
                  legend = "LESS THAN HIGH SCHOOL", num_colors = 9)

#EDUCATION MAP BACHELORS
df <- dfTemp %>% select(region =  countyID , value = bachelor_or_higher)
county_choropleth(df, title = "U.S COUNTY LEVEL EDUCATION MAP", 
                  legend = "BACHELORS +", num_colors = 9)

#HOUSEHOLD INCOME MAP
dfTemp <- read.csv('Election updated.csv')
dfTemp$household_income <- as.numeric(gsub(",","",dfTemp$household_income))
df <- dfTemp %>% select(region =  countyID , value = household_income)
county_choropleth(df, title = "U.S COUNTY LEVEL HOUSEHOLD INCOME", 
                  legend = "HOUSEHOLD INCOME", num_colors = 9)


