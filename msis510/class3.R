library(ggplot2)

ggplot(data = mpg) + geom_boxplot(aes(x = class, y = hwy))



ggplot(data = mpg) +
  geom_histogram(aes(x = cty), bins = 10)

ggplot(data = mpg) +
  geom_histogram(aes(x = cty), binwidth = 2)


#p1a
bh.df <- read.csv("BostonHousing.csv", stringsAsFactors = TRUE)
View(bh.df)
ggplot(data = bh.df) +
  geom_histogram(aes(x = MEDV), bins = 10) +
  labs(x="Median Value")

#p1b
ggplot(data = bh.df) + geom_boxplot(aes(x = factor(CHAS), y = MEDV))

#p1c1
ggplot(data = bh.df) + geom_boxplot(aes(x = CAT..MEDV, y = NOX))

#p1c2
ggplot(data = bh.df) + geom_boxplot(aes(x = CAT..MEDV, y = PTRATIO))





#Kmeans
utilities.df <- read.csv("Utilities.csv", stringsAsFactors = TRUE)

#normalized data
install.packages("caret", dependencies = TRUE)
library(caret)

norm.values <- preProcess(utilities.df, method=c("center", "scale"))
utilities.df.norm <- predict(norm.values, utilities.df)
set.seed(1234)
km <- kmeans(utilities.df.norm, 6)
km$cluster
km$centers
km$withinss
km$tot.withinss
