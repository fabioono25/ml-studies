# Part 1: importing the dataset
setwd("~/study/ml-studies/1-Data Preprocessing")
dataset <- read.csv("Data.csv")
# dataset = dataset[1:3]  # only the first 3 columns
# print(dataset)

# Part 2: Taking care of missing data (sometimes not)
dataset$Age <- ifelse(is.na(dataset$Age), ave(dataset$Age, FUN = function(x) mean(x, na.rm = TRUE)), dataset$Age) # nolint
# na.rm meaning: remove NA values from the dataset
dataset$Salary <- ifelse(is.na(dataset$Salary), ave(dataset$Salary, FUN = function(x) mean(x, na.rm = TRUE)), dataset$Salary)

# Part 3: Encoding categorical data (Country and Purchased) (sometimes not)

# using the factor function to encode the categorical data
dataset$Country <- factor(dataset$Country, levels = c("France", "Spain", "Germany"), labels = c(1, 2, 3))

dataset$Purchased <- factor(dataset$Purchased, levels = c("No", "Yes"), labels = c(0, 1))


# Part 4: Splitting the dataset into the Training set and Test set

# install.packages('caTools')
library(caTools)
set.seed(123) # to make the result reproducible
split <- sample.split(dataset$Purchased, SplitRatio = 0.8) # 80% of the data will be used for training
# split: TRUE goes to training set, FALSE goes to test set

# create the training and test sets
training_set <- subset(dataset, split == TRUE)
test_set <- subset(dataset, split == FALSE)

# Part 5: Feature Scaling (turn the values into the same scale)
# example: age and salary are not in the same scale. Age is from 27 to 50, while salary is from 48000 to 83000
# Euclidian distance will be dominated by the salary, so we need to scale the values

training_set[, 2:3] <- scale(training_set[, 2:3])
test_set[, 2:3] <- scale(test_set[, 2:3])
