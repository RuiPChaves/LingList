rm(list=ls())
library(ggplot2)
library(ggthemes)
library(rcartocolor)

stx <- read.delim("jobs_Syntax.txt", sep = " ")
stx$Job <- " Syntax"

sem <- read.delim("jobs_Semantics.txt", sep = " ")
sem$Job <- " Semantics"

comp <- read.delim("jobs_Computational.txt", sep = " ")
comp$Job <- " Computational   "

comp2 <- read.delim("jobs_Comp Ling.txt", sep = " ")
comp2$Job <- " Computational   "

mrp <- read.delim("jobs_Morphology.txt", sep = " ")
mrp$Job <- " Morphology"

phl <- read.delim("jobs_Phonology.txt", sep = " ")
phl$Job <- " Phonology   "

pht <- read.delim("jobs_Phonetics.txt", sep = " ")
pht$Job <- " Phonetics"

prg <- read.delim("jobs_Pragmatics.txt", sep = " ")
prg$Job <- " Pragmatics"

psy <- read.delim("jobs_Psycholing.txt", sep = " ")
psy$Job <- " Psycholinguistics  "

soc <- read.delim("jobs_Socio.txt", sep = " ")
soc$Job <- " Sociolinguistics"

typ <- read.delim("jobs_Typology.txt", sep = " ")
typ$Job <- " Typology"

doc <- read.delim("jobs_Documentation.txt", sep = " ")
doc$Job <- " Documentation"

doc2 <- read.delim("jobs_Lang Document.txt", sep = " ")
doc2$Job <- " Documentation"

neur <- read.delim("jobs_Neuroling.txt", sep = " ")
neur$Job <- " Neurolinguistics"

hist <- read.delim("jobs_Historical.txt", sep = " ")
hist$Job <- " Historical"

fore <- read.delim("jobs_Forensic.txt", sep = " ")
fore$Job <- " Forensic"


j <- rbind(stx, sem, comp, comp2, mrp, phl, pht, psy, soc, doc, neur,hist,fore)


j$Year <- factor(j$Year)
j$Job <- factor(j$Job)
j$Month <- factor(j$Month, levels=unique(as.character(j$Month)) )


jt <- as.data.frame(aggregate(j$Jobs~j$Year + j$Job, FUN=sum))
colnames(jt) <- c("Year","Area","Jobs") 





ggplot(jt, aes(x = Year,y = Jobs, group = Jobs, fill = factor(Area))) + 
 geom_histogram(stat="identity", color = "#000000",size=0.3) + 
  ylab("Job posts") +
  labs(title = "Prof job postings at https://linguistlist.org, per specialization area") +             
  theme_bw(base_size=14) +
  scale_fill_carto_d(name = "Area: ", palette = "Safe") +
  theme(legend.title=element_blank(),legend.position = "bottom",
          panel.background = element_rect(fill = "white")) 


