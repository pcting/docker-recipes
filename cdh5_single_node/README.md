Yet another CDH5 Hadoop docker image. Here are some of the features:

 * Multiple volumes can be mounted to persist HDFS data and logs.
 * Ports can be exposed to access Yarn, MapReduce, OpenSSH Server, and
   Zookeeper.
 * Based off of Ubuntu 14.04 Trusty amd64

Example docker run command:

    $ mkdir -p /tmp/docker-hadoop/hdfs/ /tmp/docker-hadoop/logs/ && \
    docker run -t -i -rm \
      -v /tmp/docker-hadoop/hdfs:/var/lib/hadoop-hdfs/hdfs-data \
      -v /tmp/docker-hadoop/logs/hadoop-0.20-mapreduce:/var/log/hadoop-0.20-mapreduce \
      -v /tmp/docker-hadoop/logs/hadoop-hdfs:/var/log/hadoop-hdfs \
      -v /tmp/docker-hadoop/logs/hadoop-mapreduce:/var/log/hadoop-mapreduce \
      -v /tmp/docker-hadoop/logs/hadoop-yarn:/var/log/hadoop-yarn \
      pcting/cdh5_single_node

Some Useful Web Interfaces:

* [Impala Web Interface](http://hadoop-container.local:25000/)
* [Impala State Store Web Interface](http://hadoop-container.local:25010/)
* [Impala State Store Web Interface](http://hadoop-container.local:25010/)
* [Impala Catalog Web Interface](http://hadoop-container.local:25020/)
* [Llama Web Interface](http://hadoop-container.local:15001/)
* [HDFS Data Node Web Interface](http://hadoop-container.local:50075/)
* [HDFS Name Node Web Interface](http://hadoop-container.local:50070/)
* [Hadoop 0.20 Job Tracker Web Interface](http://hadoop-container.local:50030/)
* [Hadoop Resource Manager Web Interface](http://hadoop-container.local:8088/)
* [Hadoop Node Manager Web Interface](http://hadoop-container.local:8042/)