

library(readxl)

library(tidyverse)


factored_df <- readRDS("data/factored-definitions.rds")


# Compare attrition rate betwen different groups of monthly income
salary_bins = c("0-5k", "5-10k", "10-15k", "15-20k")

# Salary Bins
engr_df <- factored_df %>%
	mutate(IncLevels = cut(
		MonthlyIncome,
		breaks = c(0, 5000, 10000, 15000, 20000),
		labels = salary_bins
	))


# Total Working Years
# engr_df <- engr_df %>%
# 	mutate(ExpLevels = cut(TotalWorkingYears,
# 						   breaks=c(0, 5000, 10000, 15000, 20000),
# 						   labels=salary_bins
# 	))


# Age Groups
engr_df$AgeGroup <- with(engr_df, ifelse(Age > 55 , 8 , ifelse(Age > 50, 7, ifelse(
	Age > 45, 6, ifelse(Age > 40, 5, ifelse(Age > 35, 4, ifelse(
		Age > 30, 3, ifelse(Age > 25 , 2 , 1)
	)))
))))


# Distance Bins
engr_df$DistanceGroup <-
	with(engr_df, ifelse(
		DistanceFromHome > 25,
		6,
		ifelse(
			DistanceFromHome > 20,
			5,
			ifelse(
				DistanceFromHome > 15,
				4,
				ifelse(DistanceFromHome > 10,
					   3, ifelse(DistanceFromHome > 5,
					   		  2,
					   		  1))
			)
		)
	))

# Years With Manager
engr_df$YearsWithManagerGroup <-
	with(engr_df, ifelse(
		YearsWithCurrManager > 15,
		5,
		ifelse(
			YearsWithCurrManager > 10,
			4,
			ifelse(
				YearsWithCurrManager > 5,
				3,
				ifelse(YearsWithCurrManager > 2, 2, 1)
			)
		)
	))

# Tenure Per Job
engr_df$TenurePerJob <-
	ifelse(
		engr_df$NumCompaniesWorked != 0,
		engr_df$TotalWorkingYears / engr_df$NumCompaniesWorked,
		0
	)

engr_df$YearWithoutChange <-
	engr_df$YearsInCurrentRole - engr_df$YearsSinceLastPromotion
engr_df$YearsWithoutChange2 <-
	engr_df$TotalWorkingYears - engr_df$YearsSinceLastPromotion

# Tenure Groups
engr_df$TenureGroup <-
	with(engr_df, ifelse(TenurePerJob > 35, 9, ifelse(
		TenurePerJob > 30, 8, ifelse(TenurePerJob > 25, 7, ifelse(
			TenurePerJob > 20, 6, ifelse(TenurePerJob > 15, 5, ifelse(
				TenurePerJob > 10, 4, ifelse(TenurePerJob > 5, 3, ifelse(TenurePerJob >
																		 	2, 2, 1))
			))
		))
	)))

#Creating Number of Companies Worked
engr_df$WorkYearGroup <-
	with(engr_df, ifelse(
		TotalWorkingYears > 35,
		9,
		ifelse(
			TotalWorkingYears > 30,
			8,
			ifelse(
				TotalWorkingYears > 25,
				7,
				ifelse(
					TotalWorkingYears > 20,
					6,
					ifelse(
						TotalWorkingYears > 15,
						5,
						ifelse(
							TotalWorkingYears > 10,
							4,
							ifelse(TotalWorkingYears > 5, 3, ifelse(TotalWorkingYears > 2, 2, 1))
						)
					)
				)
			)
		)
	))

engr_df$NumCompGroup <-
	with(engr_df, ifelse(NumCompaniesWorked > 4, 3, ifelse(NumCompaniesWorked >
														   	2, 2, 1)))

Med_HR <-
	median(engr_df[engr_df$Department == 'Human Resources', ]$MonthlyIncome)
Med_RnD <-
	median(engr_df[engr_df$Department == 'Research & Development', ]$MonthlyIncome)
Med_Sales <-
	median(engr_df[engr_df$Department == 'Sales', ]$MonthlyIncome)


Med_LabTech <-
	median(engr_df[engr_df$JobRole == 'Laboratory Technician', ]$MonthlyIncome)

TrainLabTech <- engr_df[engr_df$JobRole == 'Laboratory Technician', ]
TrainLabTech$comparole <- TrainLabTech$MonthlyIncome / Med_LabTech

Med_overall <- median(engr_df$MonthlyIncome)

engr_df$CompaRatioDep <-
	ifelse(
		engr_df$Department == 'Human Resources',
		engr_df$MonthlyIncome / Med_HR,
		ifelse(
			engr_df$Department == 'Research & Development',
			engr_df$MonthlyIncome / Med_RnD,
			engr_df$MonthlyIncome / Med_Sales
		)
	)

engr_df$CompaRatioOverall <- engr_df$MonthlyIncome / Med_overall

engr_df$CompaOverallGroup <-
	ifelse(engr_df$CompaRatioOverall > 4,
		   4,
		   ifelse(
		   	engr_df$CompaRatioOverall > 3,
		   	3,
		   	ifelse(
		   		engr_df$CompaRatioOverall > 2,
		   		2,
		   		ifelse(
		   			engr_df$CompaRatioOverall > 1,
		   			1,
		   			ifelse(engr_df$CompaRatioOverall > 0.5, 0.5, 0)
		   		)
		   	)
		   ))

engr_df$CompaDepGroup <-
	ifelse(engr_df$CompaRatioDep > 4,
		   4,
		   ifelse(
		   	engr_df$CompaRatioDep > 3,
		   	3,
		   	ifelse(
		   		engr_df$CompaRatioDep > 2,
		   		2,
		   		ifelse(
		   			engr_df$CompaRatioDep > 1,
		   			1,
		   			ifelse(engr_df$CompaRatioDep > 0.5, 0.5, 0)
		   		)
		   	)
		   ))

engr_df$CompaRatioDep <-
	ifelse(
		engr_df$Department == 'Human Resources',
		engr_df$MonthlyIncome / Med_HR,
		ifelse(
			engr_df$Department == 'Research & Development',
			engr_df$MonthlyIncome / Med_RnD,
			engr_df$MonthlyIncome / Med_Sales
		)
	)

engr_df$CompaRatioOverall <- engr_df$MonthlyIncome / Med_overall

engr_df$CompaOverallGroup <-
	ifelse(engr_df$CompaRatioOverall > 4,
		   4,
		   ifelse(
		   	engr_df$CompaRatioOverall > 3,
		   	3,
		   	ifelse(
		   		engr_df$CompaRatioOverall > 2,
		   		2,
		   		ifelse(
		   			engr_df$CompaRatioOverall > 1,
		   			1,
		   			ifelse(engr_df$CompaRatioOverall > 0.5, 0.5, 0)
		   		)
		   	)
		   ))

engr_df$CompaDepGroup <-
	ifelse(engr_df$CompaRatioDep > 4,
		   4,
		   ifelse(
		   	engr_df$CompaRatioDep > 3,
		   	3,
		   	ifelse(
		   		engr_df$CompaRatioDep > 2,
		   		2,
		   		ifelse(
		   			engr_df$CompaRatioDep > 1,
		   			1,
		   			ifelse(engr_df$CompaRatioDep > 0.5, 0.5, 0)
		   		)
		   	)
		   ))

saveRDS(engr_df, "data/engineered-features.rds")
