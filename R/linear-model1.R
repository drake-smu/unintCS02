library(pander)
library(ggplot2)
library(coefplot)
library(ggthemes)
library(dplyr)
factored_df<-readRDS("data/factored-definitions.rds")
# Load in Raw Dara
unfactor<-readRDS("data/hr-data.rds")
# make the attrition variable numeric
unfactor$Attrition<-ifelse(unfactor$Attrition=="Yes", 1, 2)
# Make the Attrition Variable numeric so that we can do a model on it
unfactor$StandardHours<-NULL
unfactor$Over18<-NULL
unfactor$EmployeeNumber<-NULL
equ <-Attrition~.
model1<-lm(equ,data=unfactor)
pander(summary(model1))
coefplot(model1, intercept=FALSE,vertical=FALSE)+theme_few()
