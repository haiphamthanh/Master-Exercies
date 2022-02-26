FROM ubuntu:20.04

RUN apt-get update -y 
RUN apt-get install -y \
    default-jdk \
    nano \
    sudo \
    openjdk-8-jdk \
    wget
RUN apt-get clean --fix-missing
RUN rm -rf /var/lib/apt/lists/*

RUN useradd --create-home --shell /bin/bash ubuntu

ENV HOME /home/ubuntu
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV SPARK_VERSION 3.2.0
ENV HADOOP_VERSION 3.2
ENV MONGO_SPARK_VERSION 3.2.0
ENV SCALA_VERSION 2.13

WORKDIR ${HOME}

ENV SPARK_HOME ${HOME}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}
ENV PATH ${PATH}:${SPARK_HOME}/bin

COPY files/times.json /home/ubuntu/times.json
COPY files/README.md /home/ubuntu/README.md
COPY files/examples.scala /home/ubuntu/examples.scala
COPY files/initDocuments.scala /home/ubuntu/initDocuments.scala

RUN chown -R ubuntu:ubuntu /home/ubuntu/*
USER ubuntu

# get spark
RUN wget http://apache.mirror.digitalpacific.com.au/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && \
    tar xvf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz

RUN rm -fv spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz

