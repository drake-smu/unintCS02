library(readxl);
library(tidyverse);

hr_data_raw <- readRDS("data/hr-data.rds");

# Factorize Values
labels_Education <-  c("Below College", "College", "Bachelor", "Master", "Doctor");
labels_EnvironmentSatisfaction <- c("Low", "Medium", "High", "Very High");
labels_JobInvolvement <- c("Low", "Medium", "High", "Very High");
labels_JobSatisfaction <- c("Low", "Medium", "High", "Very High");
labels_PerformanceRating <- c("Excellent", "Outstanding");
labels_RelationshipSatisfaction <- c("Low", "Medium", "High", "Very High");
labels_WorkLifeBalance <- c("Bad", "Good", "Better", "Best");



# Map Numerics to Labled Factors ------------------------------------------
hr_data <- hr_data_raw %>%
	mutate(
		Education= factor(Education,labels =labels_Education),
		EnvironmentSatisfaction= factor(EnvironmentSatisfaction, labels= labels_EnvironmentSatisfaction),
		JobInvolvement=factor(JobInvolvement, labels= labels_JobInvolvement),
		PerformanceRating= factor(PerformanceRating,labels =  labels_PerformanceRating),
		RelationshipSatisfaction= factor(RelationshipSatisfaction,labels = labels_RelationshipSatisfaction),
		WorkLifeBalance= factor(WorkLifeBalance, labels= labels_WorkLifeBalance)
	)


# General Numeric Factors -------------------------------------------------
factored_def <- hr_data %>%
	mutate(
		JobLevel= as.factor(JobLevel),
		StockOptionLevel= as.factor(StockOptionLevel),
	);

# Convert Remaing Chr Features to Factors
factored_def <- factored_def %>%
	mutate_if(is.character,as.factor);

saveRDS(factored_def, file = "data/factored-definitions.rds");

# summary(factored_def)
