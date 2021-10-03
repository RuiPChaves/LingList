rm(list=ls())
library(ggplot2)
library(ggthemes)
library(rcartocolor)
library(dplyr)

# Load data
j <- read.delim("jobs.txt", sep = ",")

# Normalize area names
levels(j$Area) <- c("CompLing","CompLing","Documentation","ForensicLing","HistoricalLing","Morphology","Neurolinguistics","Phonetics","Phonology","Pragmatics","Psycholinguistics","Semantics","Sociolinguistics","Syntax","Typology")

# Forensic linguistics has less than 10 jobs (1997-2021) so, it is removed
j <- j[!(j$Area=="ForensicLing"),]

# Typology has less than 30 jobs (1997-2021) so, it is removed
j <- j[!(j$Area=="Typology"),]

j$Area <- factor(j$Area) 


#########################################################################################
# Overall jobs by area, regardless of year

jto <- as.data.frame(aggregate(j$Jobs~j$Area, FUN=sum))
colnames(jto) <- c("Area","Jobs") 
jto$Area = with(jto, reorder(Area,Jobs,sum))

# View table
jto

# Pie plot 
ggplot(jto, aes(x="", y=Jobs, fill=Area)) +
  theme_bw(base_size=14) +
  scale_fill_carto_d(name = "Area: ", palette = "Safe") +
  geom_bar(width = 1, stat = "identity") +
  coord_polar("y", start=0) +
  theme(axis.title.y=element_blank(), axis.text.y=element_blank(), axis.ticks.y=element_blank()) 

# Bar plot
ggplot(jto, aes(x = Area,y = Jobs, group = Area, fill = factor(Area))) + 
  geom_histogram(stat="identity", color = "#000000",size=0.3) + 
  ylab("Job posts") +
  #labs(title = "Overall job postings at https://linguistlist.org, per specialization area") +             
  labs(title = "Prof job postings at https://linguistlist.org, per specialization area") +             
  #labs(title = "PostDoc job postings at https://linguistlist.org, per specialization area") +             
  theme_bw(base_size=14) +
  #scale_fill_colorblind(8) +
  scale_fill_carto_d(name = "Area: ", palette = "Safe") +
  theme(legend.title=element_blank(),legend.position = "bottom",
        panel.background = element_rect(fill = "white")) 


#########################################################################
# Factor year

jt <- as.data.frame(aggregate(j$Jobs~j$Year + j$Area, FUN=sum))
colnames(jt) <- c("Year","Area","Jobs") 
jt$Year <- factor(jt$Year)

    ggplot(jt, aes(x = Year, y = Jobs, group = Area, fill = factor(Area))) + 
     geom_histogram(stat="identity", color = "#000000",size=0.3) + 
      ylab("Job posts") +
      #labs(title = "Overall job postings at https://linguistlist.org, per specialization area") +             
      labs(title = "Prof job postings at https://linguistlist.org, per specialization area") +             
      #labs(title = "PostDoc job postings at https://linguistlist.org, per specialization area") +             
      theme_bw(base_size=14) +
      #scale_fill_colorblind(8) +
      scale_fill_carto_d(name = "Area: ", palette = "Safe") +
      theme(legend.title=element_blank(),legend.position = "bottom",
              panel.background = element_rect(fill = "white")) 
  

##############################################################################
# Jobs across years, regardless of area
    
jtt <- as.data.frame(aggregate(j$Jobs~j$Year, FUN=sum))
colnames(jtt) <- c("Year","Jobs") 
years <- unique(jtt$Year)


ggplot(jtt, aes(x = Year,y = Jobs)) + 
  geom_point(lwd = 2) + 
  geom_line() +
  #geom_histogram(stat = "identity") +
  labs(title = "Job postings at https://linguistlist.org") +             
  theme_bw() +
  ylab("Job posts") +
  theme(legend.title=element_blank(),legend.position = "none",
        panel.background = element_rect(fill = "white")) +
  scale_x_continuous(labels=as.character(years),breaks=years)

