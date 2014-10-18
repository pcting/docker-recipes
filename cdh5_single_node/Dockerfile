from ubuntu:trusty
MAINTAINER Patrick Ting <pcting@gmail.com>

WORKDIR /root/

# install base packages
RUN apt-get update && apt-get install -y software-properties-common curl

# enable Oracle Java PPA
RUN add-apt-repository -y ppa:webupd8team/java

# install Ubuntu Trusty CDH5 repository
RUN curl -s http://archive.cloudera.com/cdh5/ubuntu/trusty/amd64/cdh/archive.key | apt-key add -
RUN echo "deb [arch=amd64] http://archive.cloudera.com/cdh5/ubuntu/trusty/amd64/cdh trusty-cdh5 contrib\ndeb-src http://archive.cloudera.com/cdh5/ubuntu/trusty/amd64/cdh trusty-cdh5 contrib" > /etc/apt/sources.list.d/cloudera.list

# update and install!
RUN apt-get update

# install latest Oracle Java from PPA
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
  apt-get install -y oracle-java7-installer oracle-java7-set-default

RUN apt-get install -y hadoop-hdfs-datanode \
                       hadoop-hdfs-namenode \
                       hadoop-yarn-nodemanager \
                       hadoop-yarn-resourcemanager \
                       hadoop-0.20-mapreduce-tasktracker \
                       hadoop-0.20-mapreduce-jobtracker \
                       hive \
                       hive-metastore \
                       hive-server2 \
                       hive-hbase \
                       llama \
                       llama-master \
                       impala \
                       impala-catalog \
                       impala-server \
                       impala-state-store \
                       impala-shell


# configure Hadoop
ADD config/core-site.xml /tmp/hadoop-etc/core-site.xml
ADD config/yarn-site.xml /tmp/hadoop-etc/yarn-site.xml
ADD config/mapred-site.xml /tmp/hadoop-etc/mapred-site.xml
ADD config/hdfs-site.xml /tmp/hadoop-etc/hdfs-site.xml
ADD config/impala-hdfs-site.xml /tmp/hadoop-etc/impala-hdfs-site.xml
RUN mkdir -p /etc/hadoop/conf.pseudo-cluster && \
  cp /etc/hadoop/conf.empty/* /etc/hadoop/conf.pseudo-cluster/ && \
  cp /tmp/hadoop-etc/* /etc/hadoop/conf.pseudo-cluster && \
  update-alternatives --install /etc/hadoop/conf hadoop-conf /etc/hadoop/conf.pseudo-cluster 100

# configure Impala
RUN mkdir -p /etc/impala/conf.pseudo-cluster && \
  cp /tmp/hadoop-etc/core-site.xml /etc/impala/conf.pseudo-cluster/core-site.xml && \
  cp /tmp/hadoop-etc/impala-hdfs-site.xml /etc/impala/conf.pseudo-cluster/hdfs-site.xml && \
  update-alternatives --install /etc/impala/conf impala-conf /etc/impala/conf.pseudo-cluster 100

# format the namenode if it's not already done
RUN su -l -c 'mkdir -p /var/lib/hadoop-hdfs/hdfs-data/namenode /var/lib/hadoop-hdfs/hdfs-data/datanode && hdfs namenode -format -nonInteractive' hdfs

# setup other Hadoop directories
RUN su -l -c 'mkdir -p /var/lib/hadoop-hdfs/dn_socket' hdfs

# create volumes on the HDFS and log directories
VOLUME /var/lib/hadoop-hdfs/hdfs-data/
VOLUME /var/log/hadoop-0.20-mapreduce/
VOLUME /var/log/hadoop-hdfs
VOLUME /var/log/hadoop-mapreduce
VOLUME /var/log/hadoop-yarn

# create start script
ADD config/run-hadoop.sh /root/run-hadoop.sh
RUN chmod +x /root/run-hadoop.sh

# start the services
CMD /root/run-hadoop.sh