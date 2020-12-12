heart.df <- read.csv("heart.csv", stringsAsFactors = TRUE)

View(heart.df)
str(heart.df)

# transform to a factor
heart.df$sex <- factor(heart.df$sex)
heart.df$sex <- relevel(heart.df$sex, ref = "0")

heart.df$cp <- factor(heart.df$cp)
heart.df$cp <- relevel(heart.df$cp, ref = "0")

heart.df$fbs <- factor(heart.df$fbs)
heart.df$fbs <- relevel(heart.df$fbs, ref = "0")

heart.df$restecg <- factor(heart.df$restecg)
heart.df$restecg <- relevel(heart.df$restecg, ref = "0")

heart.df$exang <- factor(heart.df$exang)
heart.df$exang <- relevel(heart.df$exang, ref = "0")

heart.df$slope <- factor(heart.df$slope)
heart.df$slope <- relevel(heart.df$slope, ref = "0")

#heart.df$ca <- factor(heart.df$ca)
#heart.df$ca <- relevel(heart.df$ca, ref = "0")

heart.df$thal <- factor(heart.df$thal)
heart.df$thal <- relevel(heart.df$thal, ref = "0")

#levels(heart.df$thal)
heart.df$target <- factor(heart.df$target) 
levels(heart.df$target) <- c("1",0)

heart.df$target <- as.numeric(heart.df$target == "1")


# create training and validation sets
set.seed(5)

# partition the data
train.index <- sample(1:nrow(heart.df), nrow(heart.df)*0.6)  
train.df <- heart.df[train.index, ]
valid.df <- heart.df[-train.index, ]

# run logistic model, and show coefficients 
logit.reg <- glm(target ~ ., data = heart.df, family = "binomial")
summary(logit.reg)


# use predict() with type = "response" to compute predicted probabilities
# if type not specified, log-odds will be returned
logit.reg.pred <- predict(logit.reg, valid.df,  type = "response")


# Choose cutoff value and evaluate classification performance
pred <- ifelse(logit.reg.pred > 0.3464648, 1, 0)

## generate the confusion matrix based on the prediction
library(caret)
confusionMatrix(factor(pred), factor(valid.df$target), positive = "1")



library(pROC)

r <- roc(valid.df$target, logit.reg.pred)
plot.roc(r)

# find the best threshold
coords(r, x = "best", transpose = FALSE)

#coords(r, x = c(0.1, 0.2, 0.5),  transpose = FALSE)
