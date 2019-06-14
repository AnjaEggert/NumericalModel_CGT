# Fitting Blanchard-model to growth-temperature data of Fucus
# Graiff et al. 2015

rm(list=ls())

normalizePath(readClipboard(),winslash = "/")

setwd("D:/Eggert/Documents/FBN/statistics_teaching/geomar_cgt/cgt_seminar_boxmodel/process_functions")

##---- libraries ----
library(ggplot2)

##---- read in data ----
data<-read.csv("./data/fucus_rgr_temp_graiff2015.csv", header=T)

head(data)
#   temp    length     mass
# 1    5  6.843095 2.744746
# 2    5  6.663333 2.852588
# 3    5  7.144167 2.499455
# 4    5  7.166071 2.274112
# 5   10 10.656786 3.848346
# 6   10 11.594048 4.035224

# only include positive values
data.sub <- data[1:28,]
plot(data.sub$temp,data.sub$mass)

##---- Fitting quadratic regression with lm() ----
y <- data.sub$mass
x <- data.sub$temp

model <- lm(y ~ x + I(x^2))

summary(model)
# Call:
#   lm(formula = y ~ x + I(x^2))
# 
# Residuals:
#   Min       1Q   Median       3Q      Max 
# -0.87075 -0.21301  0.06744  0.22171  0.69245 
# 
# Coefficients:
#              Estimate Std. Error t value Pr(>|t|)    
# (Intercept) -0.328478   0.359775  -0.913     0.37    
# x            0.661463   0.050835  13.012 1.24e-12 ***
# I(x^2)      -0.021983   0.001522 -14.440 1.23e-13 ***
#   ---
#   Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
# 
# Residual standard error: 0.3667 on 25 degrees of freedom
# Multiple R-squared:  0.9111,	Adjusted R-squared:  0.904 
# F-statistic: 128.1 on 2 and 25 DF,  p-value: 7.248e-14

confint(model, level=0.95)
#                   2.5 %     97.5 %
# (Intercept) -1.06944843  0.4124923
# x            0.55676688  0.7661590
# I(x^2)      -0.02511819 -0.0188475

x.pred <- seq(5,27)
predicted.intervals <- predict(model,data.frame(x=x.pred),interval='confidence',
                               level=0.99)

df.pred <-data.frame(x.pred,predicted.intervals[,1])
colnames(df.pred)<-c("x.pred","y.pred")

##---- Plot of lm model ----
Xlabel <- c(expression(paste("Temperature ", "[°C]")))
Ylabel <- c(expression(paste("Biomass growth rate ", "[% ", d^-1, "]")))

stat <- as.character(expression(paste(X[0], "=-0.329, ", X[1], "=0.662, ", X[2], "=-0.022")))
stat1 <- as.character(expression(paste(f(T), "=", X[0]+X[1]*T+X[2]*T^2)))
ref <- as.character(expression(paste("Graiff et al. 2015")))

lm.ggplot<- ggplot(data=data.sub, aes(x=temp, y=mass))+
  annotate("rect", xmin=13, xmax=19, ymin=-Inf, ymax=Inf, alpha=0.2, fill="yellow")+
  geom_line(data=df.pred, aes(x=x.pred, y=y.pred), colour ='grey40', size=1) +
  geom_point(size=3, colour='blue') +
  scale_x_continuous(limits=c(0,30), breaks=seq(5,25,by=5))+
  scale_y_continuous(limits=c(0,5.1),breaks=seq(0,5,by=.5))+
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

png("./FIG/growth_temp_lm.png", width = 13, height = 10, units = 'cm', res = 300)
lm.ggplot
dev.off()

##---- Plot of lm model, normalised plot ----
# X0, X1, X2 are divided by maximum (=4.647327) 

df.pred$y.pred.norm <- df.pred$y.pred/max(df.pred$y.pred)

Xlabel <- c(expression(paste("Temperature ", "[°C]")))
Ylabel1 <- c(expression(paste(F[T])))

stat <- as.character(expression(paste(X[0], "=-0.071, ", X[1], "=0.143, ", X[2], "=-0.005")))
stat1 <- as.character(expression(paste(f(T), "=", X[0]+X[1]*T+X[2]*T^2)))
ref <- as.character(expression(paste("Graiff et al. 2015")))

lm.norm.ggplot<- ggplot(data=df.pred, aes(x=x.pred, y=y.pred.norm))+
  annotate("rect", xmin=13, xmax=19, ymin=-Inf, ymax=Inf, alpha=0.2, fill="yellow")+
  geom_line(colour ='blue', size=1) +
  scale_x_continuous(limits=c(0,30), breaks=seq(5,25,by=5))+
  scale_y_continuous(limits=c(0,1),breaks=seq(0,1,by=.1))+
  xlab(label= Xlabel) +
  ylab(label= Ylabel1) +
  theme_bw() + # remove grey background
  theme(legend.position="none")+
  theme(legend.title = element_text(size = 12, colour = "black")) +
  theme(axis.title.x = element_text(face="bold", size=14), axis.text.x  = element_text(size=12, angle=0, vjust=0.5, hjust=1)) +
  theme(axis.title.y = element_text(face="bold", size=14), axis.text.y  = element_text(size=12)) +
  annotate("text", x = 0, y = 0, label = stat1, parse=TRUE,size = 4, hjust=0, fontface = 1, colour="grey40") +
  annotate("text", x = 0, y = .1, label = stat, parse=TRUE,size = 4, hjust=0, fontface = 1, colour="grey40") +
  annotate("text", x = 0, y = 1.0, label = ref, parse=TRUE,size = 4, hjust=0, fontface = 1, colour="grey40")

lm.norm.ggplot

png("./FIG/growth_temp_norm_lm.png", width = 13, height = 10, units = 'cm', res = 300)
lm.norm.ggplot
dev.off()
