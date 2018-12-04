library(ggthemes)
library(ggplot2)
library(randomForest)
model_df<-readRDS("data/engineered-features.rds")


## @knitr updated-forest
# Make the Attrition Variable numeric so that we can do a model on it
model_df$StandardHours<-NULL
model_df$Over18<-NULL
model_df$EmployeeNumber<-NULL
equ <-Attrition~.
randomForest(equ,data=model_df,importance=TRUE,
			 ntree=2000)->VariableImportance2

## @knitr initial-varImp
vimp2<-varImpPlot(VariableImportance2)
# saveRDS(vimp, file = "data/chunk-outputs/vimp1.rds")
