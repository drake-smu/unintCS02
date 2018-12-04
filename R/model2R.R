library(dplyr)
library(coefplot)
library(ggthemes)
#Linear Model2
factored_df<-readRDS("data/factored-definitions.rds")
# Make the Attrition Variable numeric so that we can do a model on it
factored_df$StandardHours<-NULL
factored_df$Over18<-NULL
factored_df$EmployeeNumber<-NULL
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
modsum<-(summary(model2))
names(model2$coefficients[-1])->nn
cplo2<-coefplot(model2, intercept=FALSE,vertical=FALSE)+theme_few()+theme(text=element_text(size=8))

featured_df<-readRDS("data/engineered-features.rds")
featured_df%>%
	select(Attrition,
		   OverTime,
		   IncLevels,
		   JobLevel,
		  BusinessTravel, EnvironmentSatisfaction,
StockOptionLevel,
	WorkLifeBalance,CompaRatioDep)->df3
model3<-lm(equ,data=df3)
cplo3<-coefplot(model3,intercept=F)
