library(pander)
library(ggplot2)
library(coefplot)
library(ggthemes)
library(dplyr)


factored_df<-readRDS("data/engineered-features.rds")



# Make the Attrition Variable numeric so that we can do a model on it
factored_df$StandardHours<-NULL
factored_df$Over18<-NULL
factored_df$EmployeeNumber<-NULL
test_df <- factored_df %>%
	mutate(
		Age = NULL,
		DailyRate= NULL,
		Department=NULL,
		DistanceFromHome=NULL,
		Education= NULL,
		# EducationField=NULL,
		Gender= NULL,
		JobRole=NULL,
		HourlyRate= NULL,
		MaritalStatus= NULL,
		MonthlyRate= NULL,
		MonthlyIncome= NULL,
		NumCompaniesWorked=NULL,
		PercentSalaryHike= NULL,
		PerformanceRating= NULL,
		TotalWorkingYears=NULL,
		TrainingTimesLastYear=NULL,
		YearsAtCompany=NULL,
		YearsInCurrentRole=NULL,
		YearsWithCurrManager=NULL,
		YearsSinceLastPromotion=NULL
	);

shot_inDark <- function(x){
	if(x==0) x <- x+1;

	return (log10(x))
}


factored_df <-  factored_df %>%
	mutate_if(is.numeric , shot_inDark)

equ <-Attrition~.
model1<-lm(equ,data=factored_df)
pander(summary(model1))

# coefplot(model1, intercept=FALSE,vertical=FALSE)+theme_few()

model2<-lm(equ,data=test_df)
pander(summary(model2))
# coefplot(model2, intercept=FALSE,vertical=FALSE)+theme_few()


Training_cor <- factored_df;

Training_cor <- Training_cor %>%
	mutate(
		Attrition=factor(Attrition,labels = c("No", "Yes"))
	)

for(i in 1:ncol(Training_cor)){

	Training_cor[,i]<- as.integer(Training_cor[,i])
}

corrplot(cor(Training_cor))

