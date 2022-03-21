path_to_raw <- "/Users/oliviabeck/Dropbox/Olivia/Conflict/school/SODA501/FinalProject_SODA501/RawData"
####################
#everything below is the function 
#############
path_no_slash <- path_to_raw
path_w_slash <- paste(path_to_raw, "/", sep = "")

#Get Names of Files to upload 
#upload data to one file
temp <- list.files(path = path_no_slash, 
                   pattern="*.csv")
file_list <- paste(path = path_w_slash, 
                   temp,
                   sep="")

#Retrieve data into data frame 
all_data <-ldply(file_list, read_csv)

##################################
#####Testing
################################

samp_rows <- c(1:30, sample(1:(dim(all_data)[1]), 250))
data_test_orig <- all_data[samp_rows, ]

colnames(data_test)

#we will eventually want to select these later 
#we will need to filter by line_item but idk which ones are what right now so i'm just ignore them, can easily be added later

#filter dates - probably need to change these
data_test <- data_test_orig %>%
  #get columns we want
  select(committee_name...2, report_year, entity_type, contributor_name, 
         contribution_receipt_amount, fec_election_year,
         donor_committee_name, fec_election_type_desc
         ) %>%
  #chage to date format
  mutate(fec_election_year = as.numeric(fec_election_year)) %>%
  #filter out dates 
  filter(fec_election_year <= "2022" & fec_election_year >= "2012") %>%
  #nest by senator and donor
  group_by(committee_name...2, contributor_name, fec_election_year) %>%
  nest() %>%
  #Get total contributions
  mutate(total_contribution = map_dbl(.x=data, .f = get_total)) %>%
  #Get number of contributions
  mutate(total_number = map_dbl(.x=data, .f = nrow ))%>%
  #Get donor type
  mutate(donor_type = map_chr(.x=data, .f = get_type))
  
