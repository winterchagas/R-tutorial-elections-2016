library(dplyr)
library(plotly)
library(readxl)

df <- read_excel('Education.xls',sheet='Sheet1')

#Loading data manually
less <- c(47.7,33.5,24.8,19.6,13.3)
high <- c(31.1,34.6,30.0,28.6,27.8)
colle <- c(10.6,15.7,24.9,27.4,29.1)
bach <- c(10.7,16.2,20.3,24.4,29.8)
x <- c(1970, 1980, 1990, 2000, 2010)

# df %>% filter(County == 'United States') %>% select(less_high_school_1970) %>% as.numeric()

data <- data.frame(x, less, high, colle, bach)

# Ploting unemployment and poverty
p <- plot_ly(data, x = ~x, y = ~less, type = 'bar', name = '% Less than High School',
             marker = list(color = '#84234d')) %>% 
     add_trace(y = ~high, name = '% High School', 
               marker = list(color = '#64234d')) %>%
     add_trace(y = ~colle, name = '% College Incomplete', 
               marker = list(color = '#24234d')) %>%
     add_trace(y = ~bach, name = '% Bachelors +', 
               marker = list(color = '#04234d')) %>%
     layout(title = 'Education in the U.S time series',
            xaxis = list( title = "", tickfont = list(
                    size = 14, color = 'rgb(107, 107, 107)')),
            yaxis = list( title = '% of Population',
                    titlefont = list( size = 16,
                    color = 'rgb(107, 107, 107)'),
                    tickfont = list( size = 14,
                    color = 'rgb(107, 107, 107)')),
            legend = list(x = 1, y = 1, bgcolor = 'rgba(255, 255, 255, 0)', 
                     bordercolor = 'rgba(255, 255, 255, 0)'),
            barmode = 'group', bargap = 0.15, bargroupgap = 0.1);p
