##one mode network two mode network 
# Install and import libraries
!pip install networkx matplotlib numpy

import networkx as nx
import matplotlib.pyplot as plt

# -------------------------------
# STEP 1: Create One-Mode Network
# -------------------------------

G = nx.Graph()

edges = [
    ('A', 'B'), ('A', 'C'),
    ('B', 'C'), ('B', 'D'),
    ('C', 'E'), ('D', 'E')
]

G.add_edges_from(edges)

plt.figure(figsize=(6,6))
pos = nx.spring_layout(G, seed=42)

nx.draw(G, pos,
        with_labels=True,
        node_color="lightblue",
        node_size=1800,
        edge_color="gray")

plt.title("One-Mode Network (Node–Node)")
plt.show()

# -------------------------------
# STEP 2: Convert to Two-Mode Network
# (Node–Edge Bipartite Graph)
# -------------------------------

B = nx.Graph()

# Original nodes
nodes = list(G.nodes())

# Edge-nodes
edge_nodes = []

for i, (u, v) in enumerate(G.edges(), start=1):
    e = f"E{i}"
    edge_nodes.append(e)

    B.add_edge(u, e)
    B.add_edge(v, e)

# Add all nodes explicitly
B.add_nodes_from(nodes, bipartite=0)
B.add_nodes_from(edge_nodes, bipartite=1)

plt.figure(figsize=(6,6))
pos_b = nx.spring_layout(B, seed=42)

nx.draw(B, pos_b,
        with_labels=True,
        node_color="lightgreen",
        node_size=1600,
        edge_color="gray")

plt.title("Two-Mode Network (Node–Edge Bipartite)")
plt.show()

# -------------------------------
# PRINT INFO
# -------------------------------

print("One-Mode Network:")
print("Nodes:", G.nodes())
print("Edges:", G.edges())

print("\nTwo-Mode Network:")
print("Nodes:", B.nodes())
print("Edges:", B.edges())
