FROM     ubuntu:14.04
MAINTAINER Artem Silenkov (asilenkov@mirantis.com) 

RUN apt-get update

RUN apt-get -y install wget default-jre  

ENV CATALINA_HOME /tomcat

# INSTALL TOMCAT
RUN wget http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.69/bin/apache-tomcat-7.0.69.tar.gz -O tomcat.tar.gz
RUN tar zxf tomcat.tar.gz && rm tomcat.tar.gz && mv apache-tomcat* tomcat

RUN rm -rf /tomcat/webapps/*

ADD target/petclinic.war /tomcat/webapps/petclinic.war

CMD ["/tomcat/bin/catalina.sh", "run"]

EXPOSE 8080

