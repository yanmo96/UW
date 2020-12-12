delays.df <- read.csv("FlightDelay.csv", stringsAsFactors = TRUE)
View(delays.df)
View(delays.df[,-3])

load("TrainIndex.rda") # which stores the variable train.index
train.df <- delays.df[train.index, ]
valid.df <- delays.df[-train.index, ]

library(rpart)

library(rpart.plot)

default.ct <- rpart(Flight.Status ~ ., data = train.df[,-3], method = "class")

## plot tree
prp(default.ct)
# No.2 =================================================
prp(default.ct, type=1, extra = 1)

# full.ct <- rpart(Flight.Status ~ ., data =train.df[,-3], method = "class", control = rpart.control(cp = -1, minsplit = 1))
# prp(full.ct)

# No.3 =================================================
library(caret)
default.ct.point.pred <- predict(default.ct, valid.df[,-3], type = "class")

# generate confusion matrix for validation data
confusionMatrix(default.ct.point.pred, factor(valid.df[,-3]$Flight.Status))





# No.6 =================================================
View(train.df[,-3][,-6])
default.ct <- rpart(Flight.Status ~ ., data = train.df[,-3][,-6], method = "class")

## plot tree
prp(default.ct)

prp(default.ct, type=1, extra = 1)


default.ct.point.pred <- predict(default.ct, valid.df[,-3][,-6], type = "class")

# generate confusion matrix for validation data
confusionMatrix(default.ct.point.pred, factor(valid.df[,-3][,-6]$Flight.Status))

summary(train.df[,9])
