*Intro to ggplot2
library(ggplot2)
gapminder<-read.csv("data/gapminder.csv")
#rm() removes values
#the grammar of graphics, by leland wilkinson (ggplot is based on that book)
#scatterplot of lifeExp vs gdpPercap
ggplot(gapminder,
       aes(x=gdpPercap,y=lifeExp))+ 
  geom_point()
# aes= aesthetics... they make a connection between a column in your data & a feature in the graph
# geom= geometric features... actual features in the plot
# the "ggplot" command makes the graphical object
#another way to do this is below... the objects only appear when you print them
p<-ggplot(gapminder,
          aes(x=gdpPercap,y=lifeExp))
p2<-p+geom_point()
print(p2)
#scales are a part of aes... ie for log scale
p3<-p+geom_point()+scale_x_log10()
print(p3)
#now x axis has a log scale
gapminderchina<-gapminder %>%
  filter(country=="China") %>%
  ggplot(aes(x=gdpPercap,y=lifeExp))+
       geom_point(size=4)
gapminderchina
#you can also put the full command in parentheses & R will make the plot as well as do the assignment
#you can also color or size or "opacity" by any attribute in a column
p2+aes(color=continent)
#you use a color command under aes b/c your coloring is dependent on the attribute "continent"
p2+aes(size=pop)
p2+aes(shape=continent)
p2+aes(size=pop,color=continent)
p2+aes(color=year,size=pop)
p2+aes(color=year,size=pop,shape=continent)
gmchina<-gapminder%>%
  filter(country=="China")
head(gapminder)
#points underneath year
ggplot(gmchina,aes(x=gdpPercap,y=lifeExp))+
  geom_line(color="violetred")+
  geom_point(color="lightblue",size=5)
#points colored by year
ggplot(gmchina,aes(x=gdpPercap,y=lifeExp))+
  geom_line(color="violetred")+
  geom_point(aes(color=year),size=5)
#points colored by pop
ggplot(gmchina,aes(x=gdpPercap,y=lifeExp))+
  geom_line(color="violetred")+
  geom_point(aes(color=pop),size=5)

#make a plot of lifeExp vs gdpPercap for China and India, with lines in black but points colored by country
chinaindia<-gapminder%>%
  filter(country== "China"|country=="India")
#equivalent to
chinaindia<-gapminder%>%
  filter(country %in% c("China","India"))

ggplot(chinaindia,
         aes(x=gdpPercap,y=lifeExp))+
  geom_line(color="black")+
  geom_point(aes(color=country))
#now separate lines for each country
ggplot(chinaindia,
       aes(x=gdpPercap,y=lifeExp, group=country))+
  geom_line(color="black")+
  geom_point(aes(color=country))
#histograms
gapminder%>%
  filter(year==2007)%>%
  ggplot(aes(x=lifeExp))+
  geom_histogram(binwidth=2.5,fill="lightblue",color="black")
#boxplot
gapminder%>%
  filter(year==2007)%>%
  ggplot(aes(y=lifeExp,x=continent))+
  geom_boxplot()
#flip the boxplot
gapminder%>%
  filter(year==2007)%>%
  ggplot(aes(y=lifeExp,x=continent))+
  geom_boxplot()+
  coord_flip()
#scatterplot
gapminder%>%
  filter(year==2007)%>%
  ggplot(aes(y=lifeExp,x=continent))+
  geom_point(position=
               position_jitter(width=0.1,height=0))
gapminder%>%
  filter(year==2007)%>%
  ggplot(aes(y=lifeExp,x=continent))+
  geom_boxplot()+
  geom_point(position=
               position_jitter(width=0.1,height=0))

#***********FACETing*************
ggplot(gapminder,
       aes(x=gdpPercap,y=lifeExp))+
  geom_point()+scale_x_log10()+
  facet_grid(~continent)

ggplot(gapminder,
       aes(x=gdpPercap,y=lifeExp))+
  geom_point()+scale_x_log10()+
  facet_grid(continent~.)

ggplot(gapminder,
       aes(x=gdpPercap,y=lifeExp))+
  geom_point()+scale_x_log10()+
  facet_grid(continent~year)

ggplot(gapminder,
       aes(x=gdpPercap,y=lifeExp))+
  geom_point()+scale_x_log10()+
  facet_wrap(~continent)

ggplot(gapminder,
       aes(x=gdpPercap,y=lifeExp,color=continent))+
  geom_point()+scale_x_log10()+
  facet_wrap(~year)

gmfive<-gapminder%>%
  filter(country %in% c("India","Japan","Canada","Albania","Tanzania"))
library(ggthemes)
ggplot(gmfive,
       aes(x=gdpPercap,y=lifeExp))+
  geom_line()+
  facet_wrap(~country)+
  theme_bw()
ggsave("~/Desktop/five_countries.pdf")


