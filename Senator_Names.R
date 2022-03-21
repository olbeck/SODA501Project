library(tidyverse)
library(readr)
library(plyr)

us_senate <-  read_csv("~/OneDrive - The Pennsylvania State University/501Project/us-senate.csv")

sen_names <- sort(us_senate$name)

#Olivia 1- 33
#Tyler 34 - 66 
#Joe 67 - 100

#save data file in senator_raw_data as: 
#firstname_last.csv 

#upload data to one file
temp <- list.files(path = "/Users/oliviabeck/Dropbox/Olivia/Conflict/school/SODA501/FinalProject_SODA501/RawData", 
                   pattern="*.csv")

file_list <- paste("/Users/oliviabeck/Dropbox/Olivia/Conflict/school/SODA501/FinalProject_SODA501/RawData/", 
                   temp,
                   sep="")

all_data <-ldply(file_list, read_csv)



#save as r object

#Notes
#jack reed - legal name is john reed'
