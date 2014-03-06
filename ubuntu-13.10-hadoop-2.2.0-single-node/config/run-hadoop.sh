#!/bin/bash

set -x

# start ssh daemon
service ssh start

# start zookeeper used for HDFS
service zookeeper start

# clear hadoop logs
rm -fr /opt/hadoop/logs/*

# start YARN
su -l -c "start-yarn.sh" hduser

# start HDFS
su -l -c "start-dfs.sh" hduser

sleep 1

# tail log directory
tail -n 1000 -f /opt/hadoop/logs/*.log
