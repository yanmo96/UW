# install.packages("tm")
library(tm)

# define vector of sentences ("docs")
text <- c("this is the first     sentence!!", 
          "this is a second Sentence :)", 
          "the third sentence, is here", 
          "forth of all 4 sentences")


# convert documents into a corpus
corp <- Corpus(VectorSource(text))

inspect(corp)

corp <- tm_map(corp, tolower)
corp <- tm_map(corp, removeNumbers)
corp <- tm_map(corp, removePunctuation)
corp <- tm_map(corp, removeWords, stopwords("english"))
corp <- tm_map(corp, stripWhitespace)

inspect(corp)



# stemming
# install.packages("SnowballC")
library(SnowballC)
corp <- tm_map(corp, stemDocument) 

inspect(corp)



# find out Term-Document matirx based on Term Frequency
dtm <- DocumentTermMatrix(corp)
inspect(dtm)

# find out tf-idf
tfidf <- weightTfIdf(dtm)
inspect(tfidf)


# ==============================================================================
# practice

reviews <- read.csv("reviews.csv")
View(reviews)
# convert documents into a corpus
corp <- Corpus(VectorSource(reviews[,4]))

inspect(corp)

corp <- tm_map(corp, tolower)
corp <- tm_map(corp, removeNumbers)
corp <- tm_map(corp, removePunctuation)
corp <- tm_map(corp, removeWords, stopwords("english"))
corp <- tm_map(corp, stripWhitespace)

inspect(corp)

corp <- tm_map(corp, stemDocument) 

# find out Term-Document matirx based on Term Frequency
dtm <- DocumentTermMatrix(corp)
inspect(dtm)

# find out tf-idf
tfidf <- weightTfIdf(dtm)
inspect(tfidf)

tfidf <- removeSparseTerms(tfidf, 0.93)
inspect(tfidf)


review.df <- data.frame(as.matrix(tfidf), Recommended = reviews$Recommended)

#View(review.df)
#str(review.df)
set.seed(1)

train.index <- sample(1:nrow(review.df), nrow(review.df)*0.6)
train.df <- review.df[train.index,]
valid.df <- review.df[-train.index,]

logit.reg <- glm(Recommended ~., data = train.df, family = "binomial")
summary(logit.reg)

logit.reg.pred <- predict(logit.reg, valid.df, type = "response")

pred <- ifelse(logit.reg.pred > 0.5, 1,0)

library(caret)
confusionMatrix(factor(pred), factor(valid.df$Recommended), positive = "1")

#install.packages("wordcloud")
library(wordcloud)

m <- as.matrix(tfidf)

v <- sort(colSums(m),decreasing = TRUE)
importance <- data.frame(word = names(v), tfidf = v)
wordcloud(importance$word, importance$tfidf, random.order = FALSE, max.words = 100, colors =brewer.pal(8,"Dark2"))
