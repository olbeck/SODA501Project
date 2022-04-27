#funtion to list the most simliar other senators for each senator

list_similar <- function(adj_matrix, senators){
  #### INPUTS
  # adj_matix : adjacent matrix, output of make_adj_matrix, n-by-n matrix
  # senator : input of senator names used in adj_matrix, length n
  
  #### Output
  # data frame where columns are senators, and the list below is which senators share the most donors
  d <- length(senators)
  similar_mat <- data.frame(matrix(NA, nrow = d, ncol = d))
  colnames(similar_mat) <- senators
  
  for(i in 1:d){
    row <- matrix(adj_matrix[i, ], nrow=1)
    colnames(row) <- senators
    sort_nums <- sort(row[1, ], decreasing = T)
    sort_names <- names(sort_nums)
    
    similar_mat[ , i] <- paste0(sort_names, ", ", sort_nums)
    
  }
  
  return(similar_mat)
  
}

senators <- unique(dat_all$senator_name)

test_similar <- list_similar(test_output1, senators)

small_similar <- list_similar(small_donor_matrix, senators)
everything_similar <- list_similar(everything_matrix, senators)

save(small_donor_matrix, small_similar, file = "/Users/oliviabeck/Dropbox/Olivia/Conflict/school/SODA501/FinalProject_SODA501/SODA501Project/Small.Rdata")
save(everything_matrix, everything_similar, file = "/Users/oliviabeck/Dropbox/Olivia/Conflict/school/SODA501/FinalProject_SODA501/SODA501Project/Everything.Rdata")
