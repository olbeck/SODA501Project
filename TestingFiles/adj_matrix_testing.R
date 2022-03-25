#get rid of punctuation 
summarized_data$committee_name
summarized_data$committee_name <- gsub('[[:punct:] ]+', " ", summarized_data$committee_name)





senators <- unique(summarized_data$committee_name)
n <- length(senators)

adj_matrix<- matrix(0, nrow =n, ncol = n )
for(i in 1:(n-1)){ # row senator
  #get unique contributors for i^th senator 
  i_senator <- senators[i]
  i_donars <- unique(summarized_data$contributor_name[summarized_data$committee_name == i_senator])
  for(j in (i+1):n){#column senator
    j_senator <- senators[j]
    j_donars <- unique(summarized_data$contributor_name[summarized_data$committee_name == j_senator])
    #find the number of matches
    matches <- sum(i_donars %in% j_donars)
    #get the 
    adj_matrix[i, j] <- matches 
  }
}

library(igraph)

adj_matrix <- (adj_matrix + t(adj_matrix))
g <- graph_from_adjacency_matrix(adj_matrix, weighted = T, mode = c("undirected"))
E(g)$width <- log(E(g)$weight) + min(E(g)$weight) + 1 # offset=1
V(g)$name <- senators


#groups of "most similar
modulos <- cluster_spinglass(g)
modulos <- cluster_fast_greedy(g)
modulos$membership
for(i in 1:max(modulos$membership)){
  group <- senators[modulos$membership == i]
  print(paste(group))
}


plot(g, vertex.color=vertex_attr(g)$cor,
     vertex.label=NA,
     #vertex.size=2*igraph::degree(g),
     edge.width=3*(edge_attr(g)$weight)/10000,
     layout = layout_in_circle, 
     #mark.groups= modulos, 
     #mark.border=NA
     )
