
library(data.table)
library(plot3D)
#install.packages("plot3D")
library(plot3D)
library(plyr)
library(readr)


data_files <- list.files("C:/Users/jeanm/Documents/GitHub/data/sound_analysis/SFFT/Sep 14/unzipped")  # Identify file names
data_files
length(data_files)

#setwd("C:/Users/jeanm/Documents/GitHub/data/sound_analysis/SFFT/Sep 14")
#dat_csv = ldply(data_files[1:10], read_csv)
#dat_csv


View(dat_csv)



PATH <- 'C:/Users/jeanm/Documents/GitHub/data/sound_analysis/SFFT/Sep 14/unzipped/20200914T001000.csv'
dt <- fread(PATH)
View(dt)
summary(dt)
#apply(dt, 2, function(x) any(is.na(x)))
#x <- c(0:235)
x <- data_files[0:50]
final <- list()
PATH <- 'C:/Users/jeanm/Documents/GitHub/data/sound_analysis/SFFT/Sep 14/unzipped/'
for (i in data_files)
{
  dat_csv = fread(paste(PATH,i,sep=''))
  dat_csv[,aggr_secs := as.POSIXct(trunc(V1, "secs"))]
  dt<-dat_csv[, lapply(.SD, mean), by=aggr_secs]
  
  #data = fread(i)
  print(dat_csv)
  print(length(dat_csv))
  #print(i)
  final[length(final)+1] <- dt

}

length(final)
View(final[1])

#na <- colSums(is.na(dat_csv))
#na_df <- data.frame(na)
#na_df[!na_df$na %in% c(0), ]



data = fread('C:/Users/jeanm/Documents/GitHub/data/sound_analysis/SFFT/20200914T000000.csv')


data[,aggr_secs := as.POSIXct(trunc(V1, "secs"))]
dt<-data[, lapply(.SD, mean), by=aggr_secs]

View(dt)
View(data)
y <- colnames(dt)[2:514]

melt(dt,dt$V1,y)

# Aggregate FFT
# dB or amplitude?
# Merge with the Commands
# FFT V*: Input Variables
# Command: Response Variables
# Timestamp V1 v2 v3.... Command1 Command2 Command3 ...
# setnafill() with locf
# Classification problem

# Merge with the Intensities
# FFT V*: Input Variables
# Intensities: Response Variables (numeric)
# Timestamp V1 v2 v3.... Command1 Command2 Command3 ...
# setnafill() with locf
# Regression problem



WIDE> 
ts x1 x2 x3
1   1 2  3

LONG 
ts var val
1  x1  1
1  x2  2
1  x3  3

View(data)

x1 <- 'g'
first_row <- data[1,]
#i <- 2
#first_row[[i]]
first_row <- subset(first_row, select=2:4)
first_row[1,2]
second_row <- data[2,]
second_row <- subset(second_row, select=2:4)
second_row
first_column <- data$V1
first_column

line <- data[5,]
line[,1]
typeof(line[,1])
column_indexes <- c(1:3)
points <- list()
for (i in column_indexes)
{
  points[[i]] <- local({
    i <- i
    x <- c(line[,1],unlist(line[[i]]),unlist(first_row[[i]]))
  })
  
}
typeof(line[[1]])
points

dev.new()
points[,1]
time_axis <- list()
for (i in points)
{
  time_axis <- local({
    i <- i
  })
}
View(points)

typeof(points[1])
plot(points)
x


