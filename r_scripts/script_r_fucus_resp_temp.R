rm(list=ls())

normalizePath(readClipboard(),winslash = "/")

setwd("D:/Eggert/Documents/FBN/statistics_teaching/geomar_cgt/cgt_seminar_boxmodel/process_functions")

##---- libraries ----
library(ggplot2)

##---- parameters ----
# exp(log(0.0027)-log(2)/10*7)
# =0.001662045

r.0 = 0.0017 # respiration rate at T = 0°C
q10 = log(2)/10

##---- temperature dependence, van't Hoff's rule ----
x <- seq(0,30)
y <- r.0*(exp(q10*x))

df <- data.frame(x,y)

##---- Plot ----
Xlabel <- c(expression(paste("Temperature ", "[°C]")))
Ylabel <- c(expression(paste("Respiration rate ", "[", d^-1, "]")))

resp.ggplot<- ggplot(data=df, aes(x=x, y=y))+
  annotate("rect", xmin=13, xmax=19, ymin=-Inf, ymax=Inf, alpha=0.2, fill="yellow")+
  geom_line(size=1, colour='cornflowerblue') +
  geom_segment(aes(x = 7, y = 0, xend = 7, yend = r.0*(exp(q10*7))),linetype="dashed")+
  geom_segment(aes(x = 0, y = r.0*(exp(q10*7)), xend = 7, yend = r.0*(exp(q10*7))),linetype="dashed")+
  geom_point(aes(x=7, y=r.0*(exp(q10*7))), colour="red")+
  scale_x_continuous(limits=c(0,30), breaks=seq(5,25,by=5))+
  scale_y_continuous(limits=c(0,0.015),breaks=seq(0,0.015,by=.0015))+
  xlab(label= Xlabel) +
  ylab(label= Ylabel) +
  theme_bw() + # remove grey background
  theme(legend.position="none")+
  theme(legend.title = element_text(size = 12, colour = "black")) +
  theme(axis.title.x = element_text(face="bold", size=14), axis.text.x  = element_text(size=12, angle=0, vjust=0.5, hjust=1)) +
  theme(axis.title.y = element_text(face="bold", size=14), axis.text.y  = element_text(size=12))

resp.ggplot

png("./FIG/resp_temp.png", width = 13, height = 10, units = 'cm', res = 300)
resp.ggplot
dev.off()
