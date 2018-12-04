library(dplyr)
library(coefplot)
library(ggthemes)

## @knitr initial-cfplot
#Linear Model2
updated_df<-readRDS("data/engineered-features.rds")
# factored_df$Attrition<-ifelse(factored_df$Attrition=="Yes", 1, 0)
# Make the Attrition Variable numeric so that we can do a model on it
updated_df$StandardHours<-NULL
updated_df$Over18<-NULL
updated_df$EmployeeNumber<-NULL

# Select Relevant Features to model
updated_df%>%
	select(Attrition,
		   OverTime,
		   MonthlyIncome,
		   JobRole,
		   Age,
		   DistanceFromHome,
		   BusinessTravel,
		   EnvironmentSatisfaction,
		   JobSatisfaction,
		   TotalWorkingYears,
		   DailyRate,
		   StockOptionLevel,
		   YearsAtCompany,
		   WorkLifeBalance,
		   IncLevels,
		   CompaRatioDep
		   )->df3
equ <-Attrition~.
model3<-lm(equ,data=df3)

# Model Summary
modsum<-(summary(model3))
names(model3$coefficients[-1])->nn

## @knitr updated-coef

# Coefficient Plot for updated model
cplot3<-coefplot(model3, intercept=FALSE,vertical=FALSE)+
	theme_few()+
	theme(text=element_text(size=8))
