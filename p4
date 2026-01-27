##shortestest path,density,egocentricity
# Install and import required libraries
!pip install networkx matplotlib numpy

import networkx as nx
import matplotlib.pyplot as plt
import numpy as np

# -------------------------------
# STEP 1: Create a Sample Network
# -------------------------------

G = nx.Graph()

edges = [
    ('A','B'), ('A','C'),
    ('B','C'), ('B','D'),
    ('C','E'), ('D','E'),
    ('D','F'), ('E','G'),
    ('F','G')
]

G.add_edges_from(edges)

# -------------------------------
# STEP 2: Shortest Path
# -------------------------------

source = 'A'
target = 'G'

shortest_path = nx.shortest_path(G, source, target)
shortest_path_length = nx.shortest_path_length(G, source, target)

print("Shortest Path from", source, "to", target, ":", shortest_path)
print("Length of Shortest Path:", shortest_path_length)

# -------------------------------
# STEP 3: Density of the Graph
# -------------------------------

density = nx.density(G)
print("\nDensity of the Graph:", round(density, 4))

# -------------------------------
# STEP 4: Egocentric Network of Node G
# -------------------------------

ego_node = 'G'
radius = 1   # configuration parameter (1 = direct neighbors)

ego = nx.ego_graph(G, ego_node, radius=radius)

print("\nNodes in Egocentric Network of", ego_node, ":", ego.nodes())
print("Edges in Egocentric Network:", ego.edges())

# -------------------------------
# STEP 5: Visualization
# -------------------------------

pos = nx.spring_layout(G, seed=42)

# ---- Full Network ----
plt.figure(figsize=(6,6))
nx.draw(G, pos,
        with_labels=True,
        node_color="lightblue",
        node_size=1800,
        edge_color="gray")
plt.title("Practical 4: Full Network")
plt.show()

# ---- Shortest Path Highlight ----
plt.figure(figsize=(6,6))
nx.draw(G, pos,
        with_labels=True,
        node_color="lightblue",
        node_size=1800,
        edge_color="gray")

path_edges = list(zip(shortest_path, shortest_path[1:]))

nx.draw_networkx_edges(G, pos,
                        edgelist=path_edges,
                        width=3,
                        edge_color="red")

plt.title("Shortest Path Highlighted (A → G)")
plt.show()

# ---- Egocentric Network ----
plt.figure(figsize=(6,6))
pos_ego = nx.spring_layout(ego, seed=42)

nx.draw(ego, pos_ego,
        with_labels=True,
        node_color="lightgreen",
        node_size=2000,
        edge_color="gray")

plt.title("Egocentric Network of Node G (Radius = 1)")
plt.show()
