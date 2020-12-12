heart.df <- read.csv("heart.csv", stringsAsFactors = TRUE)
heart.df$target <- factor(heart.df$target)



View(heart.df)
set.seed(11) 
# partition data
train.index <- sample(1:nrow(heart.df), 0.6*nrow(heart.df))
train.df <- heart.df[train.index, ]
valid.df <- heart.df[-train.index,]

train.norm.df <- train.df
valid.norm.df <- valid.df

# normalize data
library(caret)

# compute mean and standard deviation of each column
norm.values <- preProcess(train.df[, 1:13], method=c("center", "scale"))

train.norm.df[, 1:13] <- predict(norm.values, train.df[, 1:13])
valid.norm.df[, 1:13] <- predict(norm.values, valid.df[, 1:13])

# install.packages("FNN")
library(FNN)

# use ?knn to find out more information
# It worth noting that the input argument cl must be a factor!
knn.pred <- knn(train.norm.df[, 1:13], valid.norm.df[, 1:13], 
                cl = train.norm.df[, 14], k = 5)

confusionMatrix(knn.pred, valid.norm.df[, 14])
