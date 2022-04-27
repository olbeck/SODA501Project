library(igraph)
senators <- unique(olivia_dat$senator_name)

g <- graph_from_adjacency_matrix(small_donor_matrix[1:5, 1:5], weighted = T, mode = c("undirected"))
E(g)$width <- log(E(g)$weight) + min(E(g)$weight) + 1 # offset=1
V(g)$name <- senators[1:5]


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
     edge.width=3*(edge_attr(g)$weight)/1000,
     layout =   layout_in_circle, 
     #mark.groups= modulos, 
     #mark.border=NA
)


g.copy <- delete.edges(g, which(E(g)$weight <100))
names <- c(rep(NA, 12), "Chuck Schumer", NA, "Chris Coons", 
           rep(NA, 8), "dianne_feinstein", rep(NA, 2),
           "gary_peters", rep(NA, 4), "jeanne_shaheen", NA)

plot(g, vertex.color=vertex_attr(g)$cor,
     vertex.label=senators[1:5],
     vertex.size=2*igraph::degree(g) ,
     edge.width=3*(edge_attr(g)$weight)/10,
     layout =   layout_in_circle, 
     #mark.groups= modulos, 
     #mark.border=NA
)
