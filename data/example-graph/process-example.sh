#!/bin/bash

set -ex

cat edges.txt

java it.unimi.dsi.webgraph.BVGraph -g ArcListASCIIGraph edges.txt exmpl

# Load exmpl.graph and convert it back to text (written to stdout)
java it.unimi.dsi.webgraph.ArcListASCIIGraph exmpl /dev/stdout

# Transpose of the graph
java it.unimi.dsi.webgraph.Transform transposeOffline exmpl exmpl-t

# Statistics
java it.unimi.dsi.webgraph.Stats --save-degrees exmpl

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
