# Clear memory buffer
rm(list=ls())

# Load libraries
library(ggplot2)
library(ggthemes)
library(rcartocolor)
library(dplyr)

# Load data
j <- read.delim("jobs.csv", sep = ",")


#levels(j$Area)
# Normalize area names ("Comp Ling" / "Computational Linguistics" / "Natural Language Processing")
levels(j$Area)[1] <- "CompLing"
levels(j$Area)[2] <- "CompLing"
levels(j$Area)[6] <- "CompLing"

# A(c)quisition
levels(j$Area)[11] <- "Acquisition"

# Socio
levels(j$Area)[13] <- "SocioLing"


#########################################################################################
# Overall jobs by area, regardless of year

jto <- as.data.frame(aggregate(j$Jobs~j$Area, FUN=sum))
colnames(jto) <- c("Area","Jobs") 

# View table
jto %>% arrange(-Jobs)

# Sort by Area
jto$Area = with(jto, reorder(Area,-Jobs,sum))

# Plot description
desc <- "Job postings at https://linguistlist.org"

# Bar plot
ggplot(jto, aes(x = Area,y = Jobs, group = Area, fill = factor(Area))) + 
  geom_histogram(stat="identity", color = "#000000",size=0.3) + 
  ylab("Job posts") +
  labs(title = desc) +             
  theme_bw(base_size=14) +
  theme(legend.title=element_blank(),legend.position = "none",
        panel.background = element_rect(fill = "white")) 

# Pie plot  (WCAG package can't be used because it only handles up to 12 colors)
ggplot(jto, aes(x="", y=Jobs, fill=Area)) +
  theme_bw(base_size=14) +
#  scale_fill_carto_d(name = "Area: ", palette = "Safe") +
  geom_bar(width = 1, stat = "identity") +
  coord_polar("y", start=0) +
  theme(axis.title.y=element_blank(), axis.text.y=element_blank(), axis.ticks.y=element_blank()) 



################################################################
# To improve plot legibility (WCAG package can't handle more than 12 colors), some areas can be are removed


# Forensic, Typology, and Documentation have the lowest overall counts ( < 70 )
j <- j[!(j$Area %in% c("Forensic","Typology","Documentation","Acquisition")),]

j$Area <- factor(j$Area) 


#########################################################################
# Factor year

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
