
nodes <- read.csv("D:/MSc/Sem 3/nodes.csv", header=T, , as.is=T)
head(nodes)
links <- read.csv("D:/MSc/Sem 3/edges.csv", header=T, as.is=T)
head(links)
library(igraph)

links <- data.frame(from=c(1,1,2,3), to=c(2,3,3,4))
nodes <- data.frame(name=c(1,2,3,4))

net <- graph.data.frame(links, vertices=nodes, directed=TRUE)

get.adjacency(net)

plot(net)

