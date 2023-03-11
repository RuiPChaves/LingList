# Clear memory buffer
rm(list=ls())

# Load libraries
library(ggplot2)
library(ggthemes)
library(rcartocolor)
library(dplyr)

###################################################################
# Load data (pick which dataset to load)
###################################################################

desc <- "'Professor' Job postings at https://linguistlist.org"
j <- read.delim("jobs0.csv", sep = ",")

#desc <- "'PostDoc' Job postings at https://linguistlist.org"
#j <- read.delim("jobs1.csv", sep = ",")

#desc <- "Overall Job postings at https://linguistlist.org"
#j <- read.delim("jobs2.csv", sep = ",")

###################################################################



j$Month <- factor(j$Month)
j$Area <- factor(j$Area)
j$Year <- as.numeric(j$Year)
j$Jobs <- as.numeric(j$Jobs)

# Normalize area names ("Comp Ling" / "Computational Linguistics" / "Natural Language Processing")
levels(j$Area)[1] <- "CompLing"
levels(j$Area)[2] <- "CompLing"
levels(j$Area)[6] <- "CompLing"

# A(c)quisition
levels(j$Area)[11] <- "Acquisition"

# Socio
levels(j$Area)[13] <- "SocioLing"

j$Area <- factor(j$Area)


#########################################################################################
# Overall jobs by area, regardless of year

jto <- as.data.frame(aggregate(j$Jobs~j$Area, FUN=sum))
colnames(jto) <- c("Area","Jobs") 

# View table
jto %>% arrange(-Jobs)


# Bar plot
ggplot(jto, aes(x = reorder(Area, Jobs),y = Jobs, group = Area, fill = factor(Area))) + 
  geom_histogram(stat="identity", color = "#000000",size=0.3) + 
  ylab("Job posts") +
  xlab("Job area") +
  labs(title = desc) +             
  theme_bw(base_size=14) +
   coord_flip() +
  theme(legend.title=element_blank(),legend.position = "none",
        panel.background = element_rect(fill = "white")) 



################################################################
# To improve plot legibility (WCAG package can't handle more than 12 colors), some areas can be are removed.
# Forensic, Typology, and Documentation are removed because they have the lowest overall counts ( < 70 ).
# Acquisition posts often conflate language teaching (e.g. TESOL/TEFL/ELT) with Acquisition research.

j <- j[!(j$Area %in% c("Forensic","Typology","Documentation","Acquisition")),]

j$Area <- factor(j$Area) 

#########################################################################

# Not many jobs were posted at the LL website in the 90s, so these years are removed
j <- j %>% filter(Year >= 2000)

jt <- as.data.frame(aggregate(j$Jobs~j$Year + j$Area, FUN=sum))
colnames(jt) <- c("Year","Area","Jobs") 
jt$Year <- factor(jt$Year)

ggplot(jt, aes(x = Year, y = Jobs, group = Area, fill = factor(Area))) + 
     geom_histogram(stat="identity", color = "#000000",size=0.3) + 
     ylab("Job posts") +
      xlab("") +
      labs(title = desc) +
      theme_bw(base_size=14) +
      #    This can only handle 8 levels
      #scale_fill_colorblind(8) +
      #     This can only handle 13 levels
      scale_fill_carto_d(name = "Area: ", palette = "Safe") +
      theme(legend.title=element_blank(),legend.position = "right",
              panel.background = element_rect(fill = "white")) 
  

# Stacked, percentages 
ggplot(j, aes(x = factor(Year), y=  Jobs, fill = factor(Area))) + 
  geom_bar(position="fill", stat="identity",  size=0.3) + 
  ylab("Job posts percentage") +
  xlab("") +
  labs(title = desc) +
  theme_bw(base_size=14) +
  #    This can only handle 12 levels
  scale_fill_carto_d(name = "Area: ", palette = "Safe") +
  theme(legend.title=element_blank(),legend.position = "right",
        panel.background = element_rect(fill = "white")) 


# Line plot (not very legible)
ggplot(jt, aes(x = Year,y = Jobs, group = Area, color=Area)) + 
  geom_point(lwd = 2) + 
  geom_line() +
  labs(title = desc) +
  theme_bw() +
  #   This can only handle 12 levels
   scale_color_carto_d(name = "Area: ", palette = "Safe") +
  ylab("Job posts per area") 




# Last 12 years
j <- j %>% filter(Year >= (max(Year)-11))
jt <- as.data.frame(aggregate(j$Jobs~j$Area+j$Year, FUN=sum))
colnames(jt) <- c("Area","Year","Jobs") 


# Bar plot
ggplot(jt, aes(x = reorder(Area, Jobs),y = Jobs, group = Area, fill = factor(Area), color = factor(Area))) + 
  geom_histogram(stat="identity", color = "#000000",size=0.3) + 
  ylab("Job posts") +
  xlab("Areas") +
  labs(title = desc) +             
  theme_bw(base_size=14) +
  coord_flip() +
  facet_wrap( ~ Year) + 
  theme(legend.title=element_blank(),legend.position = "none",
        panel.background = element_rect(fill = "white")) 






# Order months
j$Month <- factor(j$Month, levels = month.abb)

head(j)

# Fuse variants into the same line
jm <- as.data.frame(aggregate(j$Jobs~j$Area + j$Month + j$Year, FUN=sum))
colnames(jm) <- c("Area","Month","Year","Jobs") 

jm <- jm[!(jm$Area %in% c("Forensic","Typology","Documentation","Acquisition")),]
jm <- jm %>% filter(Year > max(jm$Year) -6)


ggplot(jm, aes(x = Month, y = Jobs, group = Area, fill = factor(Area))) + 
  geom_histogram(stat="identity", color = "#000000",size=0.3) + 
  ylab("Job posts") +
  xlab("") +
  labs(title = paste(desc)) +
  theme_bw(base_size=14) +
  facet_wrap( ~ Year) + 
  scale_fill_carto_d(name = "Area: ", palette = "Safe") +
  theme(legend.title=element_blank(),legend.position = "right",
        panel.background = element_rect(fill = "white")) 


