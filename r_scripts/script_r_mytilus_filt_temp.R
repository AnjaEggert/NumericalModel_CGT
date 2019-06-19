rm(list=ls())

normalizePath(readClipboard(),winslash = "/")

setwd("D:/Eggert/Documents/FBN/statistics_teaching/geomar_cgt/cgt_seminar_boxmodel_Myt_Ast/process_functions")

##---- libraries ----
library(ggplot2)
library(xlsx)
library(tidyverse)
##---- read in data ----
dat<-read.xlsx("./data/partial_depend_filt_temp.xlsx", 1)

head(data)
#   Temperature..Â.C. Filtration.rate..ml.min..GAM.predict     X.025     X.975
# 1          16.80800                            0.2860529 0.2580956 0.3140103
# 2          16.95303                            0.2871417 0.2593314 0.3149520


dat <- dat[,c(1,2)] %>%
  setNames(c("temp","filt")) %>% 
  dplyr::filter(filt>0)
  

##---- Fitting quadratic regression with lm() ----
x <- dat$temp
y <- dat$filt

model <- lm(y ~ x + I(x^2))

summary(model)
# Call:
#   lm(formula = y ~ x + I(x^2))
# 
# Residuals:
#   Min        1Q    Median        3Q       Max 
# -0.054106 -0.007997  0.001509  0.007920  0.021753 
# 
# Coefficients:
#               Estimate Std. Error t value Pr(>|t|)    
# (Intercept) -1.9565161  0.1416460  -13.81   <2e-16 ***
# x            0.2366564  0.0135674   17.44   <2e-16 ***
# I(x^2)      -0.0061879  0.0003213  -19.26   <2e-16 ***
# ---
# Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
# 
# Residual standard error: 0.01403 on 57 degrees of freedom
# Multiple R-squared:  0.9635,	Adjusted R-squared:  0.9623 
# F-statistic: 753.1 on 2 and 57 DF,  p-value: < 2.2e-16

x.pred <- seq(5,28)
predicted.intervals <- predict(model,data.frame(x=x.pred),interval='confidence',
                               level=0.99)

df.pred <-tibble(x.pred,predicted.intervals[,1]) %>% 
  setNames(c("x.pred","y.pred")) %>% 
  dplyr::filter(y.pred>0)

##---- Plot of lm model ----
Xlabel <- c(expression(paste("Temperature ", "[°C]")))
Ylabel <- c(expression(paste("Filtration rate ", "[mg ", Ind^-1,d^-1, "]")))

stat <- as.character(expression(paste(X[0], "=-2.240, ", X[1], "=0.210, ", X[2], "=-0.007")))
stat1 <- as.character(expression(paste(f(T), "=", X[0]+X[1]*T+X[2]*T^2)))
ref <- as.character(expression(paste("Mytilus filtration rate")))

lm.ggplot<- ggplot(data=dat, aes(x=temp, y=filt))+
  annotate("rect", xmin=13, xmax=19, ymin=-Inf, ymax=Inf, alpha=0.2, fill="yellow")+
  geom_line(data=df.pred, aes(x=x.pred, y=y.pred), colour ='grey40', size=1) +
  geom_point(size=3, colour='blue') +
  scale_x_continuous(limits=c(13,26), breaks=seq(13,26,by=2))+
  scale_y_continuous(limits=c(0,0.31),breaks=seq(0,0.3,by=.05))+
  xlab(label= Xlabel) +
  ylab(label= Ylabel) +
  theme_bw() + # remove grey background
  theme(legend.position="none")+
  theme(legend.title = element_text(size = 12, colour = "black")) +
  theme(axis.title.x = element_text(face="bold", size=14), axis.text.x  = element_text(size=12, angle=0, vjust=0.5, hjust=1)) +
  theme(axis.title.y = element_text(face="bold", size=14), axis.text.y  = element_text(size=12)) +
  annotate("text", x = 0, y = 0, label = stat1, parse=TRUE,size = 4, hjust=0, fontface = 1, colour="grey40") +
  annotate("text", x = 0, y = .5, label = stat, parse=TRUE,size = 4, hjust=0, fontface = 1, colour="grey40") +
  annotate("text", x = 0, y = 5.0, label = ref, parse=TRUE,size = 4, hjust=0, fontface = 1, colour="grey40")

lm.ggplot

png("./FIG/myt_filt_temp.png", width = 13, height = 10, units = 'cm', res = 300)
lm.ggplot
dev.off()

##---- Plot of lm model, normalised plot ----
# X0, X1, X2 are divided by maximum (=0.3061161) 

df.pred$y.pred.norm <- df.pred$y.pred/max(df.pred$y.pred)

Xlabel <- c(expression(paste("Temperature ", "[°C]")))
Ylabel1 <- c(expression(paste(F[T])))

stat <- as.character(expression(paste(X[0], "=-6.391, ", X[1], "=0.773, ", X[2], "=-0.020")))
stat1 <- as.character(expression(paste(f(T), "=", X[0]+X[1]*T+X[2]*T^2)))
ref <- as.character(expression(paste("Mytilus filtration rate")))

lm.norm.ggplot<- ggplot(data=df.pred, aes(x=x.pred, y=y.pred.norm))+
  annotate("rect", xmin=13, xmax=19, ymin=-Inf, ymax=Inf, alpha=0.2, fill="yellow")+
  geom_line(colour ='blue', size=1) +
  scale_x_continuous(limits=c(13,26), breaks=seq(13,26,by=2))+
  scale_y_continuous(limits=c(0,1),breaks=seq(0,1,by=.1))+
  xlab(label= Xlabel) +
  ylab(label= Ylabel1) +
  theme_bw() + # remove grey background
  theme(legend.position="none")+
  theme(legend.title = element_text(size = 12, colour = "black")) +
  theme(axis.title.x = element_text(face="bold", size=14), axis.text.x  = element_text(size=12, angle=0, vjust=0.5, hjust=1)) +
  theme(axis.title.y = element_text(face="bold", size=14), axis.text.y  = element_text(size=12)) +
  annotate("text", x = 13, y = 0, label = stat1, parse=TRUE,size = 4, hjust=0, fontface = 1, colour="grey40") +
  annotate("text", x = 13, y = .1, label = stat, parse=TRUE,size = 4, hjust=0, fontface = 1, colour="grey40") +
  annotate("text", x = 13, y = 1.0, label = ref, parse=TRUE,size = 4, hjust=0, fontface = 1, colour="grey40")

lm.norm.ggplot

png("./FIG/myt_filt_temp_norm.png", width = 13, height = 10, units = 'cm', res = 300)
lm.norm.ggplot
dev.off()
