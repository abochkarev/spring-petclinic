FROM java:8-jdk
MAINTAINER Artem Silenkov <asilenkov@mirantis.net>

RUN apt-get update && \ 
    apt-get update --fix-missing && \ 
    apt-get install -y wget

ENV JETTY_VERSION 9.3.8
ENV RELEASE_DATE v20160314
RUN wget http://download.eclipse.org/jetty/stable-9/dist/jetty-distribution-${JETTY_VERSION}.${RELEASE_DATE}.tar.gz && \
    tar -xzvf jetty-distribution-${JETTY_VERSION}.${RELEASE_DATE}.tar.gz && \
    rm -rf jetty-distribution-${JETTY_VERSION}.${RELEASE_DATE}.tar.gz && \
    mv jetty-distribution-${JETTY_VERSION}.${RELEASE_DATE}/ /opt/jetty

RUN useradd jetty && \
    chown -R jetty:jetty /opt/jetty && \
    rm -rf /opt/jetty/webapps.demo

WORKDIR /opt/jetty
CMD ["java", "-jar", "start.jar", "jetty.home=/opt/jetty"]

ADD target/petclinic.war /opt/jetty/webapps/petclinic.war 

