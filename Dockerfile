FROM tomcat:9.0.20-jre8
 
COPY target/java-web-app*.war /usr/local/tomcat/webapps/tomcat:9.0.war
