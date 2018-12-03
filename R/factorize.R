library(readxl);
library(tidyverse);

hr_data_raw <- readRDS("data/hr-data.rds");

# Factorize Values
factor_Education <-  c("Below College", "College", "Bachelor", "Master", "Doctor") %>% as.factor();
factor_EnvironmentSatisfaction <- c("Low", "Medium", "High", "Very High") %>% as.factor();
factor_JobInvolvement <- c("Low", "Medium", "High", "Very High")%>% as.factor();
factor_JobSatisfaction <- c("Low", "Medium", "High", "Very High")%>% as.factor();
factor_PerformanceRating <- c("Low", "Good", "Excellent", "Outstanding")%>% as.factor();
factor_RelationshipSatisfaction <- c("Low", "Medium", "High", "Very High")%>% as.factor();
factor_WorkLifeBalance <- c("Bad", "Good", "Better", "Best")%>% as.factor();

hr_data <- hr_data_raw %>%
	mutate(
		Education= factor_Education[Education],
		EnvironmentSatisfaction= factor_EnvironmentSatisfaction[EnvironmentSatisfaction],
		JobInvolvement=factor_JobInvolvement[JobInvolvement],
		PerformanceRating= factor_PerformanceRating[PerformanceRating],
		RelationshipSatisfaction=factor_RelationshipSatisfaction[RelationshipSatisfaction],
		WorkLifeBalance=factor_WorkLifeBalance[WorkLifeBalance]
	)

summary(hr_data)
