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

test_output1 <- make_adj_matix(data = dat_all, donor_type = c("IND"))  
senators <- unique(dat_all$senator_name)
test_similar <- list_similar(test_output1, senators)

test_output2 <- make_adj_matix(data = dat_all, min_cont = 5000)
senators <- unique(data_all$senator_name)
test_similar2 <- list_similar(test_output2, senators)
large_donor_large_senator <- test_similar2
