Adult_Income<- read.csv("Portfolio/adult.csv", na.strings = "?")
View (Adult_Income)
Cleaned_income<- na.omit(Adult_Income)
sum(is.na(Cleaned_income))
str(Cleaned_income)
summary(Cleaned_income)
round(prop.table(table(Cleaned_income$income))*100, digits =  1)
Cleaned_income$income<- factor(Cleaned_income$income, levels = c("<=50K", ">50K"),
                                                      labels = c("<=50k", ">50k"))

#checking for duplicates
sum(duplicated((Cleaned_income)))
Income_clean <- Cleaned_income[!duplicated(Cleaned_income), ]
sum(duplicated((Income_clean)))

#Building Logistic regression 
Model<- glm(income ~., data = Income_clean[-c(8,9,10,14)], family = binomial)
summary(Model)

#Testing predictive model
library(rsample)
set.seed(123)

Split_income <- initial_split(data= Income_clean, 0.80, strata= native.country )
Trained_data <- training(Split_income)
Test_data<- testing(Split_income)

Test_data$predicted<- predict(Model, Test_data, type = "response")
Test_data$predicted<- ifelse(Test_data$predicted >.5, ">50k", "<=50k")

s<-table(Test_data$income, Test_data$predicted)
table(Test_data$income, Test_data$predicted)

Accuracy<- round(sum(diag(s)) / sum(s) * 100, digits = 1)


print(Accuracy)

