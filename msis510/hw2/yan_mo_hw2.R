dkos.df <- read.csv("dailykos.csv", stringsAsFactors = TRUE)
View(dkos.df)
library(caret)

## compute mean and standard deviation of each column
#norm.values <- preProcess(dkos.df, method=c("center", "scale"))

## we perform the transformation/normalization
#dkos.df.norm <- predict(norm.values, dkos.df)


# set seed for reproducibility
set.seed(1000)
km <- kmeans(dkos.df, 7)
km$size

#change the max print limit
options(max.print=1000000)


# show cluster membership
km$cluster
dkos.df[km$cluster==3,]

#==============================================
# No.1
summary(factor(km$cluster))
#==============================================

# centroids
km$centers

# No.2
sort(km$centers[1,])[ (length(km$centers[1,])-9) : (length(km$centers[1,]))]


# within-cluster sum of squared distances
km$withinss

# total within-cluster sum of square
km$tot.withinss





