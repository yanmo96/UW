breastcancer.df <- read.csv("breastcancer.csv", stringsAsFactors = TRUE)
breastcancer.df <- breastcancer.df[,1:9]
View(breastcancer.df)
library(caret)

# compute mean and standard deviation of each column
norm.values <- preProcess(breastcancer.df, method=c("center", "scale"))
# we perform the transformation/normalization
breastcancer.df.norm <- predict(norm.values, breastcancer.df)

# set seed for reproducibility
set.seed(111)
km <- kmeans(breastcancer.df.norm, 3)

km
km$centers

sort(km$centers[3,])
