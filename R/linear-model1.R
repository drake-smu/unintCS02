library(pander)
library(ggplot2)
library(coefplot)
library(ggthemes)
library(dplyr)
factored_df<-readRDS("data/factored-definitions.rds")



# Make the Attrition Variable numeric so that we can do a model on it
factored_df$StandardHours<-NULL
factored_df$Over18<-NULL
factored_df$EmployeeNumber<-NULL
equ <-Attrition~.
model1<-lm(equ,data=factored_df)
pander(summary(model1))
coefplot(model1, intercept=FALSE,vertical=FALSE)+theme_few()
