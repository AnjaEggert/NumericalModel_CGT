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
                           "output.phi.din.fuc",
                           "output.phi.temp.fuc",
                           "output.phi.temp.graz.gam",
                           "output.mu.fuc",
                           "output.p.din.assim.fuc",
                           "output.resp.temp.fuc",
                           "output.p.fuc.resp.din",
                           "output.p.fuc.graz.gam",
                           "output.t.din",
                           "output.t.fuc",
                           "output.gam.abun"))

# convert elements of list to data frame, here tibble
dat  <-  as_tibble(matrix(unlist(mat.sub), nrow=length(unlist(mat.sub[1])))) %>%
  add_column(datetime$time) %>% 
  setNames(c("import.din",
             "export.din",
             "temperature",
             "light",
             "phi.din.fuc",
             "phi.temp.fuc",
             "phi.temp.graz.gam",
             "mu.fuc",
             "din.assim.fuc",
             "resp.temp.fuc",
             "fuc.resp.din",
             "fuc.graz.gam",
             "din",
             "fuc",
             "gam.abun",
             "time")) %>% 
  slice(-length(unlist(mat.sub[1])))

# look at data
dat

##---- save data ----

save(dat, file = "output.RData")
