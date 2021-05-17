library(tidyverse)

#dev.off()
data <- read_csv("~/Desktop/sound_analysis/sound_analysis/SFFT/SFFT_Sept_14/20200914T000000.csv")

View(data)

head(data)

nums <- data %>% select(2:length(data))

df <- data_frame(nums)
matr <- data.matrix(df)

#heatmap(matr) # Bad idea, to many categories for that
plot(matr)

data_2 <- read_csv("~/Desktop/sound_analysis/sound_analysis/SFFT/SFFT_Sept_14/20200914T001000.csv")

par(mfrow=c(1,2))
plot(data.matrix(data))
plot(data.matrix(data_2))

#install.packages("DataExplorer")
library(DataExplorer)

#DataExplorer::create_report(data %>% select(2:length(data)))

#hist(data$`21.533203125`, bins = 100, breaks = "secs")

na <- colSums(is.na(data))
na_df <- data.frame(na)
na_df[!na_df$na %in% c(0), ]


data_files <- list.files("~/Desktop/sound_analysis/sound_analysis/SFFT/SFFT_Sept_14/")  # Identify file names
data_files                                                    # Print file names
# "data1.csv" "data2.csv" "data3.csv"

#for(i in 1:length(data_files)) {                              # Head of for-loop
#   assign(paste0("data", i),                                   # Read and store data frames
#         read.csv2(paste0("~/Desktop/sound_analysis/sound_analysis/SFFT/SFFT_Sept_14/",
#                          data_files[i])))
#}

library(plyr)
library(readr)
library(data.table)
#setwd("~/Desktop/sound_analysis/sound_analysis/SFFT/SFFT_Sept_14/")
#dat_csv = ldply(data_files[1:10], read_csv)
#dat_csv

#dat_csv <- as.data.table(dat_csv)

#colnames(dat_csv)
#dat_csv[,aggr_secs := as.POSIXct(trunc(X1, "secs"))]
#dt<-dat_csv[, lapply(.SD, mean), by=aggr_secs]


#final <- list()
#num <- c(0:14)
#for (i in data_files[0:14]) {
#  dat_csv = ldply(i, read_csv)
#  dat_csv <- as.data.table(dat_csv)
#  dat_csv[,aggr_secs := as.POSIXct(trunc(X1, "secs"))]
#  dt<-dat_csv[, lapply(.SD, mean), by=aggr_secs]
#  append(final, dt, after = length(final))
  ##final[length(final)+1] <- dt
#}

#final


#dat_csv1 = ldply(data_files[0:50], read_csv)
#dat_csv2 = ldply(data_files[51:100], read_csv)
#dat_csv3 = ldply(data_files[100:144], read_csv)



#na <- colSums(is.na(dat_csv))
#na_df <- data.frame(na)
#na_df[!na_df$na %in% c(0), ]



#int <- read_csv("../../intensity/L01_intensity.csv")

#int_files <- list.files("~/Desktop/sound_analysis/sound_analysis/intensity/")  # Identify file names

#setwd("~/Desktop/sound_analysis/sound_analysis/intensity/")
#int_csv = ldply(int_files, read_csv)
#int_csv


#na_int <- colSums(is.na(int_csv))
#na_df_int <- data.frame(na_int)
#na_df_int[!na_df$na %in% c(0), ]

#dpv <- int_csv$DisplayValue

#a <- as.matrix(data)


## Shrinking the Data

#convert matrix from char to num, ignore warnings, they are due to NAs
#class(a) <- "numeric" 

#adapted from @flodel https://stackoverflow.com/a/16884987/680068
#res <- tapply(a, list((row(a) + 1L) %/% 2L, (col(a) + 1L) %/% 2L), mean, na.rm = TRUE)

# remove NANs
#res[ is.nan(res) ] <- NA
#res




# PATH FOR INTENSITY FILES
#setwd("C:/Users/jeanm/Documents/GitHub/data/sound_analysis/intensity")
# PATH FOR SFFT FILES
setwd("C:/Users/jeanm/Documents/GitHub/data/sound_analysis/SFFT/Sep 14/unzipped")


# Reading many files at once (one day - 144 files)
# The traditional way
system.time({
  myfiles <- list.files(path = "./",pattern = "20200914T.*csv", full.names = T)
  dt <- lapply(myfiles, function(x) fread(x, header = TRUE))
  dt <- rbindlist(dt)
}) # Takes 256 seconds in my PC
# The optimized way (unzipping is done outside R by the OS in parallel)
# You may need to install gzip. I have it perhaps because it came with 7zip.
str(dt)
View(dt)



#system.time({
#  myfiles <- list.files(path = "./",pattern = "20200914T.*csv", full.names = T)
#  dt2 <- lapply(myfiles, function(x) fread(cmd = paste("gzip -cd", x), header = TRUE))
#  dt2 <- rbindlist(dt2)
#}) # Takes 39 seconds in my PC


dt[,aggr_secs := as.POSIXct(trunc(V1, "secs"))]
dt<-dt[, lapply(.SD, mean), by=aggr_secs]



system.time({
  myfiles <- list.files(path = "./",pattern = "L*.csv", full.names = T)
  dt_in <- lapply(myfiles, function(x) fread(x, header = TRUE))
  dt_in <- rbindlist(dt_in)
})

#data3 <- dt_in[is.na(dt_in) == 0, ]
dt_in <- na.omit(dt_in)
dt_in <- dt_in[QualityGood == "TRUE"]

dt_in[,aggr_secs := as.POSIXct(trunc(Timestamp, "secs"))]

dt_in$DisplayValue <- as.numeric(dt_in$DisplayValue)

dt_in<-dt_in[, lapply(.SD, mean), by=aggr_secs]

str(dt_in)
summary(dt_in)



system.time({
  myfiles <- list.files(path = "./",pattern = "L*.csv", full.names = T)
  dt_in <- lapply(myfiles, function(x) fread(x, header = TRUE))
  dt_in <- rbindlist(dt_in)
})

#data3 <- dt_in[is.na(dt_in) == 0, ]
dt_in <- na.omit(dt_in)
dt_in <- dt_in[QualityGood == "TRUE"]

dt_in[,aggr_secs := as.POSIXct(trunc(Timestamp, "secs"))]

dt_in$DisplayValue <- as.numeric(dt_in$DisplayValue)

dt_in<-dt_in[, lapply(.SD, mean), by=aggr_secs]

str(dt_in)
summary(dt_in)


date <- "2020-09-14"
time <- "10:34:35"
as.POSIXct(paste(date,time))

x <- '05'
as.numeric(x)
