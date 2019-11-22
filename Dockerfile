FROM ubuntu:18.04

LABEL maintainer = "David S. Wilkinson"

RUN apt-get update && \
  apt-get install default-jre -y && \
  apt-get install curl -y && \
  apt-get install awscli -y

ARG JENKINS_SHA=79c2042b30ad71dc9cf17a5877f64eaed405fa03e24e002ca60f8db73b7ad490
ARG JENKINS_URL=http://mirrors.jenkins.io/war-stable/latest/jenkins.war

RUN curl -fsSL ${JENKINS_URL} -o /usr/local/etc/jenkins.war \
  && echo "${JENKINS_SHA}  /usr/share/jenkins/jenkins.war" | sha256sum -c -

#ADD ./jenkins.war /usr/local/etc/
#ADD ./start_jenkins.sh /.

RUN /bin/bash -c 'chmod +x /start_jenkins.sh'
CMD [ "/bin/sh", "/start_jenkins.sh" ]
