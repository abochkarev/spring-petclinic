FROM     ubuntu:14.04
MAINTAINER Artem Silenkov (asilenkov@mirantis.com) 

RUN apt-get update

ENV TOMCAT_VERSION 7.0.54
ENV CATALINA_HOME /tomcat

# INSTALL TOMCAT
RUN wget http://archive.apache.org/dist/tomcat/tomcat-7/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz -O tomcat.tar.gz
RUN tar zxf tomcat.tar.gz && rm tomcat.tar.gz && mv apache-tomcat* tomcat

ADD create_tomcat_admin_user.sh /create_tomcat_admin_user.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh

ADD target/petclinic.war /tomcat/webapps/petclinic.war

CMD ["/run.sh"]

EXPOSE 8080
CMD    ["/usr/sbin/sshd", "-D"]

