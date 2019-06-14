rm(list=ls())

normalizePath(readClipboard(),winslash = "/")

setwd("D:/Eggert/Documents/FBN/statistics_teaching/geomar_cgt/cgt_seminar_boxmodel/process_functions")

# libraries
library(ggplot2)

###
# demonstration DIN limitation of Fucus

din<-seq(0,20,by=0.1)
km.fuc<-7.3
km.1  <-5
km.2  <-10

f.din.fuc<-din^2/(km.fuc^2+din^2)
f.din.1  <-din^2/(km.1^2+din^2)
f.din.2  <-din^2/(km.2^2+din^2)

nutr.df<-data.frame(din,f.din.fuc,f.din.1,f.din.2)

str(nutr.df)
# 'data.frame':	201 obs. of  2 variables:
#  $ din      : num  0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 ...
#  $ f.din.fuc: num  0 0.000188 0.00075 0.001686 0.002993 ...
#  $ f.din.1  : num  0 0.0004 0.0016 0.00359 0.00636 ...
#  $ f.din.2  : num  0 0.0001 0.0004 0.000899 0.001597 ...

Xlabel <- c(expression(paste("DIN ", "[", mu, "mol ", l^-1,"]")))
Ylabel <- c(expression(paste(F[DIN])))

lab.fuc <- as.character(expression(paste("Fucus: ", K[m], " = ", 7.3, " ", mu, "mol ", l^-1)))
lab.1   <- as.character(expression(paste(K[m], " = ", 5, " ", mu, "mol ", l^-1)))
lab.2   <- as.character(expression(paste(K[m], " = ", 10, " ", mu, "mol ", l^-1)))

nutr.ggplot<- ggplot(data=nutr.df, aes(x=din))+
  annotate("rect", xmin=0, xmax=5.2, ymin=-Inf, ymax=Inf, alpha=0.2, fill="yellow")+
  geom_line(aes(y=f.din.fuc), size=1, colour='cornflowerblue') +
  geom_line(aes(y=f.din.1), size=1, colour='orange',linetype="dashed") +
  geom_line(aes(y=f.din.2), size=1, colour='firebrick',linetype="dashed") +
  geom_hline(yintercept = 0.5, size = 1, linetype = "dotted")+
  scale_x_continuous(limits=c(0,20), breaks=seq(0,20,by=5))+
  scale_y_continuous(limits=c(0,1),breaks=seq(0,1,by=.1))+
  xlab(label= Xlabel) +
  ylab(label= Ylabel) +
  theme_bw() + # remove grey background
  theme(legend.position="none")+
  theme(legend.title = element_text(size = 14, colour = "black")) +
  theme(axis.title.x = element_text(face="bold", size=18), axis.text.x  = element_text(size=16, angle=0, vjust=0.5, hjust=1)) +
  theme(axis.title.y = element_text(face="bold", size=18), axis.text.y  = element_text(size=16))+
  annotate("text", x = 20, y = 0.2, label = lab.fuc, parse=TRUE,size = 4, hjust=1, fontface = 1, colour="cornflowerblue")+
  annotate("text", x = 20, y = 0.1, label = lab.1, parse=TRUE,size = 4, hjust=1, fontface = 1, colour="orange")+
  annotate("text", x = 20, y = 0.0, label = lab.2, parse=TRUE,size = 4, hjust=1, fontface = 1, colour="firebrick")

nutr.ggplot

png("./FIG/nutr_Fdin.png", width = 13, height = 10, units = 'cm', res = 300)
nutr.ggplot
dev.off()
