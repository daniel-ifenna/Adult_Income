# Introduction
Income inequality is a persistent issue in the United States. This project explores the relationship between demographic and socio-economic factors and annual income levels, using machine learning techniques to identify key predictors of income.
This data set was derived from Kaggle. [Download Data set](https://1drv.ms/x/c/fc11b36f16d1a624/EQEqwPNaOGNOriwfgrBj8iIBuDHjg47qEJimV7saVugswg?e=a87kxy)

## Problem Statement
Analyzing demographic and socio-economic factors that influence annual income levels of adult individuals in the United States.

## Dataset
Variables:
### Demographic Variables

1. Age: Continuous
2. Gender: Categorical (Male, Female)
3. Marital status: Categorical (Married, Divorced, Separated, etc.)
4. Race: Categorical (White, Black, Asian, etc.)
5. Native country: Categorical (United States, Mexico, etc.)
   
### Socio-Economic Variables
1. Work-class: Categorical (Private, Public, Self-emp, etc.)
2. Education: Categorical (High school, Bachelor's, Master's, etc.)
3. Educational-num: Continuous (Number of years of education)
4. Occupation: Categorical (Manager, Sales, Technician, etc.)
5. Relationship: Categorical (Husband, Wife, Unmarried, etc.)

### Financial Variables
1. Fnlwgt: Continuous (Final weight, a measure of the respondent's importance in the dataset)
2. Capital-gain: Continuous (Capital gains, if any)
3. Capital-loss: Continuous (Capital losses, if any)
4. Hours-per-week: Continuous (Number of hours worked per week)

### Target Variable

1. Income: Binary (<=50K, >50K) or Continuous (Actual income value)

# Analysis Proceedings 
- Data Importation and Cleaning [download cleaned version](https://1drv.ms/x/c/fc11b36f16d1a624/EdaIgLQjcytNkTwEAPboezgB6lEkzzUMd6iw5rwWZRg3TQ?e=8Obw8f)
- Explanatory Analysis and visualization
- Building Logistics Regression Model for prediction
- Building K-NN Algorithm model for predicting

## Let's Analyze
The dataset reveals a significant income disparity, with 75.2% (33,973) of individuals earning ≤$50,000 and 24.8% (11,202) earning >$50,000.
### Visualization
![Age Distribution](https://github.com/daniel-ifenna/Adult_Income/blob/bb3c722774507ddde2730a5907ba60cbb6c81599/images/Distribution%20of%20age.png)
- Observations: Most young people within the age gap of 20-40 years earn <=$50,000 and above 50 - 60 years earn >$50,000. But, We see that after the age of 60, the record for those earning  begins to reduce sharply.

![Gender by Income](https://github.com/daniel-ifenna/Adult_Income/blob/bb3c722774507ddde2730a5907ba60cbb6c81599/images/Gender%20vs%20income.png)
- Observations: The graph shows that about 10% of the female population earn above $50,000 while about 25% of men earn above $50,000.

![Hour.per.week. by Income](https://github.com/daniel-ifenna/Adult_Income/blob/bb3c722774507ddde2730a5907ba60cbb6c81599/images/Box%20plot%20hours%20per%20week%20over%20income.png)
 - Observations: People earning above $50,000 tend to work more hours in the year than those earning less than or equal to $50,000.
                - we also see that the median for those earning above $50,000 is higher than those who earn less than equals to $50,000.

### Building Logistics Regression Model for prediction.
~~~{r}
library(rsample)
set.seed((123))
split.income<- initial_split(Income_cleaned, 0.80, strata = native.country)
Train_data<- training(split.income)
Test_data<- testing(split.income)
Model<- glm(income~., data= Income_cleaned[-c(9,10,14)], family = "binomial")
summary(Model)
~~~
#### Observations:
-  Intercept (-6.296e+00): The baseline log-odds when all predictors are 0.
-  Age 
Workclass variables: Many work categories (e.g., Private, Self-Employed, and Not-Inc) have negative coefficients, indicating they decrease the likelihood of higher income compared to a baseline work category.
-  Education variables: Higher education levels (e.g., Doctorate, Masters, Bachelors) are strongly positive, suggesting these significantly increase the likelihood of higher income.
-  Capital gain (3.190e-04) and Capital loss (6.527e-04): Positive and significant, indicating that both contribute to higher income.
-  Hours per week (2.987e-02): Positive and significant, suggesting more working hours increase the likelihood of higher income.

~~~{r}
Test_data$Predicted<- predict(Model, Test_data)
Test_data$Predicted<- ifelse(Test_data$Predicted > .5, ">50k", "<=50k")
s<-table(Test_data$income, Test_data$Predicted)
Y<-sum(diag(s))/sum(s)
Accuracy<- round(Y*100, digits = 1)
Accuracy
~~~
![Accuracy Percentage for Logistics Regression](https://github.com/daniel-ifenna/Adult_Income/blob/82b13e1e6b4a4d1afc3abf06635342c71529a184/images/Screenshot%202025-01-25%20190124.png)
  - As seen in the logistics regression model gives us an 84% Test Accuracy.


### Building K-NN Algorithm model for predicting
~~~{r}
library(class)
set.seed(234)
knn_split<- initial_split(Income_cleaned, 0.80, strata = native.country)
Train_knn<- training(knn_split)
Test_knn<- testing(knn_split)
Train_labels<- Train_knn$income
Test_labels<- Test_knn$income

Income_cleaned_Numeric<- sapply(Income_cleaned, is.numeric)
normalize<- function(x){
  return((x-min(x))/(max(x)-min(x)))
}
normalize(c(0,1,2,3,4,5))
Trained_data<- as.data.frame(lapply(Train_knn[ , Income_cleaned_Numeric], normalize))
Tested_data<- as.data.frame(lapply(Test_knn[, Income_cleaned_Numeric], normalize))
~~~

#### Predicting with K
~~~
First_knn<- knn(train = Trained_data, test = Tested_data, cl= Train_labels, k= 5)
E<-table(Test_labels, First_knn)
Accuracy_First_Knn<-round(sum(diag(E))/sum(E)*100, digits = 1)
print(Accuracy_First_Knn)

Second_knn<- knn(train = Trained_data, test = Tested_data, cl= Train_labels, k= 15)
S.K<-table(Test_labels, Second_knn)
Accuracy_Second_Knn<-round(sum(diag(S.K))/sum(S.K)*100, digits = 1)
print(Accuracy_Second_Knn)

Third_knn<- knn(train = Trained_data, test = Tested_data, cl= Train_labels, k= 31)
T.K<-table(Test_labels, Third_knn)
Accuracy_Third_Knn<-round(sum(diag(T.K))/sum(T.K)*100, digits = 1)
print(Accuracy_Third_Knn)
~~~

Predicting K results
1. K as "5" gave a 79.3% Test Accuracy. 
2. K as "15" gave an 80.7% Test Accuracy
3. K as "31" gave an 81.1% Test Accuracy

## Reccommendation
After building Predictive models using both Logistics Regression and K-NN algorithm.
Logistic Regression produced an 84% Test accuracy for this data set K-NN produced an 81.1% using K as “31”
Test accuracy for this data set. My recommendation is that the logistic model be employed to predict the
classification of Income level with new data entry.
