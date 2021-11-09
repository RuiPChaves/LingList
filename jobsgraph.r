rm(list=ls())
library(ggplot2)
library(ggthemes)
library(rcartocolor)
library(dplyr)

# Load data
j <- read.delim("jobs.txt", sep = ",")

# Normalize area names
levels(j$Area) <- c("CompLing","CompLing","Documentation","ForensicLing","HistoricalLing","Morphology","Neurolinguistics","Phonetics","Phonology","Pragmatics","Psycholinguistics","Semantics","Sociolinguistics","Syntax","Typology","Applied")

################################################################
# To improve legibility, some areas are removed:

# Historical has only 31 jobs (1997-2021) so, it is removed
j <- j[!(j$Area=="HistoricalLing"),]

# Forensic linguistics has a total of 153 jobs (1997-2021) so, it is removed
j <- j[!(j$Area=="ForensicLing"),]

# Applied linguistics has 164 jobs (1997-2021) so, it is removed
j <- j[!(j$Area=="Applied"),]


j$Area <- factor(j$Area) 

#########################################################################################
# Overall jobs by area, regardless of year

jto <- as.data.frame(aggregate(j$Jobs~j$Area, FUN=sum))
colnames(jto) <- c("Area","Jobs") 
jto$Area = with(jto, reorder(Area,Jobs,sum))

# View table
jto

# Bar plot
ggplot(jto, aes(x = Area,y = Jobs, group = Area, fill = factor(Area))) + 
  geom_histogram(stat="identity", color = "#000000",size=0.3) + 
  ylab("Job posts") +
  #labs(title = "Overall job postings at https://linguistlist.org, per specialization area") +             
  labs(title = "Prof job postings at https://linguistlist.org, per specialization area") +             
  #labs(title = "PostDoc job postings at https://linguistlist.org, per specialization area") +             
  theme_bw(base_size=14) +
  #scale_fill_colorblind(8) +
  #scale_fill_carto_d(name = "Area: ", palette = "Safe") +
  theme(legend.title=element_blank(),legend.position = "none",
        panel.background = element_rect(fill = "white")) 

# Pie plot  (not easy to read)
ggplot(jto, aes(x="", y=Jobs, fill=Area)) +
  theme_bw(base_size=14) +
  #scale_fill_carto_d(name = "Area: ", palette = "Safe") +
  geom_bar(width = 1, stat = "identity") +
  coord_polar("y", start=0) +
  theme(axis.title.y=element_blank(), axis.text.y=element_blank(), axis.ticks.y=element_blank()) 



#########################################################################
# Factor year

# Not many jobs were posted in the 90's, so these years are removed
j <- j %>% filter(Year >= 2000)

jt <- as.data.frame(aggregate(j$Jobs~j$Year + j$Area, FUN=sum))
colnames(jt) <- c("Year","Area","Jobs") 
jt$Year <- factor(jt$Year)

ggplot(jt, aes(x = Year, y = Jobs, group = Area, fill = factor(Area))) + 
     geom_histogram(stat="identity", color = "#000000",size=0.3) + 
      ylab("Job posts") +
      xlab("") +
      #labs(title = "Overall job postings at https://linguistlist.org, per specialization area") +             
      labs(title = "Prof job postings at https://linguistlist.org, per specialization area") +             
      #labs(title = "PostDoc job postings at https://linguistlist.org, per specialization area") +             
      theme_bw(base_size=14) +
      #scale_fill_colorblind(8) +
      scale_fill_carto_d(name = "Area: ", palette = "Safe") +
      theme(legend.title=element_blank(),legend.position = "right",
              panel.background = element_rect(fill = "white")) 
  

# Stacked, percentages 
ggplot(j, aes(x = factor(Year), y=  Jobs, fill = factor(Area))) + 
  geom_bar(position="fill", stat="identity",  size=0.3) + 
  ylab("Job posts") +
  xlab("") +
  labs(title = "Prof job postings at https://linguistlist.org, per specialization area") +             
  theme_bw(base_size=14) +
  scale_fill_carto_d(name = "Area: ", palette = "Safe") +
  theme(legend.title=element_blank(),legend.position = "right",
        panel.background = element_rect(fill = "white")) 

# Line plot (not very legible)
ggplot(jt, aes(x = Year,y = Jobs, group = Area, color=Area)) + 
  geom_point(lwd = 2) + 
  geom_line() +
  labs(title = "Job postings at https://linguistlist.org") +             
  theme_bw() +
  scale_color_carto_d(name = "Area: ", palette = "Safe") +
  ylab("Job posts") 



