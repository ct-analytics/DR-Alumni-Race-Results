yr <- 2014

library(dplyr)

results <- d %>%
  filter(Year==yr) %>%
  mutate(name=as.character(Name),
         time=substr(Formatted.Time,3,7)) %>%
  select(name,Minutes,time,Graduation.Year,Year) 

results$Name <- factor(results$name,
                       levels=results$name[order(-results$Minutes)])

results[results$Graduation.Year=="","Graduation.Year"] <- "UNK"

library(ggplot2)

ggplot(data=results,aes(x=Name,y=Minutes,fill=Graduation.Year)) + 
#   geom_bar(aes(fill=Graduation.Year),stat="identity") + 
  geom_bar(stat="identity") + 
  coord_flip() +
  geom_text(aes(label=time),hjust=1.1) +
  ggtitle("2014 DR XC Alumni Race Results") + 
  theme(axis.title.y = element_blank()) +
  theme(panel.background = element_blank()) +
  theme(panel.grid.minor = element_blank(), panel.grid.major = element_blank()) +
  theme(axis.ticks = element_blank()) +
#   scale_fill_discrete(name="Graduation\nYear") + 
  scale_fill_hue(h=c(180, 270)) +
  theme(legend.justification=c(1,1), legend.position=c(1,1), legend.justification = 'right')

ggplot(data=results,aes(x=Year,y=Minutes,fill=Graduation.Year)) + 
  geom_point(stat="identity") 
