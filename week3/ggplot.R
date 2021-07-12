# week 3: ggplot2 tutorial 

# INTRODUCTION ---- 
# data visualization and graphing is a big part of telling your scientific story. a good figure can 
# really get a point across, sometimes better than words ever could! ggplot2 is a package in R that 
# is incredibly useful for data visualization. it is easy to use and has so many layers to it, so 
# there is always something new to explore. also there are great online resources for troubleshooting 
# your graphing code and also figuring out what kind of plot would be best for the data that you have 
# on hand. 

# install ggplot2 and bring it into the library here: 
# install.packages("ggplot2")
library(ggplot2)

# this week we will be using some data that is a part of 'base R'. this means that we don't have to load 
# in any data and instead we can just call on it in R and then begin to work with it. this is a convenient
# way to demo things in R so that you don't have to find or create a dataset that is robust and works 
# for whatever skill you are trying to learn in coding 

# INTERLUDE ----
# just as a review, IF we were using our own data and NOT that in 'base R', what are the steps we would
# take to begin? 

# 1. set the working directory! see example on the line below 
# setwd("/Users/abbeyyatsko/Desktop/repos/summerR/week3")

# 2. read in your .csv! see below (note that this data doesnt actually exist but this is the way that you 
# would call on the information)
# data <- read.csv("data.csv")

# LOAD DATA FOR GGPLOT ---- 
# all of the base R dataframes are available here (https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/00Index.html)
# there's a lot of them! sometimes it can be useful to read up on the datasets here so that you can 
# understand the context of what is going on (metadata). 

# we will use a 'teaching R classic' - the mtcars dataset! bring it in for use like this: 
cars <- mtcars
# look at and think about data structure:
str(cars)
cars$cyl <- as.factor(cars$cyl)

# thinking about the meaning of some of the variables...
# [, 1] mpg Miles/(US) gallon
# [, 2] cyl Number of cylinders
# [, 3] wt Weight (lb/1000)



