# Pull base image 
FROM tomcat:8.0-alpine

# Maintainer
MAINTAINER "kserge2001@yahoo.fr"
COPY ./webapp/target/*.war /usr/local/tomcat/webapps/

