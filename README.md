# Introduction
Income inequality is a persistent issue in the United States. This project aims to build a predictive model that predicts the income of a citizen considering various factors such as `Age`, `Gender`, `Marital status`, `Race`, `Native country`, `Work-class`, `Education`, `Educational-num`, `Occupation`, `Relationship`, `Fnlwgt`, `Capital-gain`, `Capital-loss`, `Hours-per-week`.
The data for your review [Download Data set](https://1drv.ms/x/c/fc11b36f16d1a624/EQEqwPNaOGNOriwfgrBj8iIBuDHjg47qEJimV7saVugswg?e=a87kxy)
## Technical Tools
- R Programming

# Data Cleaning and Transformation
To ensure integrity and usability, I performed a data cleaning process
1. *Handling NA Values:* The dataset contained various unknown information represented as "?" across different columns in the dataset. When importing into R, the `Na.strings` function was used to change "?" to NA values. Then all NA values were removed from the data.
2. *Handling Duplicate Values:* The data contained 47 duplicate values. Duplicate values were removed to maintain data integrity.
3. *COLUMN TRANSFORMATION:* The column `income` was transformed from text to a factor to improve prediction accuracy.
Data cleaned [download cleaned version](https://1drv.ms/x/c/fc11b36f16d1a624/EdaIgLQjcytNkTwEAPboezgB6lEkzzUMd6iw5rwWZRg3TQ?e=8Obw8f)



# Predicting Income Success
The logistic regression model was used to classify Incomes as = 50k or >50k based on all factors except `native.country`, `race`, and `gender`. As the summary result showed, these columns proved to be insignificant in predicting Income.
After building the model for prediction, then I went on to split the data  into train and test data, the train was 80% of the data, and the test data consisting of the remaining 20%. 
