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

# PLOTS WITH MTCARS ----
# https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/mtcars.html
# plotting in ggplot can be thought of as a piece-by-piece process. you oftentimes start off with the 
# same format... 
# ggplot(data = , aes(x = , y = ))+
#   (whatever graph type you are wanting)

# an example probably serves better! let's make a basic scatter plot: 
ggplot(data = cars, aes(x = wt, y = mpg)) + 
  geom_point()

# change the point size, and shape
ggplot(cars, aes(x = wt, y = mpg)) +
  geom_point(size = 2, shape = 23)

# change the color and the point by the levels of cyl variable
ggplot(cars, aes(x = wt, y = mpg)) + 
  geom_point(aes(color = cyl, shape = cyl)) 

# change color manually
ggplot(cars, aes(x = wt, y = mpg)) + 
  geom_point(aes(color = cyl, shape = cyl)) +
  scale_color_manual(values = c("#999999", "#E69F00", "#56B4E9"))+
  theme_minimal()

# add regression line for each level of the cyl variable 
ggplot(cars, aes(x = wt, y = mpg)) + 
  geom_point(aes(color=cyl, shape=cyl)) + 
  geom_smooth(aes(color=cyl, shape=cyl), 
              method=lm, se=FALSE, fullrange=TRUE)

# add a bit more info to the plot - basic scatter plot like above, but now points are the 'sample' names 
ggplot(data = cars, aes(x = wt, y = mpg)) + 
  geom_text(aes(label = rownames(mtcars)))

# PLOTS WITH TOOTHGROWTH 
# https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/ToothGrowth.html
tooth <- ToothGrowth
str(tooth)
tooth$dose <- as.factor(tooth$dose)

# making a 'base' graph that we can build off of 
e <- ggplot(tooth, aes(x = dose, y = len))

# default plot
e + geom_boxplot()
# notched box plot
e + geom_boxplot(notch = TRUE)
# color by group (dose)
e + geom_boxplot(aes(color = dose))
# change fill color by group (dose)
e + geom_boxplot(aes(fill = dose))

# box plot with multiple groups
ggplot(tooth, aes(x=dose, y=len, fill=supp)) +
  geom_boxplot()

# look at boxplot with individual points overlaid (dotplot)
e + geom_boxplot() + 
  geom_dotplot(binaxis = "y", stackdir = "center") 

# lets do some bar charts too, just to see what those look like 
# we start by creating a simple bar plot (named f) using the df data set:
f <- ggplot(tooth, aes(x = dose, y = len))

# basic bar plot
f + geom_bar(stat = "identity")

# change fill color and add labels
f + geom_bar(stat="identity", fill="steelblue")+
  theme_minimal()

# Change bar plot fill colors by groups
f + geom_bar(aes(fill = dose), stat="identity")

# for a bar plot with multiple groups: make a new base graph: 
g <- ggplot(data=tooth, aes(x=dose, y=len, fill=supp)) 

# stacked bar plot
g + geom_bar(stat = "identity")

# use position=position_dodge()
g + geom_bar(stat="identity", position=position_dodge())

# add some error bars (this is important for ecology!)
# first we have to define what exactly the error bars are, and that requires us adding sd to the 
# dataframe (so that we have values for how to calculate the actual error)

# install.packages("dplyr")
library(dplyr)
df.summary <- tooth %>%
  group_by(dose) %>%
  summarise(
    sd = sd(len, na.rm = TRUE),
    len = mean(len)
  )
df.summary
str(df.summary)

# now we will use this new dataframe (which includes sd, a summary stat we need in order to produce 
# error bars) to generate a boxplot
f <- ggplot(df.summary, aes(x = dose, y = len, 
                     ymin = len-sd, ymax = len+sd))

# then combine with bar plot, color by groups
f + geom_bar(aes(color = dose), stat = "identity", fill ="white") + 
  geom_errorbar(aes(color = dose), width = 0.2)


# MAP APPLICATION ---- 
# first prepare the data
# https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/USArrests.html
crimes <- data.frame(state = tolower(rownames(USArrests)), 
                     USArrests)
install.packages("reshape2")
library(reshape2) # for melt
crimesm <- melt(crimes, id = 1)
# Get map data
require(maps) 
map_data <- map_data("state")
# Plot the map with Murder data
ggplot(crimes, aes(map_id = state)) + 
  geom_map(aes(fill = Murder), map = map_data) + 
  expand_limits(x = map_data$long, y = map_data$lat)
