Introduction to Web Graphs
==========================

Workshop at the [IIPC Web Archiving Conference 2025](https://netpreserve.org/ga2025/).

- Slides (available soon)
- [Links and bibliographic references](./docs/web-graph-workshop-wac2025.bib)



## Preparations Ahead of the Workshop


### Installation of the Java JDK

If you are a Java developer and familiar with Java, Maven and Git, please directly go to the section "[Set Up for Java Developers](#set-up-for-java-developers). It's assumed that the Java JDK and all development resources are already installed.

Please install the latest Java JDK from <https://www.oracle.com/java/technologies/downloads/> or make sure it is already installed on your laptop. Please follow the installation instructions <https://docs.oracle.com/en/java/javase/21/install/overview-jdk-installation.html>.

Notes:
- Java 11 or higher is required.
- The Java Development Kit (JDK) is required – the Java runtime (JRE) is not sufficient, because we will use the [JShell](https://docs.oracle.com/en/java/javase/21/jshell/introduction-jshell.html) included only in the JDK.



### Download the CC-Webgraph JAR

Please, download the full cc-webgraph JAR (including all dependent libraries) from [here](https://github.com/commoncrawl/wac2025-webgraph-workshop/raw/refs/heads/main/data/large-files/cc-webgraph-0.1-SNAPSHOT-jar-with-dependencies.jar).

In the following, we refer to this JAR file using the variable `$CC_WEBGRAPH_JAR`. If you know about environment variables, you should define `CC_WEBGRAPH_JAR` and point it to the absolute path of the downloaded JAR file. If you use a Shell you can define the variable as

    CC_WEBGRAPH_JAR="$PWD"/cc-webgraph-0.1-SNAPSHOT-jar-with-dependencies.jar

Optionally you might want to set the environment variable `CLASSPATH`, used by Java and the JShell, and point it to jar file. On Unix systems this is done by:

    CLASSPATH="$CC_WEBGRAPH_JAR"
    export CLASSPATH


### Clone or Download the cc-webgraph Project Repository

This step is optional.

The `cc-webgraph` project repository bundles tools and scripts to construct, process and explore Common Crawl web graphs.

You can either clone the repository:

    git clone https://github.com/commoncrawl/cc-webgraph.git

or download it as zip file:

    wget --timestamping https://github.com/commoncrawl/cc-webgraph/archive/refs/heads/main.zip
    unzip main.zip

In the following, we refer to the project directory (`cc-webgraph` or `cc-webgraph-main`) using the variable `$CC_WEBGRAPH`. If you use a Shell you can define the variable as

    CC_WEBGRAPH="$PWD"/cc-webgraph        # cloned repository

or

    CC_WEBGRAPH="$PWD"/cc-webgraph-main   # zipped repository package

We will use scripts from it in the workshop, but you can also visit and download the scripts individually from Github.


### Get Familiar With Java and the JShell

Please read about the [JShell](https://docs.oracle.com/en/java/javase/21/jshell/introduction-jshell.html).
Ideally, you launch it in a terminal by typing `jshell'. You should get the prompt:

    |  Welcome to JShell -- Version 21.0.6
    | For an introduction type: /help intro |

    jshell>


### Bash, cURL and Wget

This requirement is optional.

We provide scripts to download CCF's webgraphs and to build the required offset and vertex maps. If you want to run the scripts a Bash shell (version 4 or higher) is required. In addition, the download script relies on cURL or Wget as download tool.

However, in case you have no Bash, or none of cURL or Wget installed, it's no issue. You only need to copy-paste a few commands into your terminal.


### Set Up for Java Developers

It is assumed that Java JDK (Java 11 or upwards), Maven and Git are installed.

1. Clone the "cc-webgraph" repository:

        git clone https://github.com/commoncrawl/cc-webgraph.git

2. Run the Java build:

        cd cc-webgraph/
        mvn package

3. Try the cc-webgraph package:

        java -cp target/cc-webgraph-*-jar-with-dependencies.jar <classname> <args>...

   For example:

        java -cp target/cc-webgraph-*-jar-with-dependencies.jar it.unimi.dsi.webgraph.BVGraph --help

4. Define two environment variables, pointing to the project directory and the JAR file:

        CC_WEBGRAPH="$PWD"
        CC_WEBGRAPH_JAR=$(ls "$PWD"/target/cc-webgraph-*-jar-with-dependencies.jar)

   Optionally you might want to set the environment variable `CLASSPATH` which is used by Java and the JShell:

        CLASSPATH="$CC_WEBGRAPH_JAR"
        export CLASSPATH

The project `cc-webgraph` provides few Java classes and scripts to construct and process web graphs from Common Crawl data.

The assembly jar file includes also the [WebGraph](https://webgraph.di.unimi.it/) and [LAW](https://law.di.unimi.it/software.php) packages required to compute [PageRank](https://en.wikipedia.org/wiki/PageRank) and [Harmonic Centrality](https://en.wikipedia.org/wiki/Centrality#Harmonic_centrality).


### Dowload of Webgraphs

Please download at least one of the following webgraphs:

|    Disk |    RAM | Nodes |  Arcs | Name                               |
|--------:|-------:|------:|------:|:-----------------------------------|
| 800 MiB |  2 GiB |  6.8M |  173M | enwiki-2024                        |
|  13 GiB | 16 GiB |  135M | 2038M | cc-main-2025-jan-feb-mar-domain    |

Which one(s) depends on your hardware. Working with the Common Crawl domain-level graph may requires more disk and RAM.

Please follow the download and setup instructions shared below together with some references about the two graphs.


#### English Wikipedia 2024 (Provided By LAW, University of Milano)

The Laboratory of Web Algorithmics (LAW) at the University of Milano is the home of the [WebGraph](https://webgraph.di.unimi.it/) framework.

The list of LAW webgraph datasets is long and includes graphs derived from web crawls but also social network graphs. You find them all at <https://law.di.unimi.it/datasets.php>.

The webgraph of the English Wikipedia 2024 is list as social network graph. The nodes are Wikipedia articles and the arcs links to other articles. Of course, you can take this graph for a real webgraph, because every Wikipedia article is shown on a webpage and there is a mapping between article name and its URL.

More information about the `enwiki-2024` webgraph is found on <https://law.di.unimi.it/webdata/enwiki-2024/>.

The LAW also provides ranks based on this webgraph. The Wikiranks site is worth a visit: <https://wikirank-2024.di.unimi.it/?search=&type=all&pageSize=20>. It allows you to compare how three graph-based ranking algorithms (Harmonic Centrality, PageRank and Indegree Count) compare with each other and to the number of Page Views.


In order to explore the graph yourself using the WebGraph framework, please download the graph files. We need at least the six files listed in [enwiki-2024-download-list.txt](./data/enwiki-2024/enwiki-2024-download-list.txt). Please, download the files in a separate folder, for example in `data/enwiki-2024/`. If you have Wget installed the download could be done by:

    cd data/enwiki-2024/
    wget --continue --timestamping --input-file enwiki-2024-download-list.txt

After the files are downloaded, the following two commands are required to build the offset lists for both the graph and its transpose:

    java -cp "$CC_WEBGRAPH_JAR" it.unimi.dsi.webgraph.BVGraph --offsets --list enwiki-2024
    java -cp "$CC_WEBGRAPH_JAR" it.unimi.dsi.webgraph.BVGraph --offsets --list enwiki-2024-t



#### Domain-Level Webgraph of Common Crawls 2025 Jan/Feb/Mar

The domain-level webgraph `cc-main-2025-jan-feb-mar-domain` was built using the hyperlinks extracted from three Common Crawl datasets crawl in January, February and March 2025. More information about this graph data set is found
- on the Common Crawl blog <https://commoncrawl.org/blog/host--and-domain-level-web-graphs-january-february-and-march-2025>
- and the dataset download page <https://data.commoncrawl.org/projects/hyperlinkgraph/cc-main-2025-jan-feb-mar/index.html>

Please, download six of the domain-level files in a separate folder:

- You can use the download script [`graph_explore_download_webgraph.sh`](https://github.com/commoncrawl/cc-webgraph/raw/refs/heads/main/src/script/webgraph_ranking/graph_explore_download_webgraph.sh) and run it:

        cd data/cc-main-2025-jan-feb-mar-domain
        bash graph_explore_download_webgraph.sh cc-main-2025-jan-feb-mar-domain

  Or if you have a local copy of the cc-webgraph project:

        bash "$CC_WEBGRAPH"/src/script/webgraph_ranking/graph_explore_download_webgraph.sh cc-main-2025-jan-feb-mar-domain

- Alternatively, using the [download list](./data/cc-main-2025-jan-feb-mar-domain/cc-main-2025-jan-feb-mar-domain-download-list.txt):

        cd data/cc-main-2025-jan-feb-mar-domain
        wget --continue --timestamping --input-file cc-main-2025-jan-feb-mar-domain-download-list.txt

- Or file by file:

    | Size      | File |
    | --------- | ---- |
    | 941.1 MiB | [cc-main-2025-jan-feb-mar-domain-vertices.txt.gz](https://data.commoncrawl.org/projects/hyperlinkgraph/cc-main-2025-jan-feb-mar/domain/cc-main-2025-jan-feb-mar-domain-vertices.txt.gz) |
    | 4.6 GiB   | [cc-main-2025-jan-feb-mar-domain.graph](https://data.commoncrawl.org/projects/hyperlinkgraph/cc-main-2025-jan-feb-mar/domain/cc-main-2025-jan-feb-mar-domain.graph) |
    |   2 KiB   | [cc-main-2025-jan-feb-mar-domain.properties](https://data.commoncrawl.org/projects/hyperlinkgraph/cc-main-2025-jan-feb-mar/domain/cc-main-2025-jan-feb-mar-domain.properties) |
    | 4.6 GiB   | [cc-main-2025-jan-feb-mar-domain-t.graph](https://data.commoncrawl.org/projects/hyperlinkgraph/cc-main-2025-jan-feb-mar/domain/cc-main-2025-jan-feb-mar-domain-t.graph) |
    |   2 KiB   | [cc-main-2025-jan-feb-mar-domain-t.properties ](https://data.commoncrawl.org/projects/hyperlinkgraph/cc-main-2025-jan-feb-mar/domain/cc-main-2025-jan-feb-mar-domain-t.properties) |
    |   1 KiB   | [cc-main-2025-jan-feb-mar-domain.stats](https://data.commoncrawl.org/projects/hyperlinkgraph/cc-main-2025-jan-feb-mar/domain/cc-main-2025-jan-feb-mar-domain.stats) |


After the files are downloaded, we need to build
- the offset lists for both the graph and its transpose
- a mapping between vertex labels and vertex IDs

This can be done by running the script [graph_explore_build_vertex_map.sh](https://raw.githubusercontent.com/commoncrawl/cc-webgraph/refs/heads/main/src/script/webgraph_ranking/graph_explore_build_vertex_map.sh):

    bash "$CC_WEBGRAPH"/src/script/webgraph_ranking/graph_explore_build_vertex_map.sh cc-main-2025-jan-feb-mar-domain cc-main-2025-jan-feb-mar-domain-vertices.txt.gz

Or, in case you cannot run the script, by building the offset lists with the commands:

    java -cp "$CC_WEBGRAPH_JAR" it.unimi.dsi.webgraph.BVGraph --offsets --list enwiki-2024
    java -cp "$CC_WEBGRAPH_JAR" it.unimi.dsi.webgraph.BVGraph --offsets --list enwiki-2024-t

And downloading at the vertex map from [here](https://github.com/commoncrawl/wac2025-webgraph-workshop/raw/refs/heads/main/data/large-files/cc-main-2025-jan-feb-mar-domain.iepm).

When everything is done, you should see the following files in your directory:
```
cc-main-2025-jan-feb-mar-domain.graph
cc-main-2025-jan-feb-mar-domain.properties
cc-main-2025-jan-feb-mar-domain-t.graph
cc-main-2025-jan-feb-mar-domain-t.properties
cc-main-2025-jan-feb-mar-domain-vertices.txt.gz
cc-main-2025-jan-feb-mar-domain.stats
cc-main-2025-jan-feb-mar-domain.offsets
cc-main-2025-jan-feb-mar-domain.obl
cc-main-2025-jan-feb-mar-domain-t.offsets
cc-main-2025-jan-feb-mar-domain-t.obl
cc-main-2025-jan-feb-mar-domain.iepm
```


### More About Web Graphs and Next Steps

You are now prepared for the workshop.

If you have time, we recommend to watch Paolo Boldi's talk from 2013 [A modern view of centrality measures](https://www.youtube.com/watch?v=cnGJtGP4gL4).
It's an excellent introduction in graph centrality measures and graph-based ranking – from a real expert of the topic and one of the two authors of the WebGraph framework (the other is Sebastiano Vigna).
