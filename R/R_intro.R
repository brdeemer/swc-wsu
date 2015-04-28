2+2
5*6
ls() #lists objects in environment
# a vector of weights
weights <- c(50,60,65,82)
weights
animals <- c("mouse","rat","dog")
animals
length(weights) #tells you the number of arguments in the vector
class(weights) #tells you numeric vs character etc
str(weights) #gives length, class, and heading
weights<-c(weights,90)
weights
weights <- c(30,weights)
weights
y <- 4
x <- 15
z <- c(x,y,weights)
mean(z)

#WORKING WITH DATA!!!!

getwd() 
list.files() #lists files in dir.
gapminder <- read.csv("data/gapminder.csv")
head(gapminder)
class(gapminder)
str(gapminder)
weights[1]
weights[1:3]
gapminder[1,1]
gapminder[1,3]
gapminder[500,5:6]#selects 500th row and 5th and 6th column
gapminder$pop #takes vector of all values in the population column
#equivalent to
gapminder[,5]
#equivalent to
gapminder[,"pop"]
#all data for Finland
gapminder[gapminder$country=="Finland",]
#countries and years where p<=100000
gapminder[gapminder$pop<=100000,c("country","year")]
#you can use numbers, but sometimes it is better to use the names because that way if you change the ordering of your columns you still get same return
gapminder[gapminder$lifeExp>80,"country"]
#install a package
install.packages("dplyr")
install.packages("ggplot2")

#*****DPLYR**********
# dplyr is built to work directly with data frames & helps with simple data analysis
# dplyr can work directly with data stored in an external database
library("dplyr")
select(gapminder,country,year,pop)
filter(gapminder,country=="Finland")
# dplyr implements a pipe %>% takes everything that is on the left hand side and sends it to the right side
gapminder_sml <- gapminder %>%
  filter(pop <= 100000) %>%
  select(country,year)
gapminder %>%
  filter(gdpPercap>=35000)%>%
  select(country,year,gdpPercap)

#what if you want to add new columns to your dataset (particularly based on values in previous columns)
#MUTATE
gapminder %>%
  mutate(totalgdp=gdpPercap*pop) %>%
  head
#split, apply, combine paradigm
gapminder %>%
  mutate(totalgdp=gdpPercap*pop) %>%
  group_by(continent) %>%
  summarize(meangdp=mean(totalgdp))

gapminder %>%
  mutate(totalgdp=gdpPercap*pop) %>%
  group_by(continent,year) %>%
  summarize(meangdp=mean(totalgdp))

gapminder %>%
  mutate(totalgdp=gdpPercap*pop) %>%
  group_by(continent,year) %>%
  summarize(meangdp=mean(totalgdp),mingdp=min(totalgdp))

gapminder %>%
  group_by(continent)%>%
  summarize(maxExp=max(lifeExp))

gapminder %>%
  group_by(year)%>%
  summarize(maxExp=max(lifeExp),meanExp=mean(lifeExp),minExp=min(lifeExp))

#"summarize" and "mutate" both create new columns of data, but "mutate" keeps the same number of rows as the original dataframe, whereas "summarize" collapses the data
 
gapminder %>%
  filter(country=="Albania",year<1982)%>%
  select(country,year,pop) 

#"filter" works on rows, "select" works on columns
#group_by "I have a set of variables that I want to lump together"

??summarize
#summarize command will be drawn from most recently uploaded library package
library(help=dplyr)
#shows all the commands in the dplyr package

#*******EXPORTING DATA***********
write.csv(gapminder_sml,"gapminder_sml.csv")
