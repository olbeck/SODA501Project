
#Load Data
load("~/Dropbox/Olivia/Conflict/school/SODA501/FinalProject_SODA501/SODA501Project/Mitch_Data.Rdata")
mitch_dat <- mitch_Data

load("~/Dropbox/Olivia/Conflict/school/SODA501/FinalProject_SODA501/SODA501Project/Olivia_Data.Rdata")
olivia_dat <- summarized_data

load("~/Dropbox/Olivia/Conflict/school/SODA501/FinalProject_SODA501/SODA501Project/Joe_Tyler_Data.Rdata")
joe_dat <- summarized_data

rm(summarized_data)

#Merge Data
dat_all[dat_all$senator_name %in% unique(mitch_Data$senator_name), "senator_name"] <- "mitch_mcconnell"



dat_all <- rbind(joe_dat, mitch_dat, olivia_dat)

rm(joe_dat, mitch_dat, olivia_dat)

save(dat_all, file = "/Users/oliviabeck/Dropbox/Olivia/Conflict/school/SODA501/FinalProject_SODA501/SODA501Project/All_Data.Rdata")

#Cleaning Data

#Change Mitch Mcconnells name 
sort(unique(dat_all$senator_name))
unique(mitch_Data$senator_name)
dat_all[dat_all$senator_name %in% unique(mitch_Data$senator_name), "senator_name"] <- "mitch_mcconnell"

#Chaging raphael_warnock1 and raphael_warnock2 to just raphael_warnock1
dat_all[dat_all$senator_name %in% c("raphael_warnock1", "raphael_warnock2"), "senator_name"] <- "raphael_warnock"



#somehow we only have 96 names? 
data.frame(c(sort(unique(dat_all$senator_name)), NA, NA, NA, NA),
           sen_names)
#missing Mike Rounds,  Richard Durbin, Robert Casey, Robert Menendez



######################### 
# Still missing 1 senator : Mike Rounds
cbind(c(sort( unique(dat_all$senator_name)), NA    ) , sen_names)

#file_location
loc <- "/Users/oliviabeck/Dropbox/Olivia/Conflict/school/SODA501/FinalProject_SODA501/MikeRounds"

rounds_data <- MapReduce(loc)
save(rounds_data, file = "/Users/oliviabeck/Dropbox/Olivia/Conflict/school/SODA501/FinalProject_SODA501/SODA501Project/Mike_Data.Rdata")

