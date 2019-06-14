rm(list=ls())

normalizePath(readClipboard(),winslash = "/")

setwd("D:/Eggert/Documents/FBN/statistics_teaching/geomar_cgt/cgt_seminar_boxmodel/process_functions")

##---- libraries ----
library(ggplot2)

##---- read in and edit data ----
# Data from Master thesis Elisa Guelzow

gam<-read.csv("./data/grazing_temp_gammarus.csv", header=T, sep=",")

gam$grazing_dw<-gam$grazing_squares/gam$dw_mg

str(gam)
# 'data.frame':	32 obs. of  8 variables:
# $ basin          : Factor w/ 9 levels "A-5","B-10","C-12",..: 1 1 1 1 2 2 2 2 3 3 ...
# $ temp           : int  5 5 5 5 10 10 10 10 12 12 ...
# $ ind            : Factor w/ 32 levels "A.1","A.3","A.4",..: 1 2 3 4 5 6 7 8 9 10 ...
# $ length_mm      : int  10 27 19 13 25 21 22 18 24 25 ...
# $ dw_mg          : num  5.42 62.26 20.19 7.85 39.66 ...
# $ faeces_mg      : num  0 19.34 5.72 4.14 10.08 ...
# $ grazing_squares: int  0 17 0 0 4 8 14 1 6 14 ...
# $ grazing_dw     : num  0 0.273 0 0 0.101 ...

##---- Fitting quadratic regression with lm() ----
y <- gam$grazing_dw
x <- gam$temp

model <- lm(y ~ x + I(x^2))

summary(model)
# Call:
#   lm(formula = y ~ x + I(x^2))
# 
# Residuals:
#   Min      1Q  Median      3Q     Max 
# -0.6911 -0.4110 -0.2185  0.1604  1.4371 
# 
# Coefficients:
#              Estimate Std. Error t value Pr(>|t|)  
# (Intercept) -1.009278   0.608938  -1.657   0.1082  
# x            0.198033   0.084335   2.348   0.0259 *
# I(x^2)      -0.005651   0.002583  -2.187   0.0369 *
# ---
# Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
# 
# Residual standard error: 0.6176 on 29 degrees of freedom
# Multiple R-squared:  0.1696,	Adjusted R-squared:  0.1123 
# F-statistic: 2.961 on 2 and 29 DF,  p-value: 0.06756

x.pred <- seq(5,27)
predicted.intervals <- predict(model,data.frame(x=x.pred),interval='confidence',
                               level=0.99)

df.pred <-data.frame(x.pred,predicted.intervals[,1])
colnames(df.pred)<-c("x.pred","y.pred")

##---- plotting data ----
Xlabel <- c(expression(paste("Temperature ", "[°C]")))
Ylabel <- c(expression(paste("Grazing (empty squares) ", "[# mg ", Ind.^-1, "]")))

stat <- as.character(expression(paste(X[0], "=-1.009, ", X[1], "=0.198, ", X[2], "=-0.006")))
stat1 <- as.character(expression(paste(f(T), "=", X[0]+X[1]*T+X[2]*T^2)))
ref <- as.character(expression(paste("Gülzow 2015, master thesis")))

Graz.gam.lm.ggplot<- ggplot(data=gam, aes(x=temp, y=grazing_dw))+
  annotate("rect", xmin=13, xmax=19, ymin=-Inf, ymax=Inf, alpha=0.2, fill="yellow")+
  geom_line(data=df.pred, aes(x=x.pred, y=y.pred), colour ='blue', size=1) +
  geom_point(size=2, colour='grey40') +
  scale_x_continuous(limits=c(5,30), breaks=seq(5,30,by=5))+
  scale_y_continuous(limits=c(0,2.2),breaks=seq(0,2.2,by=.2))+
  xlab(label= Xlabel) +
  ylab(label= Ylabel) +
  theme_bw() + # remove grey background
  theme(legend.position="none")+
  theme(legend.title = element_text(size = 12, colour = "black")) +
  theme(axis.title.x = element_text(face="bold", size=14), axis.text.x  = element_text(size=12, angle=0, vjust=0.5, hjust=1)) +
  theme(axis.title.y = element_text(face="bold", size=14), axis.text.y  = element_text(size=12)) +
  annotate("text", x = 5, y = 1.8, label = stat1, parse=TRUE,size = 4, hjust=0, fontface = 1, colour="grey40") +
  annotate("text", x = 5, y = 2.0, label = stat, parse=TRUE,size = 4, hjust=0, fontface = 1, colour="grey40") +
  annotate("text", x = 5, y = 2.2, label = ref, parse=TRUE,size = 4, hjust=0, fontface = 1, colour="grey40")

Graz.gam.lm.ggplot

png("./FIG/grazing_temp_gam_lm.png", width = 13, height = 10, units = 'cm', res = 300)
Graz.gam.lm.ggplot
dev.off()

##---- Plot of lm model, normalised plot ----
# X0, X1, X2 are divided by maximum (=4.647327) 

df.pred$y.pred.norm <- df.pred$y.pred/max(df.pred$y.pred)

Xlabel <- c(expression(paste("Temperature ", "[°C]")))
Ylabel1 <- c(expression(paste(F[T])))

stat <- as.character(expression(paste(X[0], "=-1.393, ", X[1], "=0.273, ", X[2], "=-0.008")))
stat1 <- as.character(expression(paste(f(T), "=", X[0]+X[1]*T+X[2]*T^2)))
ref <- as.character(expression(paste("Gülzow 2015, master thesis")))

Graz.gam.lm.norm.ggplot<- ggplot(data=df.pred, aes(x=x.pred, y=y.pred.norm))+
  annotate("rect", xmin=13, xmax=19, ymin=-Inf, ymax=Inf, alpha=0.2, fill="yellow")+
  geom_line(colour ='blue', size=1) +
  scale_x_continuous(limits=c(5,30), breaks=seq(5,30,by=5))+
  scale_y_continuous(limits=c(0,1),breaks=seq(0,1,by=.1))+
  xlab(label= Xlabel) +
  ylab(label= Ylabel1) +
  theme_bw() + # remove grey background
  theme(legend.position="none")+
  theme(legend.title = element_text(size = 12, colour = "black")) +
  theme(axis.title.x = element_text(face="bold", size=14), axis.text.x  = element_text(size=12, angle=0, vjust=0.5, hjust=1)) +
  theme(axis.title.y = element_text(face="bold", size=14), axis.text.y  = element_text(size=12)) +
  annotate("text", x = 5, y = 0, label = stat1, parse=TRUE,size = 4, hjust=0, fontface = 1, colour="grey40") +
  annotate("text", x = 5, y = .1, label = stat, parse=TRUE,size = 4, hjust=0, fontface = 1, colour="grey40") +
  annotate("text", x = 5, y = 1.0, label = ref, parse=TRUE,size = 4, hjust=0, fontface = 1, colour="grey40")

Graz.gam.lm.norm.ggplot

png("./FIG/grazing_temp_gam_lm_norm.png", width = 13, height = 10, units = 'cm', res = 300)
Graz.gam.lm.norm.ggplot
dev.off()
