library(readr)
library(plyr)
library(dplyr)
library(tidyr)
library(purrr)

######################
### Internal Functions
######################

get_total <- function(frame){
  #get correct column name
  c_name <- which(colnames(frame) == "contribution_receipt_amount")
  
  #get total campaign contribution
  total <- sum(frame[ , c_name])
  
  return(total)
}

get_type <- function(frame){
  c_name <-  which(colnames(frame) == "entity_type")
  type <- unique(frame[, c_name])
  type <- na.omit(type)
  return(as.character(type))
}

#####################
### Main Function
###################

MapReduce <- function(path_to_raw ){
  
  ##### Inputs:
  #path_to_raw - where raw data is located, no "/" at the end
  
  #### Outputs: 
  # reduced data frame 
  
  #Get path
  path_no_slash <- path_to_raw
  path_w_slash <- paste(path_to_raw, "/", sep = "")
  
  #Get Names of Files to upload 
  #upload data to one file
  temp <- list.files(path = path_no_slash, 
                     pattern="*.csv")
  temp_no_csv <- gsub(".csv", "", temp)
  file_list <- paste(path = path_w_slash, 
                     temp,
                     sep="")
  names(file_list) <- temp_no_csv
  
  #Retrieve data into data frame 
  all_data <- map(file_list, function(x) {read_csv(x, col_types = list(.default = "c"))})
  all_data <- pmap(list(all_data, names(all_data)),
                   function(df, name) {
                     df %>%
                       mutate(senator_name = name,
                              across(everything(), ~as.character(.x)))
                   })
  all_data <- bind_rows(all_data)
  
  #data manipulation 
  data_test <- all_data %>%
    #get columns we want might want to change these eventually
    select(senator_name, report_year, entity_type, contributor_name, 
           contribution_receipt_amount, fec_election_year,
           donor_committee_name, fec_election_type_desc, 
           contributor_street_1, contributor_zip #these two used for linking purposes
    ) %>%
    #filter out dates 
    mutate(fec_election_year = as.numeric(fec_election_year)) %>%
    filter(fec_election_year <= "2022" & fec_election_year >= "2012") %>%
    #change variable types
    mutate(contribution_receipt_amount = as.numeric(contribution_receipt_amount)) %>%
    #nest by senator and donor
    group_by(senator_name, contributor_name, fec_election_year, fec_election_type_desc,
             contributor_street_1, contributor_zip) %>%
    nest() %>%
    #Get total contributions
    mutate(total_contribution = map_dbl(.x=data, .f = get_total)) %>%
    #Get number of contributions
    mutate(total_number = map_dbl(.x=data, .f = nrow ))%>%
    #Get donor type
    mutate(donor_type = map_chr(.x=data, .f = get_type)) %>%
    #Select only the things we care about.
    select( ! c(data )) %>%
    ungroup() %>%
    select(!c(contributor_street_1, contributor_zip))
  
  return(data_test)
}
