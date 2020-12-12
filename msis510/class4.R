# load data
bank.df <- read.csv("UniversalBank.csv", stringsAsFactors = TRUE)

View(bank.df)

set.seed(11)  # set seed for reproducing the partition
# Random sample indexes
train.index <- sample(1:nrow(bank.df), nrow(bank.df)*0.6)  

View(train.index)

# Build training and validation set by indexing
train.df <- bank.df[train.index, ]
valid.df <- bank.df[-train.index, ]

# if not installed, run:
# install.packages("rpart")
library(rpart)

# if not installed, run:
# install.packages("rpart.plot")
library(rpart.plot)

default.ct <- rpart(Personal.Loan ~ ., data = train.df, method = "class")

## plot tree
prp(default.ct)


prp(default.ct, type=1, extra = 1)

# full tree
full.ct <- rpart(Personal.Loan ~ ., data = train.df, method = "class", 
                 control = rpart.control(cp = -1, minsplit = 1))
prp(full.ct)

my.ct <- rpart(Personal.Loan ~ ., data = train.df, method = "class", 
               control = rpart.control(maxdepth =  3, minbucket =  30))
prp(my.ct,  type=1, extra = 1)


names(train.df)

# classify records in the validation data.
# set argument type = "class" in predict() to generate predicted class membership.
# Otherwise, a probablity of belonging to each class
default.ct.point.pred <- predict(default.ct, valid.df, type = "class")

library(caret)

# generate confusion matrix for validation data
confusionMatrix(default.ct.point.pred, factor(valid.df$Personal.Loan))



