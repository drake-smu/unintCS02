library(ggthemes)
library(ggplot2)
library(randomForest)
factored_df<-readRDS("data/factored-definitions.rds")
# factored_df$Attrition<-ifelse(factored_df$Attrition=="Yes", 1, 0)
# Make the Attrition Variable numeric so that we can do a model on it
factored_df$StandardHours<-NULL
factored_df$Over18<-NULL
factored_df$EmployeeNumber<-NULL
equ <-Attrition~.
randomForest(equ,data=factored_df,importance=TRUE,
			 ntree=2000)->VariableImportance
vimp<-varImpPlot(VariableImportance)

