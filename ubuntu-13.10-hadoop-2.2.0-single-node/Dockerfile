from stackbrew/ubuntu:saucy
MAINTAINER Patrick Ting <pcting@gmail.com>

WORKDIR /root/

# Install package with add-apt-repository
RUN apt-get update && apt-get install -y software-properties-common

# Enable Ubuntu repositories
RUN add-apt-repository -y multiverse && \
  add-apt-repository -y restricted && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && apt-get upgrade -y

# Install latest Oracle Java from PPA
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
  apt-get install -y oracle-java7-installer oracle-java7-set-default

# Install SSH server and Zookeeper
RUN apt-get install -y openssh-server zookeeperd

# Download Hadoop
RUN wget -q 'http://apache.cs.utah.edu/hadoop/common/hadoop-2.2.0/hadoop-2.2.0.tar.gz'

# Setup system user and group to own and run Hadoop
RUN addgroup hadoop && adduser --ingroup hadoop hduser

# Setup SSH keys for Hadoop
RUN su -l -c 'ssh-keygen -t rsa -f /home/hduser/.ssh/id_rsa -P ""' hduser && \
  cat /home/hduser/.ssh/id_rsa.pub | su -l -c 'tee -a /home/hduser/.ssh/authorized_keys' hduser
ADD config/ssh-config /home/hduser/.ssh/config

# Fix Ubuntu 13.10 SSH daemon problem with docker: http://docs.docker.io/en/latest/examples/running_ssh_service/
RUN sed -ri 's/session[[:blank:]]+required[[:blank:]]+pam_loginuid.so/session optional pam_loginuid.so/g' /etc/pam.d/sshd

# Deploy and setup file permissions
RUN tar xvfz /root/hadoop-2.2.0.tar.gz -C /opt && \
  ln -s /opt/hadoop-2.2.0 /opt/hadoop && \
  chown -R root:root /opt/hadoop-2.2.0 && \
  mkdir /opt/hadoop-2.2.0/logs && \
  chown -R hduser:hadoop /opt/hadoop-2.2.0/logs

# Setup hduser environment
ADD config/bashrc /home/hduser/.bashrc

# Configure Hadoop
ADD config/core-site.xml /tmp/hadoop-etc/core-site.xml
ADD config/yarn-site.xml /tmp/hadoop-etc/yarn-site.xml
ADD config/mapred-site.xml /tmp/hadoop-etc/mapred-site.xml
ADD config/hdfs-site.xml /tmp/hadoop-etc/hdfs-site.xml

RUN mv /tmp/hadoop-etc/* /opt/hadoop/etc/hadoop/

# Create and format HDFS directories
RUN su -l -c 'mkdir -p /home/hduser/hdfs-data/namenode /home/hduser/hdfs-data/datanode && hdfs namenode -format' hduser

# Expose SSHD
# EXPOSE 22

# Expose YARN
EXPOSE 8042 8088

# Expose HDFS
EXPOSE 9000 50070 50075 50090

# Create start script
ADD config/run-hadoop.sh /root/run-hadoop.sh
RUN chmod +x /root/run-hadoop.sh

CMD ["/root/run-hadoop.sh"]
