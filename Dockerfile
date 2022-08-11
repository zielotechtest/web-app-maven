FROM redhat/ubi8
RUN yum -y update && yum -y upgrade
RUN yum -y install java-1.8.0-openjdk-devel wget
RUN yum -y install maven
WORKDIR /app
COPY . .
RUN mvn clean package
RUN mkdir /usr/local/tomcat
RUN wget https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.16/bin/apache-tomcat-8.5.16.tar.gz -O /tmp/tomcat.tar.gz
RUN cd /tmp && tar xvfz tomcat.tar.gz
RUN cp -Rv /tmp/apache-tomcat-8.5.16/* /usr/local/tomcat/
EXPOSE 8080
CMD /usr/local/tomcat/bin/catalina.sh run
RUN cp /app/target/maven-web-application.war /usr/local/tomcat/webapps/app.war
