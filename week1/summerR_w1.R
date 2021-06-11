## INTRODUCTION ----
# welcome to your first R script! this is where you can write code to run as well as notes  
# to record your thoughts / directions for whatever you're coding. some basics: using the 
# '#' indicates non-executable code, i.e. notes to yourself. using the 'hashtag' on a new
# line will be your friend as you are annotating an R script

# if you want to write a piece of code, leave out the '#'. you'll notice that the text 
# color changes. since R is basically a fancy calculator, let's try code for simple math:

1+2
3*3
1277590030/900009

# above are three executable lines of code. to 'run' this code, navigate your cursor to the
# line you wish to run and click the 'run' button in the top right corner of this panel. 
# alternatively, if using a mac, you can use the shortcut 'command + return' to run a line
# give it a go on the above lines 10-12!

# you can also create variables using  '=' or '<-' 
X<-2
X=2
X

# and then you can do simple math on the variables you define, as follows: 
a <- 10
b <- 2

a*b
b/a
a^b
sin(a)
(sqrt(b))/(b*a)

# better yet, we aren't limited to just numbers! the notation is a bit different...
c <- c("cat")

# obviously we can't do math on these 'character strings' because, for instance, (cat*dog)
# is not well defined and we also can't learn much from it. but in our data, it can be useful
# to have characters, especially if we are using descriptive sample IDs (i.e., sample1)

# R is much more than an dinky calculator. you can write functions, assign variables to 
# insert into said functions, input data, build graphs, do statistical analyses, so on and 
# so forth. there are a million applications and the more you work with R, the more you 
# realize how much there is to learn!

## THE WORKSPACE ---- 
# there is a lot that you can do with R, tinkering around with the basic calculator functions
# or building your own variables. but for ecology, one of the prime uses of R is to bring
# in your data such that you can analyze and visualize it. that's what we will focus most of 
# our energy towards next 

# when working in R, it is best to start off by setting up and defining your workspace, 
# especially when you are bringing in your own data files

# the first step in this is to set a working directory, or where you will calling on your 
# files or datasheets in order to bring them into the R program. a single argument will  
# get you set up, as follows: 

setwd("/Users/abbeyyatsko/Desktop/week1")
# make sure you put your working directory in quotes such that R recognizes it! 
# this basically tells R that this is where you want it to look to retrieve data or where
# to place and locally store output data / figures

# this step can be different for everyone as you have to make sure that your pathname
# correctly navigates to where your week1 folder for summerR is stored locally

# next, let's do some housecleaning to set up the workspace: 

# this line clears your global environment (top right panel), basically ensuring that you begin 
# with a clean slate as you bring in your data and functions:
rm(list=ls())

# another part of setting up the workspace is installing and loading relevant 'packages' for 
# your script. these packages are basically extensions of R that cater to a specific purpose, 
# such as graphing or statistical packages. we will get more into these with specific applications, 
# but I like to set them up in my R script early so that they are neatly organized and all 
# loaded properly before I get going!

# here's an example package called 'ggplot2', which is used for generating graphs and very polished
# data viz. first we have to install the package, and then once it is installed, we call on it 
# in the 'library' to make sure it is loaded and ready to go 
install.packages("ggplot2")
library(ggplot2)

# now, let's bring in some data. say you have a data set in excel that you want to do some basic
# stats on / exploration of content. since we already set our working directory in the week1 
# folder, R knows to look there for the file that we want to bring in 

# let's explore the doggies.csv data set! to do this, we need to 'read in' the file 
read.csv("doggies.csv")

# let's put this dataset into an object so that we can look at it easier: 
doggies <- read.csv("doggies.csv")

# note that .csv is easiest to work with / the convention for dataframes inputted to R. you can
# also use .txt and .xls but it's kinda a hassel and its best to just get in the habit of 
# working with .csv 

# THE DATA ----
# there are many different options for (pre)viewing your data, give em a try:
View(doggies)
head(doggies)
tail(doggies)
colnames(doggies)
length(doggies)
length(doggies$age_yr)

# you can also use indexing to identify a specific value (or range of values) within your 
# data frame: 

# what is the entry found in row 1, column 2?
doggies[1,2]

# what are all of the entries in the second column (breed)?
doggies[,2]

# to call on a specific column, we can use the '$' to link the dataframe to the column of 
# interest. here's an example, where we look to find the average age of all of the dogs: 
mean(doggies$age_yr)

# we can also do this for other descriptive statistics: 
max(doggies$age_yr)
min(doggies$age_yr)
range(doggies$age_yr)
sd(doggies$age_yr)

# try this one out: 
max(doggies$owner)

# but wait, does that make sense? what would the maximum value be for a character response? 
# another thing that we can use R for is to understand the structure of the data. how are 
# different entries being understood by R - are they numbers, values, characters...? let's 
# as R about structure using the str() command 
str(doggies)

# we see that there are characters, intergers, and numerical values in this dataframe. we can 
# transition the class of some of these variables if need be: 

doggies$weight_lb <- as.numeric(doggies$weight_lb)
str(doggies)
# what changed? 

# we can also add or rename columns in our dataframe. to rename a column: 
colnames(doggies)[5] <-"treat"
doggies

# to add a column: 
doggies$species <- "Canis lupus familiaris"
View(doggies)

# we can also take a peak at what this data looks by using graphical visualization
# run these lines to get a deeper look into what the data shapes up to be 

# distribution of dog ages 
boxplot(doggies$age_yr)

# distribution of dog age based on females v. male owners
boxplot(doggies$age_yr~doggies$owner,col=heat.colors(2))

# see what the dog's treat preferences are 
counts <- table(doggies$treat)
barplot(counts, xlab="preferred treat")

# see what the dog's treat preferences are by owner
counts <- table(doggies$owner, doggies$treat)
barplot(counts, xlab="preferred treat", legend = rownames(counts))

# doing more with boxplots to look at data distribution and summary statistics
boxplot(weight_lb ~ exercise, data = doggies, frame = FALSE)

# much more can be done with graphing outside of 'base R' functions (what we have 
# been using above). for example, this is where the ggplot2 package can come in! 

# explore the doggies dataset a bit more. see what the average tail length is, 
# or make a graph showing the distribution of what states the dogs are from. 
# have fun with it! 

# since we added a 'species' column to our dataframe in R, we might want to 
# export the dataframe now that it is updated with new information. to do this: 
write.csv(doggies,"/Users/abbeyyatsko/Desktop/week1/dogggies_new.csv", row.names = FALSE)

# you can also save images that you generated in the viewer panel (bottom right)
# by exporting them as images or pdf files 

# in R, you can always continually build your coding skills - more next time!
