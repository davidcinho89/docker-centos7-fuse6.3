FROM centos:7
RUN yum install -y java-1.8.0-openjdk-devel
RUN yum install -y git

RUN useradd fuse

RUN mkdir -p /usr/local/src/apache-maven
#RUN mkdir -p ${user.home}/.m2/repository
RUN mkdir -p /opt/rh/fuse

COPY ./maven/ /usr/local/src/apache-maven/

ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk
ENV PATH=${JAVA_HOME}/bin:${PATH}

ENV M2_HOME=/usr/local/src/apache-maven
ENV PATH=${M2_HOME}/bin:${PATH}

COPY ./fuse/ /opt/rh/fuse/

RUN chown -R fuse:fuse /opt/rh/fuse

VOLUME /opt/rh/fuse/data
VOLUME /opt/rh/fuse/deploy

WORKDIR /opt/rh/fuse

EXPOSE 1099 8181 8101 61616
ENTRYPOINT ["/opt/rh/fuse/bin/fuse","server"]

