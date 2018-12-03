library(readxl)
library(pander)
library(caret)
library(ggthemes)


raw<-readRDS("data/hr-data.rds")
(head(raw))

names <- c('WorkLifeBalance' ,'StockOptionLevel','PerformanceRating','JobSatisfaction',
           'RelationshipSatisfaction','JobLevel','JobInvolvement','EnvironmentSatisfaction','Education')
raw[,names] <- lapply(raw[,names] , factor)
str(raw)

library(ggplot2)
ggplot(raw,aes(Attrition,fill=Attrition))+geom_bar()+theme_tufte()+scale_fill_few("Dark")
pander(prop.table(table(raw$Attrition)))


library(grid)
library(gridExtra)

agePlot <- ggplot(raw,aes(Age,fill=Attrition))+geom_density()+facet_grid(~Attrition)+theme_tufte()+scale_fill_few("Dark")
travelPlot <- ggplot(raw,aes(BusinessTravel,fill=Attrition))+geom_bar()+theme_tufte()+scale_fill_few("Dark")
ratePlot <- ggplot(raw,aes(DailyRate,Attrition))+geom_point(size=4,alpha = 0.05)+theme_tufte()+scale_fill_few("Dark")
depPlot <- ggplot(raw,aes(Department,fill = Attrition))+geom_bar()+theme_tufte()+scale_fill_few("Dark")
distPlot<- ggplot(raw,aes(DistanceFromHome,fill=Attrition))+geom_bar()+theme_tufte()+scale_fill_few("Dark")
eduPlot <- ggplot(raw,aes(Education,fill=Attrition))+geom_bar()+theme_tufte()+scale_fill_few("Dark")
edufieldPlot <- ggplot(raw,aes(EducationField,fill=Attrition))+geom_bar()+theme_tufte()+scale_fill_few("Dark")
envPlot <- ggplot(raw,aes(EnvironmentSatisfaction,fill=Attrition))+geom_bar()+theme_tufte()+scale_fill_few("Dark")
genPlot <- ggplot(raw,aes(Gender,fill=Attrition))+geom_bar()+theme_tufte()+scale_fill_few("Dark")



hourlyPlot <- ggplot(raw,aes(HourlyRate,fill=Attrition))+geom_bar()+theme_tufte()+scale_fill_few("Dark")
jobInvPlot <- ggplot(raw,aes(JobInvolvement,fill=Attrition))+geom_bar()+theme_tufte()+scale_fill_few("Dark")
jobLevelPlot <- ggplot(raw,aes(JobLevel,fill=Attrition))+geom_bar()+theme_tufte()+scale_fill_few("Dark")
jobSatPlot <- ggplot(raw,aes(JobSatisfaction,fill=Attrition))+geom_bar()+theme_tufte()+scale_fill_few("Dark")
marPlot <- ggplot(raw,aes(MaritalStatus,fill=Attrition))+geom_bar()+theme_tufte()+scale_fill_few("Dark")
monthlyIncPlot <- ggplot(raw,aes(MonthlyIncome,fill=Attrition))+geom_density()+theme_tufte()+scale_fill_few("Dark")
monthlyRatePlot <- ggplot(raw,aes(MonthlyRate,fill=Attrition))+geom_density()+theme_tufte()+scale_fill_few("Dark")
numCompPlot <- ggplot(raw,aes(NumCompaniesWorked,fill=Attrition))+geom_bar()+theme_tufte()+scale_fill_few("Dark")

overTimePlot <- ggplot(raw,aes(OverTime,fill=Attrition))+geom_bar()+theme_tufte()+scale_fill_few("Dark")
hikePlot <- ggplot(raw,aes(PercentSalaryHike,Attrition))+geom_point(size=4,alpha = 0.01)+theme_tufte()+scale_fill_few("Dark")
perfPlot <- ggplot(raw,aes(PerformanceRating,fill = Attrition))+geom_bar()+theme_tufte()+scale_fill_few("Dark")
RelSatPlot <- ggplot(raw,aes(RelationshipSatisfaction,fill = Attrition))+geom_bar()+theme_tufte()+scale_fill_few("Dark")

StockPlot <- ggplot(raw,aes(StockOptionLevel,fill = Attrition))+geom_bar()+theme_tufte()+scale_fill_few("Dark")
workingYearsPlot <- ggplot(raw,aes(TotalWorkingYears,fill = Attrition))+geom_bar()+theme_tufte()+scale_fill_few("Dark")
TrainTimesPlot <- ggplot(raw,aes(TrainingTimesLastYear,fill = Attrition))+geom_bar()+theme_tufte()+scale_fill_few("Dark")
WLBPlot <- ggplot(raw,aes(WorkLifeBalance,fill = Attrition))+geom_bar()+theme_tufte()+scale_fill_few("Dark")

YearAtComPlot <- ggplot(raw,aes(YearsAtCompany,fill = Attrition))+geom_bar()+theme_tufte()+scale_fill_few("Dark")
YearInCurrPlot <- ggplot(raw,aes(YearsInCurrentRole,fill = Attrition))+geom_bar()+theme_tufte()+scale_fill_few("Dark")
YearsSinceProm <- ggplot(raw,aes(YearsSinceLastPromotion,fill = Attrition))+geom_bar()+theme_tufte()+scale_fill_few("Dark")
YearsCurrManPlot <- ggplot(raw,aes(YearsWithCurrManager,fill = Attrition))+geom_bar()+theme_tufte()+scale_fill_few("Dark")

grid.arrange(marPlot,monthlyIncPlot,monthlyRatePlot,numCompPlot,hourlyPlot,jobInvPlot,jobLevelPlot,jobSatPlot,overTimePlot,hikePlot,perfPlot,RelSatPlot,StockPlot,workingYearsPlot,TrainTimesPlot,WLBPlot,YearAtComPlot,YearInCurrPlot,YearsSinceProm,YearsCurrManPlot,ncol=3,top = "okokok")


grid.arrange(agePlot,travelPlot,ratePlot,depPlot,distPlot,eduPlot,edufieldPlot,envPlot,genPlot,ncol=3,top="plots")

na_count <- data.frame(sapply(raw, function(y) sum(length(which(is.na(y))))))
pander(na_count)
