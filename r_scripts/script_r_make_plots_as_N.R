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

##---- Plot Fucus as N ----
Xlabel <- c(expression(paste("2019")))
Ylabel <- c(expression(paste(italic(Fucus), " as N [", mu, "mol ", l^-1,"]")))

fucus.n.ggplot<- ggplot(data=dat, aes(x=time, y=fuc*1e3))+
  geom_line(colour ='cornflowerblue', size=1) +
  scale_x_datetime(breaks = "1 week", date_labels = "%b - %d")+
  scale_y_continuous(limits=c(176,201),
                     breaks=seq(176,201,by=5))+
  xlab(label= Xlabel) +
  ylab(label= Ylabel) +
  theme_bw() + # remove grey background
  theme(legend.position="none")+
  theme(legend.title = element_text(size = 12, colour = "black")) +
  theme(axis.title.x = element_text(face="bold", size=14), axis.text.x  = element_text(size=12, angle=90)) +
  theme(axis.title.y = element_text(face="bold", size=14), axis.text.y  = element_text(size=12))

fucus.n.ggplot

png("./FIG/fucus_n.png", width = 13, height = 10, units = 'cm', res = 300)
fucus.n.ggplot
dev.off()

##---- Plot DIN ----
Xlabel <- c(expression(paste("2019")))
Ylabel <- c(expression(paste("DIN [", mu, "mol ", l^-1,"]")))

din.ggplot<- ggplot(data=dat, aes(x=time, y=din*1e3))+
  geom_line(colour ='cornflowerblue', size=1) +
  scale_x_datetime(breaks = "1 week", date_labels = "%b - %d")+
  scale_y_continuous(limits=c(0,0.9),breaks=seq(0,0.9,by=.2))+
  xlab(label= Xlabel) +
  ylab(label= Ylabel) +
  theme_bw() + # remove grey background
  theme(legend.position="none")+
  theme(legend.title = element_text(size = 12, colour = "black")) +
  theme(axis.title.x = element_text(face="bold", size=14), axis.text.x  = element_text(size=12, angle=90)) +
  theme(axis.title.y = element_text(face="bold", size=14), axis.text.y  = element_text(size=12))

din.ggplot

png("./FIG/din.png", width = 13, height = 10, units = 'cm', res = 300)
din.ggplot
dev.off()

##---- Plot DIN assimilation of Fucus ----
Xlabel <- c(expression(paste("2019")))
Ylabel <- c(expression(paste("DIN assimilation [", mu, "mol ", l^-1, d^-1,"]")))

din.assim.fuc.ggplot<- ggplot(data=dat, aes(x=time, y=din.assim.fuc*1e3))+
  geom_line(colour ='cornflowerblue', size=1) +
  scale_x_datetime(breaks = "1 week", date_labels = "%b - %d")+
  scale_y_continuous(limits=c(0,7.5),breaks=seq(0,7.5,by=2))+
  xlab(label= Xlabel) +
  ylab(label= Ylabel) +
  theme_bw() + # remove grey background
  theme(legend.position="none")+
  theme(legend.title = element_text(size = 12, colour = "black")) +
  theme(axis.title.x = element_text(face="bold", size=14), axis.text.x  = element_text(size=12, angle=90)) +
  theme(axis.title.y = element_text(face="bold", size=14), axis.text.y  = element_text(size=12))

din.assim.fuc.ggplot

png("./FIG/din_assim_fuc.png", width = 13, height = 10, units = 'cm', res = 300)
din.assim.fuc.ggplot
dev.off()

##---- Plot respiration of Fucus ----
Xlabel <- c(expression(paste("2019")))
Ylabel <- c(expression(paste("Respiration Fucus [", mu, "mol ", l^-1, d^-1,"]")))

resp.fuc.ggplot<- ggplot(data=dat, aes(x=time, y=fuc.resp.din*1e3))+
  geom_line(colour ='cornflowerblue', size=1) +
  scale_x_datetime(breaks = "1 week", date_labels = "%b - %d")+
  scale_y_continuous(limits=c(0.8,1.2),breaks=seq(0.8,1.2,by=.1))+
  xlab(label= Xlabel) +
  ylab(label= Ylabel) +
  theme_bw() + # remove grey background
  theme(legend.position="none")+
  theme(legend.title = element_text(size = 12, colour = "black")) +
  theme(axis.title.x = element_text(face="bold", size=14), axis.text.x  = element_text(size=12, angle=90)) +
  theme(axis.title.y = element_text(face="bold", size=14), axis.text.y  = element_text(size=12))

resp.fuc.ggplot

png("./FIG/resp_fuc.png", width = 13, height = 10, units = 'cm', res = 300)
resp.fuc.ggplot
dev.off()

##---- Plot grazing Gammarus ----
Xlabel <- c(expression(paste("2019")))
Ylabel <- c(expression(paste("Grazing Gammarus [", mu, "mol ", l^-1, d^-1,"]")))

graz.gam.ggplot<- ggplot(data=dat, aes(x=time, y=fuc.graz.gam*1e3))+
  geom_line(colour ='cornflowerblue', size=1) +
  scale_x_datetime(breaks = "1 week", date_labels = "%b - %d")+
  scale_y_continuous(limits=c(1.47,1.76),breaks=seq(1.47,1.76,by=.05))+
  xlab(label= Xlabel) +
  ylab(label= Ylabel) +
  theme_bw() + # remove grey background
  theme(legend.position="none")+
  theme(legend.title = element_text(size = 12, colour = "black")) +
  theme(axis.title.x = element_text(face="bold", size=14), axis.text.x  = element_text(size=12, angle=90)) +
  theme(axis.title.y = element_text(face="bold", size=14), axis.text.y  = element_text(size=12))

graz.gam.ggplot

png("./FIG/graz_gam.png", width = 13, height = 10, units = 'cm', res = 300)
graz.gam.ggplot
dev.off()

##---- Plot DIN import ----
Xlabel <- c(expression(paste("2019")))
Ylabel <- c(expression(paste("DIN import [", mu, "mol ", l^-1, d^-1,"]")))

din.imp.ggplot<- ggplot(data=dat, aes(x=time, y=import.din*1e3))+
  geom_line(colour ='cornflowerblue', size=1) +
  scale_x_datetime(breaks = "1 week", date_labels = "%b - %d")+
  scale_y_continuous(limits=c(0,0.63),breaks=seq(0,0.63,by=.1))+
  xlab(label= Xlabel) +
  ylab(label= Ylabel) +
  theme_bw() + # remove grey background
  theme(legend.position="none")+
  theme(legend.title = element_text(size = 12, colour = "black")) +
  theme(axis.title.x = element_text(face="bold", size=14), axis.text.x  = element_text(size=12, angle=90)) +
  theme(axis.title.y = element_text(face="bold", size=14), axis.text.y  = element_text(size=12))

din.imp.ggplot

png("./FIG/din_imp.png", width = 13, height = 10, units = 'cm', res = 300)
din.imp.ggplot
dev.off()

##---- Plot DIN export ----
Xlabel <- c(expression(paste("2019")))
Ylabel <- c(expression(paste("DIN export [", mu, "mol ", l^-1, d^-1,"]")))

din.exp.ggplot<- ggplot(data=dat, aes(x=time, y=export.din*1e3))+
  geom_line(colour ='cornflowerblue', size=1) +
  scale_x_datetime(breaks = "1 week", date_labels = "%b - %d")+
  scale_y_continuous(limits=c(0,1),breaks=seq(0,1,by=.2))+
  xlab(label= Xlabel) +
  ylab(label= Ylabel) +
  theme_bw() + # remove grey background
  theme(legend.position="none")+
  theme(legend.title = element_text(size = 12, colour = "black")) +
  theme(axis.title.x = element_text(face="bold", size=14), axis.text.x  = element_text(size=12, angle=90)) +
  theme(axis.title.y = element_text(face="bold", size=14), axis.text.y  = element_text(size=12))

din.exp.ggplot

png("./FIG/din_exp.png", width = 13, height = 10, units = 'cm', res = 300)
din.exp.ggplot
dev.off()

##---- F_T Fucus ----
Xlabel <- c(expression(paste("2019")))
Ylabel <- c(expression(paste(F[T], " Fucus [0, 1]")))

ft.fuc.ggplot<- ggplot(data=dat, aes(x=time, y=phi.temp.fuc))+
  geom_line(colour ='cornflowerblue', size=1) +
  scale_x_datetime(breaks = "1 week", date_labels = "%b - %d")+
  scale_y_continuous(limits=c(0,1),breaks=seq(0,1,by=.2))+
  xlab(label= Xlabel) +
  ylab(label= Ylabel) +
  theme_bw() + # remove grey background
  theme(legend.position="none")+
  theme(legend.title = element_text(size = 12, colour = "black")) +
  theme(axis.title.x = element_text(face="bold", size=14), axis.text.x  = element_text(size=12, angle=90)) +
  theme(axis.title.y = element_text(face="bold", size=14), axis.text.y  = element_text(size=12))

ft.fuc.ggplot

png("./FIG/ft_fuc.png", width = 13, height = 10, units = 'cm', res = 300)
ft.fuc.ggplot
dev.off()

##---- F_T Gammarus ----
Xlabel <- c(expression(paste("2019")))
Ylabel <- c(expression(paste(F[T], " Gammarus grazing [0, 1]")))

ft.graz.gam.ggplot<- ggplot(data=dat, aes(x=time, y=phi.temp.graz.gam))+
  geom_line(colour ='cornflowerblue', size=1) +
  scale_x_datetime(breaks = "1 week", date_labels = "%b - %d")+
  scale_y_continuous(limits=c(0,1),breaks=seq(0,1,by=.2))+
  xlab(label= Xlabel) +
  ylab(label= Ylabel) +
  theme_bw() + # remove grey background
  theme(legend.position="none")+
  theme(legend.title = element_text(size = 12, colour = "black")) +
  theme(axis.title.x = element_text(face="bold", size=14), axis.text.x  = element_text(size=12, angle=90)) +
  theme(axis.title.y = element_text(face="bold", size=14), axis.text.y  = element_text(size=12))

ft.graz.gam.ggplot

png("./FIG/ft_graz_gam.png", width = 13, height = 10, units = 'cm', res = 300)
ft.graz.gam.ggplot
dev.off()

##---- F_DIN Fucus ----
Xlabel <- c(expression(paste("2019")))
Ylabel <- c(expression(paste(F[DIN], " Fucus [0, 1]")))

fdin.fuc.ggplot<- ggplot(data=dat, aes(x=time, y=phi.din.fuc))+
  geom_line(colour ='cornflowerblue', size=1) +
  scale_x_datetime(breaks = "1 week", date_labels = "%b - %d")+
  scale_y_continuous(limits=c(0,1),breaks=seq(0,1,by=.2))+
  xlab(label= Xlabel) +
  ylab(label= Ylabel) +
  theme_bw() + # remove grey background
  theme(legend.position="none")+
  theme(legend.title = element_text(size = 12, colour = "black")) +
  theme(axis.title.x = element_text(face="bold", size=14), axis.text.x  = element_text(size=12, angle=90)) +
  theme(axis.title.y = element_text(face="bold", size=14), axis.text.y  = element_text(size=12))

fdin.fuc.ggplot

png("./FIG/fdin_fuc.png", width = 13, height = 10, units = 'cm', res = 300)
fdin.fuc.ggplot
dev.off()
