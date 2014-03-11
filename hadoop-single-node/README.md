Yet another Hadoop docker image. Here are some of the features:

 * Use environment variable AUTHORIZED_SSH_PUBLIC_KEY to inject your
   public key into the OpenSSH Server running in the container.
 * Multiple volumes can be mounted to persist HDFS data and logs.
 * Ports can be exposed to access Yarn, MapReduce, OpenSSH Server, and
   Zookeeper.
 * Based off of Ubuntu 13.10 amd64

Listed below are the services that are brought up in the container:

 * Hadoop 2.2.0 (YARN and HDFS)
 * OpenSSH Server
 * Zookeeper

Example docker run command:

    $ mkdir -p /tmp/docker-hadoop-data/ /tmp/docker-hadoop-logs/ && \
    docker run -t -i -rm \
      -e "AUTHORIZED_SSH_PUBLIC_KEY=$(cat ~/.ssh/id_rsa.pub)" \
      -v /tmp/docker-hadoop-data/:/home/hduser/hdfs-data/ \
      -v /tmp/docker-hadoop-logs/:/opt/hadoop/logs/ \
      -p 22:22 -p 2181:2181 -p 39534:39534 -p 9000:9000 \
      -p 50070:50070 -p 50010:50010 -p 50020:50020 -p 50075:50075 \
      -p 50090:50090 -p 8030:8030 -p 8031:8031 -p 8032:8032 \
      -p 8033:8033 -p 8088:8088 -p 8040:8040 -p 8042:8042 \
      -p 13562:13562 -p 47784:47784 -p 10020:10020 -p 19888:19888 \
      pcting/hadoop_single_node

After the container comes up, you can shell into the container with:

    $ ssh hduser@localhost
