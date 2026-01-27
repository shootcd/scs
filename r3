library(igraph)

ng <- graph.formula(
  Aakash++Kaustubh,
  Kaustubh-+Shivam,
  Shivam-+Purva,
  Purva++Diksha,
  Laxman-+Aakash,
  Laxman-+Purva,
  Laxman++Shantanu,
  Laxman++Shivam,
  Shantanu++Aakash,
  Shantanu++Shivam
)

plot(ng)

# Nodes count
vcount(ng)

# Edge count
ecount(ng)

# Density
ecount(ng) / (vcount(ng) * (vcount(ng) - 1))

# Degree
degree(ng)

# Reciprocity
reciprocity(ng)                       # Using predefined function
2 * dyad.census(ng)$mut / ecount(ng)  # Using formula
dyad.census(ng)

# Transitivity & Clustering (on ng)
transitivity(ng, type = "global")     # Transitivity
transitivity(ng, type = "local")      # Clustering coefficient

# Transitivity demonstration using standard graph
kite <- graph.famous("Krackhardt_Kite")
atri <- adjacent.triangles(kite)
plot(kite, vertex.label = atri)

transitivity(kite, type = "local")

# Using formula
adjacent.triangles(kite) / (degree(kite) * (degree(kite) - 1) / 2)

# Centralization

centr_degree(ng, mode = "in", normalized = TRUE)

closeness(ng, mode = "all", weights = NA)
centr_clo(ng, mode = "all", normalized = TRUE)

betweenness(ng, directed = TRUE, weights = NA)
edge_betweenness(ng, directed = TRUE, weights = NA)
centr_betw(ng, directed = TRUE, normalized = TRUE)
