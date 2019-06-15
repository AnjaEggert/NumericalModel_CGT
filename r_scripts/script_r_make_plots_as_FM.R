rm(list=ls())

setwd("D:/Eggert/Documents/FBN/statistics_teaching/geomar_cgt/cgt_seminar_boxmodel/results")

##----Libraries----
library(ggplot2)

##---- load data ----
load ("output.RData")

names(dat)
#  [1] "import.din"        "export.din"        "temperature"       "light"            
#  [5] "phi.din.fuc"       "phi.temp.fuc"      "phi.temp.graz.gam" "mu.fuc"           
#  [9] "din.assim.fuc"     "resp.temp.fuc"     "fuc.resp.din"      "fuc.graz.gam"     
# [13] "din"               "fuc"               "gam.abun"          "time"             

##---- Conversion factors for Fucus ----

# 1 mol N Fucus = 775 g dm Fucus
# 1 mol N Fucus = 4000 g fm Fucus

conv.fuc.fm = 4000
conv.fuc.dm = 775

##---- Plot Fucus as fresh biomass ----
Xlabel <- c(expression(paste("2019")))
Ylabel <- c(expression(paste(italic(Fucus), " as FM [g ", l^-1,"]")))

fucus.fm.ggplot<- ggplot(data=dat, aes(x=time, y=fuc*conv.fuc.fm))+
  geom_line(colour ='cornflowerblue', size=1) +
  scale_x_datetime(breaks = "1 week", date_labels = "%b - %d")+
  scale_y_continuous(limits=c(707,802),breaks=seq(707,802,by=10))+
  xlab(label= Xlabel) +
  ylab(label= Ylabel) +
  theme_bw() + # remove grey background
  theme(legend.position="none")+
  theme(legend.title = element_text(size = 12, colour = "black")) +
  theme(axis.title.x = element_text(face="bold", size=14), axis.text.x  = element_text(size=12, angle=90)) +
  theme(axis.title.y = element_text(face="bold", size=14), axis.text.y  = element_text(size=12))

fucus.fm.ggplot

png("./FIG/fucus_fm.png", width = 13, height = 10, units = 'cm', res = 300)
fucus.fm.ggplot
dev.off()

##---- Plot Gammarus grazing as fresh biomass ----
Xlabel <- c(expression(paste("2019")))
Ylabel <- c(expression(paste("Grazing as FM [mg ", Ind^-1, d^-1,"]")))

gam.graz.fm.ggplot<- ggplot(data=dat, aes(x=time, y=fuc.graz.gam*conv.fuc.fm*1000/500))+
  geom_line(colour ='cornflowerblue', size=1) +
  scale_x_datetime(breaks = "1 week", date_labels = "%b - %d")+
  scale_y_continuous(limits=c(11.8,14.1),breaks=seq(11.8,14.1,by=0.5))+
  xlab(label= Xlabel) +
  ylab(label= Ylabel) +
  theme_bw() + # remove grey background
  theme(legend.position="none")+
  theme(legend.title = element_text(size = 12, colour = "black")) +
  theme(axis.title.x = element_text(face="bold", size=14), axis.text.x  = element_text(size=12, angle=90)) +
  theme(axis.title.y = element_text(face="bold", size=14), axis.text.y  = element_text(size=12))

gam.graz.fm.ggplot

png("./FIG/gam_graz_fm.png", width = 13, height = 10, units = 'cm', res = 300)
gam.graz.fm.ggplot
dev.off()
