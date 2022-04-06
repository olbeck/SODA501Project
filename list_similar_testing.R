#funtion to list the most simliar other senators for each senator

list_similar <- function(adj_matix, senators){
  #### INPUTS
  # adj_matix : adjacent matrix, output of make_adj_matrix, n-by-n matrix
  # senator : input of senator names used in adj_matrix, length n
  
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

test_similar <- list_similar(test_output2, senators)

test_similar$angus_king

