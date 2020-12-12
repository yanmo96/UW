?diamonds
View(diamonds)

#2
ggplot(data = diamonds) + 
  geom_point(aes(x = carat, y = price))

#3
ggplot(data = diamonds) + 
  geom_point(aes(x = carat, y = price, color=cut))

ggplot(data = diamonds) + 
  geom_point(aes(x = carat, y = price, color=clarity))

ggplot(data = diamonds) + 
  geom_point(aes(x = carat, y = price, color=color))

#4
ggplot(data = diamonds) + geom_bar(aes(x=cut, y=price) ,
                                stat = "summary", fun = "mean")

#5
ggplot(data = diamonds) + geom_bar(aes(x=cut))

#6
ggplot(data = diamonds) + geom_bar(aes(x=cut, y=carat) ,
                                   stat = "summary", fun = "mean")
                                   