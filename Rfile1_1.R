
library(data.table)
library(ggplot2)
library(plotly)
library(seewave)

data = fread('C:/Users/jeanm/Documents/GitHub/data/sound_analysis/SFFT/20200914T000000.csv')
View(data)

first_row <- data[1,]
first_row <- subset(first_row, select=2:514)

x <- as.numeric(first_row)

plot(first_row)

time <- data$V1
time
length(time)
v2 <- data$V2
length(v2)
v3 <- data$V3
d <- melt(data, id.vars="V1")


dev.new()
plot(time,v2)
ggplot(data, aes(x=V1, y=V2) ) +
  geom_point()


str(data)
# COLUMN
x <- as.numeric(unlist(data[,0]))
x <- data[,1]
summary(x)
x[2]
typeof(x[2])

mean(x)

plot(x)

# ROW
x <- as.numeric(data[18,])
x <- x[2:length(x)]
plot(x)

hist(x,120)

str(data)
x <- data[2,]
plot(x)
length(data[])
hist(data$V2)


#plot(data)
