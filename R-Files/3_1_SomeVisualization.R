library(plotly)
library(dplyr)

setwd("C:\\Users\\winter\\Desktop\\UCSC\\Data Analysis\\Datasets\\Elections - Work on this copy")
df2 <- read.csv('Election2.csv')
names(df2)

#Preparing education data
df <- df2 %>% select(county, state, less_than_hs, bachelor_or_higher, 
                     population_estimate)
dfBach <- df %>% arrange(desc(bachelor_or_higher)) %>% head(100)
dfBach <- mutate(dfBach, category = '#24234d')  
dfLess <- df %>% arrange(desc(less_than_hs)) %>% head(100)
dfLess <- mutate(dfLess, category = '#84234d')  
dfBachLess <- rbind(dfBach, dfLess)  
names(dfBachLess)

df %>% select(county, state, less_than_hs, bachelor_or_higher) %>% arrange(desc(bachelor_or_higher)) %>% head(200) %>% count(state)
df %>% select(county, state, less_than_hs, bachelor_or_higher) %>% arrange(desc(less_than_hs)) %>% head(200) %>% count(state)


# Ploting education
p <- plot_ly(data = dfBachLess, x = ~less_than_hs, y = ~bachelor_or_higher,
             text = ~paste("State: ", state, '<br>County:', county, 
                    '<br>% Less than High School:', less_than_hs, 
                    '<br>% Bachelors+:', bachelor_or_higher,
                    '<br>Total Population:', population_estimate),
             marker = list(size = 15,
             color = ~category,
             line = list(color = '#ffffff',
             width = 1))) %>%
             layout(title = 'Education Top vs Bottom Counties', 
                    yaxis = list(zeroline = FALSE),
                    xaxis = list(zeroline = FALSE));p

 
#Preparing unemployment and poverty data
df <- df2 %>% select(county, state, unemployment, perc_poverty,
                     population_estimate)
dfPov <- df %>% arrange(desc(perc_poverty)) %>% head(100)
dfPov <- mutate(dfPov, category = '#24234d')  
dfRich <- df %>% arrange(perc_poverty) %>% head(100)
dfRich <- mutate(dfRich, category = '#84234d')  
dfPovRich <- rbind(dfPov, dfRich)  
names(dfPovRich)

df %>% select(county, state, unemployment) %>% arrange(desc(unemployment)) %>% head(200) %>% count(state)

# Ploting unemployment and poverty
p <- plot_ly(data = dfPovRich, x = ~perc_poverty, y = ~unemployment,
             text = ~paste("State: ", state, '<br>County:', county, 
                    '<br>% in Poverty:', perc_poverty, 
                    '<br>% Unemployment:', unemployment,
                    '<br>Total Population:', population_estimate),
             marker = list(size = 15, color = ~category,
                      line = list(color = '#04234d',
                             width = 1))) %>%
             layout(title = 'Poverty vs Unemployment Counties',
                    yaxis = list(zeroline = FALSE),
                    xaxis = list(zeroline = FALSE));p
 

#Preparing crime and foreign data
df <- df2 %>% select(county, state, foreign_born, sum_crimes,
                     population_estimate)
dfFor <- df %>% arrange(desc(sum_crimes)) %>% head(100)
dfFor <- mutate(dfFor, category = '#24234d')  
dfCri <- df %>% filter(sum_crimes > 0) %>% arrange(sum_crimes) %>% head(100)
dfCri <- mutate(dfCri, category = '#84234d')  
dfForCri <- rbind(dfFor, dfCri)  
names(dfForCri)

# Ploting crime and foreign
pal <- c("red", "blue", "green")
p <- plot_ly(data = dfForCri, x = ~sum_crimes, y = ~foreign_born,
             text = ~paste("State: ", state, '<br>County:', county, 
                           '<br>% of Crime:', sum_crimes, 
                           '<br>% of Foreign born:', foreign_born,
                           '<br>Total Population:', population_estimate),
             marker = list(size = 15,
                           color = ~sum_crimes,
                           line = list(color = '#04234d',
                                       width = 1))) %>%
  layout(title = 'Crime vs Immigrants Counties',
         yaxis = list(zeroline = FALSE),
         xaxis = list(zeroline = FALSE));p
