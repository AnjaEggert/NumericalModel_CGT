rm(list=ls())

setwd("D:/Eggert/Documents/FBN/statistics_teaching/geomar_cgt/cgt_seminar_boxmodel/results")

##----Libraries----
library(R.matlab)
library(tidyverse)
library(ggplot2)
library(lubridate)

##---- Read in and prepare time data ----
mat.date <- readMat("datetime.mat")

datetime  <-  as_tibble(matrix(unlist(mat.date), nrow=length(unlist(mat.date[1])))) %>%
  setNames("time") %>%
  mutate(time =  dmy_hms(time))

str(datetime)

##----Read in and prepare data----
mat  <- readMat("output.mat")

# data is a list, i.e. a 'container' with different types of elements
str(mat)

# define function to get subset of relevant elements
subsetList <- function(myList, elementNames) {
  lapply(elementNames, FUN=function(x) myList[[x]])
}

# apply function to subset list
mat.sub<-subsetList(mat, c("output.p.import.din",
                           "output.p.export.din",
                           "output.temperature",
                           "output.light",
                           "output.phi.din.nfu",
                           "output.phi.temp.fuc",
                           "output.phi.temp.graz.gam",
                           "output.mu.fuc",
                           "output.p.din.assim.nfu",
                           "output.rm.nfu.din",
                           "output.p.nfu.resp.din",
                           "output.p.nfu.graz.gam",
                           "output.t.din",
                           "output.t.nfu",
                           "output.gam.abun"))

# convert elements of list to data frame, here tibble
dat  <-  as_tibble(matrix(unlist(mat.sub), nrow=length(unlist(mat.sub[1])))) %>%
  add_column(datetime$time) %>% 
  setNames(c("p.import.din",
           "p.export.din",
           "temperature",
           "light",
           "phi.din.nfu",
           "phi.temp.fuc",
           "phi.temp.graz.gam",
           "mu.fuc",
           "p.din.assim.nfu",
           "rm.nfu.din",
           "p.nfu.resp.din",
           "p.nfu.graz.gam",
           "t.din",
           "t.nfu",
           "gam.abun",
           "time"))

# look at data
dat



##---- Plot Fucus biomass ----

# conversion factors for Fucus
# 1 mol N Fucus = 775 g dm Fucus
# 1 mol N Fucus = 3953 g fm Fucus

conv.fuc.fm = 3953
conv.fuc.dm = 775

Xlabel <- c(expression(paste("2019")))
Ylabel <- c(expression(paste("Temperature ", "[°C]")))

temperature.ggplot<- ggplot(data=dat, aes(x=time, y=p.din.assim.nfu))+
  geom_line(colour ='cornflowerblue', size=1) +
  scale_x_datetime(breaks = "1 week", date_labels = "%b - %d")+
  scale_y_continuous(limits=c(10,20),breaks=seq(10,20,by=2))+
  xlab(label= Xlabel) +
  ylab(label= Ylabel) +
  theme_bw() + # remove grey background
  theme(legend.position="none")+
  theme(legend.title = element_text(size = 12, colour = "black")) +
  theme(axis.title.x = element_text(face="bold", size=14), axis.text.x  = element_text(size=12, angle=90)) +
  theme(axis.title.y = element_text(face="bold", size=14), axis.text.y  = element_text(size=12))

temperature.ggplot

png("./FIG/temperature.png", width = 13, height = 10, units = 'cm', res = 300)
temperature.ggplot
dev.off()
