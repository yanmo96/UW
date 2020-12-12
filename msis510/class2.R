xNum <- c(1,2,3,4,5)
xNum
x2Num <- c(xNum,5,6,7)
x2Num

x <- c(2,4,6,8)
x + 1
x*pi
x+x
x*x
length(x)

xSeq <- 1:10
xSeq
10:1

xNum[2:4]
xNum[c(1,3)]
xNum[2]

xSeq
xSeq[-5]
xSeq[-5:-7]

xNum
xNum[c(TRUE,TRUE,FALSE,FALSE,FALSE)]

xNum>2
xNum[xNum>2]

f <- c("a","b","c")
length(f)
f[1:2]
f[-1]

x.df <- read.csv("toy_example.csv")
x.df
x.df[2,1]
x.df[-3,1]
x.df[2,] #all of row 2
x.df[,1] #all of column 1
x.df[2:3,]

x.df[,1]
x.df[,"xNum"]
x.df[2:3,c("xNum","xLog")]
names(x.df) #show all the name
x.df$xNum #by name

summary(x.df)
View(x.df)


View(iris)
summary(iris)

a <- c(1,2,3,4)
min(a)
x.df$xNum
max(x.df$xNum)
sum(a)
mean(a)


          
#Get the last 2 rows in last 2 columns from iris data frame.
nrow(iris)
ncol(iris)
iris[149:150,4:5]

iris[(nrow(iris)-1):nrow(iris),(ncol(iris)-1):ncol(iris)]

# Find out the average Petal length over all the observations.
mean(iris$Petal.Length)


# Find observations whose species are “versicolor”.
iris$Species=="versicolor"
iris[iris$Species=="versicolor",]


str(iris)


sex_vector <- c("F","M","F","M","F","M","F","M","F")
str(sex_vector)
summary(sex_vector)
factor_sex_vector <- factor(sex_vector) #from text to to factor
factor_sex_vector
str(factor_sex_vector)
summary(factor_sex_vector)


x.df <- read.csv("toy_example.csv", stringsAsFactors = TRUE)
str(x.df)

help.start()
help(mean)
?read.csv
example(mean)



library(ggplot2)
# install.packages("ggplot2")

View(mpg)
ggplot(data = mpg) + 
  geom_point(aes(x = displ, y = hwy, color = class)) +
  labs(y = "highway miles per gallon")


RM.df <- read.csv("RidingMowers.csv", stringsAsFactors = TRUE)
str(RM.df)
View(RM.df)
ggplot(data = RM.df) + 
  geom_point(aes(x = Income, y = Lot_Size, color = Ownership))

ggplot(data = mpg) + geom_bar(aes(x=class))

ggplot(data = mpg) + geom_bar(aes(x=class, y=hwy) ,
  stat = "summary", fun = "mean")



ggplot(data = RM.df) + geom_bar(aes(x=Ownership, y=Income) ,
                              stat = "summary", fun = "mean")




