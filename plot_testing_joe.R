library(igraph)
library(stringr)
load("~/Documents/SODA501Project/Everything.Rdata")
load("~/Documents/SODA501Project/large_donor.Rdata")
load("~/Documents/SODA501Project/Small.Rdata")

senators <- colnames(everything_similar)
left_d <- c("bernard_sanders", "Kirsten_Gillibrand", "jeff_merkley", "cory_booker", "Mazie_Hirono")
right_d <- c("christopher_coons", "angus_king", "Jon_Tester", "Joe_Manchin", "Kyrsten_Sinema")
right_r <- c("Marsha_Blackburn", "Joni_Ernst", "Mike_Braun", "ted_cruz", "james_inhofe")
left_r <- c("Lisa_Murkowski", "richard_shelby", "susan_collins", "richard_burr", "rob_portman")
all_comp <- c(left_d, right_d, right_r, left_r)
column_pos <- which(senators %in% all_comp)

g <-
  graph_from_adjacency_matrix(everything_matrix[column_pos, column_pos],
                              weighted = T,
                              mode = c("undirected"))

E(g)$width <- log(E(g)$weight) + min(E(g)$weight) + 1
V(g)$name <- senators

plot(g,
     vertex.color = vertex_attr(g)$cor,
     vertex.label = NA,
     edge.width = 3 * (edge_attr(g)$weight) / 10000,
     layout = layout_in_circle)

names <- c(rep(NA, 12), "Chuck Schumer", NA, "Chris Coons", 
           rep(NA, 8), "dianne_feinstein", rep(NA, 2),
           "gary_peters", rep(NA, 4), "jeanne_shaheen", NA)

plot(g,
     vertex.color = vertex_attr(g)$cor,
     vertex.label = senators[1:5],
     vertex.size = 2*igraph::degree(g) ,
     edge.width = 3*(edge_attr(g)$weight) / 10000,
     layout = layout_in_circle
)
