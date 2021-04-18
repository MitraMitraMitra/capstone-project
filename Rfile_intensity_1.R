
library(data.table)
library(ggplot2)
#install.packages('bit64')
#install.packages("ggpubr")
library(bit64)
library(ggpubr)


PATH = 'C:/Users/jeanm/Documents/GitHub/data/sound_analysis/intensity/L01_intensity.csv'

# This FOR loop is used to read the data
# from all .csv files in the INTENSITY folder,
# generate time vs. value plots and append them
# to the MYPLOTS list
x <- c(1,2,3,4,5,6,9)
myplots <- list()
for (i in x) {
  substr(PATH,nchar(PATH)-14,nchar(PATH)-14) <- as.character(i)
  data = fread(PATH)
  data <- data[QualityGood == TRUE]
  myplots[[i]] <- local({
    i <- i
    p <- ggplot(data,aes(x=Timestamp,y=Value))+
    geom_point()
  })
}

# This command is used to create a new window;
# the plots will be displayed there.
dev.new()

ggarrange(plotlist = myplots, 
          labels = c("A", "B"),
          ncol = 3, nrow = 3)


# The DisplayValue column of the .csv files
# in the INTENSITY folder is of type CHAR,
# even though it stores numbers.
# So, if you ever want to work with that,
# make sure to run this command first:
# data <- transform(data, DisplayValue = as.numeric(DisplayValue))

# FUN FACT:
# The vast majority of rows in the 'L01_intensity.csv' file
# have the Quality parameter equal to 0, but some of them
# are equal to 1099511627776, which happens to be equal to
# the number of bytes in a terabyte, as a binary number. 

# To check the data, I recommend these commands:
#summary(data)
#View(data)
#str(data)

# Since we are working with more data than usual,
# you may want to clear the variables every now and then.
# You can just give this function
# whatever you want R to forget:
#rm(data)

# This command is useful to check the size of something:
#object.size(myplots)
