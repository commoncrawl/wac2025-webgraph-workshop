#!/bin/bash

# processing the example graph

# Note: Java CLASSPATH needs to be set

set -ex

cat edges.txt

java it.unimi.dsi.webgraph.BVGraph -g ArcListASCIIGraph edges.txt exmpl

# Load exmpl.graph and convert it back to text (written to stdout)
java it.unimi.dsi.webgraph.ArcListASCIIGraph exmpl /dev/stdout

# Transpose of the graph
java it.unimi.dsi.webgraph.Transform transposeOffline exmpl exmpl-t

# Statistics
java it.unimi.dsi.webgraph.Stats --save-degrees exmpl
# option --save-degrees adds text in/outdegree lists:
# - *.outdegrees  : outdegree of node n, starting with node 0 in the first line
# - *.outdegree   : histogram: number of nodes with outdegree k
#                   (line 0 := zero outlinks, line 1 := one outlink, etc.)
# - same for *.indegrees / *.indegree
echo -e "out\tin\tid\tlabel"
paste exmpl.outdegrees exmpl.indegrees vertices.txt

# PageRank
java it.unimi.dsi.law.rank.PageRankParallelGaussSeidel \
     --alpha .85 --threads 2 --mapped exmpl-t exmpl-pr
java it.unimi.dsi.law.io.tool.DataInput2Text --type double exmpl-pr.ranks \
     | paste - vertices.txt

# Harmonic Centrality via HyperBall
java it.unimi.dsi.webgraph.algo.HyperBall --threads 2 --offline --log2m 12 \
     --harmonic-centrality exmpl-hc.bin exmpl-t exmpl
java it.unimi.dsi.law.io.tool.DataInput2Text --type float exmpl-hc.bin \
     | paste - vertices.txt
