library(gsheet)
library(dplyr)

url <- "https://docs.google.com/spreadsheets/d/1a1UeZninpR3qiyZNWffBC9j0J0FoRnYHcfy43HqsnGM/edit?usp=sharing"

results <- gsheet2tbl(url,0)
results$Name <- as.factor(results$Name)
results[results$Graduation.Year=="","Graduation.Year"] <- "UNK"
results <- results %>% 
  mutate(name=as.integer(Name),
         time=substr(Formatted.Time,3,7), 
         place=as.character(Place)) %>%
  filter(Minutes>0)

names <- levels(results$Name)
n <- seq(1,nlevels(results$Name))
t <- mapply(list,names,n,SIMPLIFY=F)
selectList <- sapply(t,function(x) x[-1])

