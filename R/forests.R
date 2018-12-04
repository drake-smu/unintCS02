library(ggthemes)
library(ggplot2)
library(randomForest)

set.seed(12345)

factored_df<-readRDS("data/factored-definitions.rds")

# Make the Attrition Variable numeric so that we can do a model on it
factored_df$StandardHours<-NULL
factored_df$Over18<-NULL
factored_df$EmployeeNumber<-NULL
equ <-Attrition~.
randomForest(equ,data=factored_df,importance=TRUE,
			 ntree=2000)->VariableImportance

featured<-readRDS("data/engineered-features.rds")
randomForest(equ,data=featured,importance=TRUE,
			 ntree=2000)->VariableImportance2

