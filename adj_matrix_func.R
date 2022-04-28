#load in data

load("Olivia_Data.Rdata")
olivia_dat <- summarized_data
rm(summarized_data)


make_adj_matix <- function(data, senators = NULL, 
                           years = NULL, elec_type= NULL, 
                           min_cont = 1, max_cont = 1e12, 
                           min_times = 1, max_times = 1e10,
                           donor_type = NULL){
  ####INPUTS
  # data : all data we want to make a network on, this is the output from the MapReduce funciton
  # senators: list of senators we want to consider, if null we want to consider all senators from data 
  # years : list of years we want to consider, null if we want to consider all years in data
  # elec_type : type(s) of election we want to consider, null if we want to consider all election types in data, options are "CONVENTION" "FOR 2000"   "GENERAL"    "PRIMARY"    "RUNOFF"     "SPECIAL"  
  # min_cont : minimum total contribution from contributor we want to consider, default = 1
  # max_cont : maximum total contribution from contributor we want to consider, default = 1e10
  # min_times : minimum number of times a contributor donated to a single senator we want to consider, default = 1
  # max_times : maximum number of times a contributor donated to a single senator we want to consider, default = 1e5
  # donor_type : list of types of donars we want to consider, if null we consider all types in data, options are PAC, COM, IND, ORG, CCM, PTY
  
  #### Output
  # an adjacent matrix for a network with the specified filtering criteria 
  # matrix is underircted
  # nodes are senators
  # weights on edges are the number of donors two senators have in common. 
  
  
  
  ########## Data filtering stage ################
  
  ##### First get filters from inputs , to be used in Tidyverse stage 
  
  #senator list 
  if(is.null(senators)){
    senator_list <- unique(data$senator_name)
  }else{
    senator_list <- senators
  }
  
  #years
  if(is.null(years)){
    year_list <- unique(data$fec_election_year)
  }else{
    year_list <- years
  }
  
  #election type
  if(is.null(elec_type)){
    electype_list <- unique(data$fec_election_type_desc)
  }else{
    electype_list <- elec_type
  }
  
  #donor type
  if(is.null(donor_type)){
    donortype_list <- unique(data$donor_type)
  }else{
    donortype_list <- donor_type
  }
  
  
  #### Next do TidyVerse to filter data to our specifications 
  
  dat_filter <- data %>%
    filter(senator_name %in% senator_list, 
           fec_election_year >= min(year_list) & fec_election_year <= max(year_list), 
           fec_election_type_desc %in% electype_list, 
           total_contribution >= min_cont & total_contribution<= max_cont,
           total_number >= min_times & total_number <= max_times, 
           donor_type %in% donortype_list)
  
  
  ############### Making Adj Matrix #############
  
  n <- length(senator_list)
  adj_matrix<- matrix(0, nrow =n, ncol = n )
  
  #get Upper triangular matrix
  for(i in 1:(n-1)){ # row senator
    #get unique contributors for i^th senator 
    i_senator <- senator_list[i]
    i_donars <- unique(dat_filter$contributor_name[dat_filter$senator_name == i_senator])
    for(j in (i+1):n){#column senator
      j_senator <- senator_list[j]
      j_donars <- unique(dat_filter$contributor_name[dat_filter$senator_name == j_senator])
      #find the number of matches
      matches <- sum(i_donars %in% j_donars)
      #get the 
      adj_matrix[i, j] <- matches 
    }
  }
  
  #make a full adj matrix 
  adj_matrix <- (adj_matrix + t(adj_matrix))
  
  return(adj_matrix)

}

test_output1 <- make_adj_matix(data = olivia_dat, min_cont = 5000)  
test_output2 <- make_adj_matix(data = olivia_dat, donor_type = c("PAC"))  

small_donor_matrix <-  make_adj_matix(data = dat_all, donor_type = c("IND"), max_cont = 500)  
everything_matrix <-  make_adj_matix(data = dat_all)  


head(test_output1)
head(test_output2)

