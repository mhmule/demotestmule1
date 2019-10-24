# install Ubuntu 18
FROM ubuntu:18.04
MAINTAINER miloslav.hantl@gmail.com
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y  software-properties-common
RUN pwd
RUN ls -la
# install JAVA
FROM adoptopenjdk:8-jre-hotspot
# install Mule 3.8.1
RUN apt-get -m update && apt-get install -y
RUN apt-get install wget -y
RUN ls -la
RUN echo '---------- START Downloading MULE Runtime ----------------'
RUN wget https://repository-master.mulesoft.org/nexus/service/local/repositories/releases/content/org/mule/distributions/mule-standalone/3.8.1/mule-standalone-3.8.1.tar.gz
RUN ls
RUN tar -xvzf mule-standalone-3.8.1.tar.gz -C /opt
#RUN echo "4a94356f7401ac8be30a992a414ca9b9 /mule-standalone-3.5.0.tar.gz" | md5sum -c
RUN rm mule-standalone-3.8.1.tar.gz
RUN java -version
RUN ls /opt/java
RUN ls -la /opt
RUN ls -la /opt/mule-standalone-3.8.1
RUN ln -s /opt/mule-standalone-3.8.1 /opt/mule
RUN ls -la /opt/mule
RUN export JAVA_HOME="/opt/java/openjdk"
RUN echo $JAVA_HOME
RUN export MULE_HOME="/opt/mule"
RUN echo $MULE_HOME
#RUN wget http://www-us.apache.org/dist/maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.tar.gz
RUN wget http://mirror.dkm.cz/apache/maven/maven-3/3.6.2/binaries/apache-maven-3.6.2-bin.tar.gz
#RUN echo "57-hola-maven apache-maven-3.5.2-bin.tar.gz" | md5sum -c
RUN tar -xvzf apache-maven-3.6.2-bin.tar.gz -C /opt
RUN rm apache-maven-3.6.2-bin.tar.gz
RUN export MAVEN_HOME="apache-maven-3.6.2-bin"
ENV PATH="${JAVA_HOME}/bin:/opt/mule-standalone-3.8.1/bin/:${MAVEN_HOME}/bin/:${PATH}"
RUN chmod +x /opt/mule-standalone-3.8.1/bin/mule
RUN export environment="local"
RUN echo $envirinment '------------------- environment ------------- '
RUN env
EXPOSE 8081
EXPOSE 11000
EXPOSE 11001
EXPOSE 11002
EXPOSE 4443
EXPOSE 9443
EXPOSE 10009
CMD [ "/opt/mule/bin/mule"]
