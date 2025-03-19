# Introduction
Income inequality is a persistent issue in the United States. This project aims to build a predictive model that predicts the income of a citizen considering various factors such as `Age`, `Gender`, `Marital status`, `Race`, `Native country`, `Work-class`, `Education`, `Educational-num`, `Occupation`, `Relationship`, `Fnlwgt`, `Capital-gain`, `Capital-loss`, `Hours-per-week`.
The data for your review [Download Data set](https://1drv.ms/x/c/fc11b36f16d1a624/EQEqwPNaOGNOriwfgrBj8iIBuDHjg47qEJimV7saVugswg?e=a87kxy)
## Technical Tools
- R Programming
- Power Bi

## Data Cleaning and Transformation
To ensure integrity and usability, I performed a data-cleaning process
1. **Handling NA Values:** The dataset contained various unknown information represented as "?" across different columns in the dataset. When importing into R, the `Na.strings` function was used to change "?" to NA values. Then all NA values were removed from the data.
2. **Handling Duplicate Values:** The data contained 47 duplicate values. Duplicate values were removed to maintain data integrity.
3. **Column Transformation:** The column `income` was transformed from text to a factor to improve prediction accuracy.

Data cleaned [download cleaned version](https://1drv.ms/x/c/fc11b36f16d1a624/EdaIgLQjcytNkTwEAPboezgB6lEkzzUMd6iw5rwWZRg3TQ?e=8Obw8f)


## Predicting Income Success
The logistic regression model was used to classify Incomes as = 50k or >50k based on all factors except `native.country`, `race`, and `gender`. As the summary result showed, these columns proved insignificant in predicting Income.
After building the prediction model, I split the data into train and test data. The train comprised 80% of the data, and the test data comprised the remaining 20%.



![](Model%20summary.png)




 **Intercept (-6.191):** The baseline log-odds of predicting ">50K" when all predictors are zero are negative, indicating a very low probability due to class imbalance. In the dataset, 75.2% of individuals earn "= 50K," while only 24.8% earn ">50K." The **p-value is less than 0.05**, meaning the model is statistically significant.
Using the model on the test data, income levels were predicted with an accuracy of 84.8%.

## Power BI Dashboard  
![](Adult%20income%20dashboard.png)
[Dasboard](https://1drv.ms/u/c/fc11b36f16d1a624/EeytajyESglFgoyxnlAKiacBVY3j14z6aeBYdL8jm5EuLA?e=6UZlV7)
### Overview  
To support the predictive analysis of **income classification**, a Power BI dashboard was created to visualize key income patterns based on education, gender, and geographic distribution. The dashboard provides insights into the factors influencing income levels.  

### Key Visuals & Insights  

####  Income Distribution by Country  
- **Visual Type:** Map  
- **Description:** This map highlights income distribution across different countries.  
- **Insight:** The majority of individuals in the dataset are from North America.  

####  Education Percentage by Income  
- **Visual Type:** Donut Chart  
- **Description:** Displays the percentage distribution of education levels among individuals.  
- **Insight:** The largest group consists of **High School graduates (32.7%)**, followed by **Some College (21.88%)**.  

####  Income Breakdown by Education & Gender  
- **Visual Type:** Stacked Bar Chart  
- **Description:** Shows how income levels vary by education and gender.  
- **Insight:** More **males with higher education levels** tend to earn `>50K`, while females are more concentrated in the `<50K` category.  

####  Income Category Distribution  
- **Visual Type:** Bar Chart  
- **Description:** Compares the number of individuals earning `>50K` and `<50K`.  
- **Insight:** A **significant majority** (75.2%) earn `<50K`, while only **24.8%** earn `>50K`.  



## CONCLUSION  
The logistic regression model effectively predicts whether an individual's income is above or below $50K, achieving an accuracy of 84.8%. However, the model is affected by class imbalance, as the majority of individuals fall into the "<=50K" category (75.2%). The negative intercept (-6.243) further confirms that predicting ">50K" is less likely. Despite these challenges, the statistically significant p-values indicate that the model is meaningful.
## RECOMMENDATIONS
 - Address Class Imbalance: Implement oversampling (SMOTE) or undersampling techniques to balance the dataset and improve model performance.
 - Try Alternative Models: Decision trees and random forests may capture non-linear relationships better than logistic regression.

[View R_SCRIPT](https://github.com/daniel-ifenna/Adult_Income/blob/e8200fe44d66d76042fcebdfb380b2d6ed372e30/Logistic%20regression%20Adult%20income.R)
