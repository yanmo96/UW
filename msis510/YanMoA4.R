# read data
phoneSale.df <- read.csv("phone_sale.csv", stringsAsFactors = TRUE)

View(phoneSale.df)
str(phoneSale.df)

# 1
phoneSale.df$Phone_sale <- as.numeric(phoneSale.df$Phone_sale == "Yes")

# transform to a factor
phoneSale.df$Any_cc_miles_12mo <- factor(phoneSale.df$Any_cc_miles_12mo)
# View(phoneSale.df)
str(phoneSale.df)
# rename the levels in order
levels(phoneSale.df$Any_cc_miles_12mo) <- c("N", "Y")
# create reference category or base level
phoneSale.df$Any_cc_miles_12mo <- relevel(phoneSale.df$Any_cc_miles_12mo, ref = "Y")


# 2
selected.var <- c(5,9,10)
selected.df <- phoneSale.df[,selected.var]
View(selected.df)


# 3
load("a4_TrainIndex.rda")
train.df <- selected.df[train.index, ]
valid.df <- selected.df[-train.index, ]
str(train.df)

# run logistic model, and show coefficients 
logit.reg <- glm(Phone_sale ~ ., data = train.df, family = "binomial")
summary(logit.reg)


# 4
  # logit = -2.054183 + 0.030643(Bonus_trans) - 0.565803(Any_cc_miles_12mo)


# 5
new.df <- data.frame(Bonus_trans=50, Any_cc_miles_12mo = "Y")
predict(logit.reg, new.df, type = "response")


# 6
# use predict() with type = "response" to compute predicted probabilities
# if type not specified, log-odds will be returned
logit.reg.pred <- predict(logit.reg, valid.df,  type = "response")
pred <- ifelse(logit.reg.pred > 0.5, 1, 0)
summary(factor(pred))
## generate the confusion matrix based on the prediction
# install.packages("caret", dependencies = TRUE)
library(caret)
confusionMatrix(factor(pred), factor(valid.df$Phone_sale), positive = "1")


# 7
summary(factor(selected.df$Phone_sale))





