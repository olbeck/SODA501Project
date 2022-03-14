library(tidyverse)

us_senate <- read_csv("~/OneDrive - The Pennsylvania State University/501Project/us-senate.csv")

sen_names <- sort(us_senate$name)

#Olivia 1- 33
#Tyler 34 - 66 
#Joe 67 - 100

#save data file in senator_raw_data as: 
#firstname_last.csv 

temp = list.files(pattern="*.csv")
myfiles = lapply(temp, read.delim)
