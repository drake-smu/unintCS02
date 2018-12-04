library(dplyr)
library(coefplot)
library(ggthemes)

## @knitr initial-cfplot
#Linear Model2
factored_df<-readRDS("data/factored-definitions.rds")

# Make the Attrition Variable numeric so that we can do a model on it
factored_df$StandardHours<-NULL
factored_df$Over18<-NULL
factored_df$EmployeeNumber<-NULL

# Select Relevant Features to model
factored_df%>%
	select(Attrition,
		   OverTime,
		   MonthlyIncome,
		   JobRole,
		   Age,
		   DistanceFromHome, BusinessTravel, EnvironmentSatisfaction,
		   JobSatisfaction,
		   TotalWorkingYears,
		   DailyRate,StockOptionLevel,
		   YearsAtCompany,WorkLifeBalance)->df2
equ <-Attrition~.
model2<-lm(equ,data=df2)

# Model Summary
modsum<-(summary(model2))
names(model2$coefficients[-1])->nn



## @knitr initial-coef
# Coefficient Plot for initial data
cplo2<-coefplot(model2, intercept=FALSE,vertical=FALSE)+
	theme_few()+
	theme(text=element_text(size=8))

