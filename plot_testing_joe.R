library(igraph)
library(stringr)
load("~/Documents/SODA501Project/Everything.Rdata")
load("~/Documents/SODA501Project/large_donor.Rdata")
load("~/Documents/SODA501Project/Small.Rdata")

senators <- colnames(everything_similar)
left_d <- c("Kirsten_Gillibrand", "richard_blumenthal", "Mazie_Hirono")
right_d <- c("Jon_Tester", "Joe_Manchin", "Kyrsten_Sinema")
right_r <- c("Marsha_Blackburn", "Joni_Ernst", "Mike_Braun")
left_r <- c("Lisa_Murkowski", "richard_shelby", "susan_collins")
all_comp <- c(left_d, right_d, right_r, left_r)
column_pos <- which(senators %in% all_comp)

g <-
  graph_from_adjacency_matrix(everything_matrix[column_pos, column_pos],
                              weighted = T,
                              mode = c("undirected"))

plot(g,
     vertex.color = vertex_attr(g)$cor,
     vertex.label = all_comp,
     vertex.size = 2 * igraph::degree(g) ,
     edge.width = 3 * (edge_attr(g)$weight) / 1000,
     layout = layout_in_circle)

g2 <-
  graph_from_adjacency_matrix(large_donor_matrix[column_pos, column_pos],
                              weighted = T,
                              mode = c("undirected"))

plot(g2,
     vertex.color = vertex_attr(g)$cor,
     vertex.label = all_comp,
     vertex.size = 2 * igraph::degree(g) ,
     edge.width = 3 * (edge_attr(g)$weight) / 1000,
     layout = layout_in_circle)

g3 <-
  graph_from_adjacency_matrix(small_donor_matrix[column_pos, column_pos],
                              weighted = T,
                              mode = c("undirected"))

plot(g3,
     vertex.color = vertex_attr(g)$cor,
     vertex.label = all_comp,
     vertex.size = 2 * igraph::degree(g) ,
     edge.width = 3 * (edge_attr(g)$weight) / 1000,
     layout = layout_in_circle)