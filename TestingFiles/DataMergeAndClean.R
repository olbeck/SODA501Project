
#Load Data
load("~/Dropbox/Olivia/Conflict/school/SODA501/FinalProject_SODA501/SODA501Project/Mitch_Data.Rdata")
mitch_dat <- summarized_data

load("~/Dropbox/Olivia/Conflict/school/SODA501/FinalProject_SODA501/SODA501Project/Olivia_Data.Rdata")
olivia_dat <- summarized_data

load("~/Dropbox/Olivia/Conflict/school/SODA501/FinalProject_SODA501/SODA501Project/Joe_Data.Rdata")
joe_dat <- summarized_data

rm(summarized_data)

#Merge Data
dat_all <- rbind(joe_dat, mitch_dat, olivia_dat)

rm(joe_dat, mitch_dat, olivia_dat)


#Cleaning Data