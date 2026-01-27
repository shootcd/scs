###structural equivalence,automatic equivalence,regular equivalence
# Install and import required libraries
!pip install networkx matplotlib numpy scipy

import networkx as nx
import matplotlib.pyplot as plt
import numpy as np
from itertools import combinations
from scipy.cluster.hierarchy import linkage, fcluster

# -------------------------------
# STEP 1: Create Sample Network
# -------------------------------

G = nx.Graph()

edges = [
    ('A', 'B'), ('A', 'C'),
    ('B', 'D'), ('C', 'D'),
    ('D', 'E'), ('D', 'F')
]

G.add_edges_from(edges)

pos = nx.spring_layout(G, seed=42)

# -------------------------------
# STEP 2: Structural Equivalence
# -------------------------------

nodes = list(G.nodes())
adj_matrix = nx.to_numpy_array(G)

# Compute pairwise Euclidean distance
struct_eq = {}

for i, j in combinations(range(len(nodes)), 2):
    d = np.linalg.norm(adj_matrix[i] - adj_matrix[j])
    struct_eq[(nodes[i], nodes[j])] = d

# Find pairs with minimum distance
min_dist = min(struct_eq.values())
struct_pairs = [pair for pair, d in struct_eq.items() if d == min_dist]

print("\nStructural Equivalence Pairs:", struct_pairs)

# Color structurally equivalent nodes
colors_struct = []
for n in G.nodes():
    if any(n in pair for pair in struct_pairs):
        colors_struct.append("orange")
    else:
        colors_struct.append("lightblue")

plt.figure(figsize=(5,5))
nx.draw(G, pos,
        with_labels=True,
        node_color=colors_struct,
        node_size=1800,
        edge_color="gray")

plt.title("Structural Equivalence (Orange Nodes)")
plt.show()

# -------------------------------
# STEP 3: Automorphic Equivalence
# -------------------------------

gm = nx.algorithms.isomorphism.GraphMatcher(G, G)
auto_maps = list(gm.isomorphisms_iter())

auto_sets = []
for mapping in auto_maps:
    for k, v in mapping.items():
        if k != v:
            s = {k, v}
            if s not in auto_sets:
                auto_sets.append(s)

print("\nAutomorphic Equivalence Sets:", auto_sets)

# Color automorphically equivalent nodes
colors_auto = []
for n in G.nodes():
    if any(n in s for s in auto_sets):
        colors_auto.append("green")
    else:
        colors_auto.append("lightblue")

plt.figure(figsize=(5,5))
nx.draw(G, pos,
        with_labels=True,
        node_color=colors_auto,
        node_size=1800,
        edge_color="gray")

plt.title("Automorphic Equivalence (Green Nodes)")
plt.show()

# -------------------------------
# STEP 4: Regular Equivalence
# -------------------------------

# Feature vector: degree + sum of neighbor degrees
features = []

for node in nodes:
    deg = G.degree(node)
    nbr_deg_sum = sum(G.degree(nbr) for nbr in G.neighbors(node))
    features.append([deg, nbr_deg_sum])

Z = linkage(features, method="ward")
labels = fcluster(Z, t=2, criterion="maxclust")

reg_groups = {}
for node, label in zip(nodes, labels):
    reg_groups.setdefault(label, []).append(node)

print("\nRegular Equivalence Groups:", reg_groups)

# Assign colors to regular equivalence groups
unique_labels = list(set(labels))
color_map = ["red", "yellow", "cyan", "violet"]

reg_color_dict = {}
for lbl, col in zip(unique_labels, color_map):
    reg_color_dict[lbl] = col

colors_reg = [reg_color_dict[label] for label in labels]

plt.figure(figsize=(5,5))
nx.draw(G, pos,
        with_labels=True,
        node_color=colors_reg,
        node_size=1800,
        edge_color="gray")

plt.title("Regular Equivalence (Role-Based Colors)")
plt.show()
