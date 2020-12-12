# load data
heart.df <- read.csv("heart.csv", stringsAsFactors = TRUE)
View(hear.df)
heart.df <- heart.df[,-14]
# normalize data
# install.packages("caret", dependencies = TRUE)
library(caret)

# compute mean and standard deviation of each column
norm.values <- preProcess(heart.df, method=c("center", "scale"))

# we perform the transformation/normalization
heart.df.norm <- predict(norm.values, heart.df)

#确定最佳聚类数目
fviz_nbclust(heart.df.norm, kmeans, method = "wss") + geom_vline(xintercept = 4, linetype = 2)

# set seed for reproducibility
set.seed(1234)
km <- kmeans(heart.df.norm, 4)

# show cluster membership
km$cluster

# centroids
km$centers

# within-cluster sum of squared distances
km$withinss

# total within-cluster sum of square
km$tot.withinss


#===============================================================================
# https://blog.csdn.net/hfutxiaoguozhi/article/details/78828047

library("ggpubr")
ggscatter(
  ind.coord, x = "Dim.1", y = "Dim.2", 
  color = "cluster", palette = "npg", ellipse = TRUE, ellipse.type = "convex",
  shape = "target", size = 1.5,  legend = "right", ggtheme = theme_bw(),
  xlab = paste0("Dim 1 (", variance.percent[1], "% )" ),
  ylab = paste0("Dim 2 (", variance.percent[2], "% )" )
) + stat_mean(aes(color = cluster), size = 4)


# install.packages("factoextra")
library(factoextra)
fviz_cluster(km, data = heart.df)
fviz_cluster(km, data = heart.df.norm)
fviz_cluster(km, data = heart.df.norm,
             #palette = c("#2E9FDF", "#00AFBB", "#E7B800", "#FC4E07"),
             ellipse.type = "euclid",
             star.plot = TRUE, 
             repel = TRUE,
             ggtheme = theme_minimal()
)


#先求样本之间两两相似性
result <- dist(heart.df.norm, method = "euclidean")
#产生层次结构
result_hc <- hclust(d = result, method = "ward.D2")
#进行初步展示
fviz_dend(result_hc, cex = 0.6)

fviz_dend(result_hc, k = 4, 
          cex = 0.5, 
          k_colors = c("#2E9FDF", "#00AFBB", "#E7B800", "#FC4E07"),
          color_labels_by_k = TRUE, 
          rect = TRUE          
)


