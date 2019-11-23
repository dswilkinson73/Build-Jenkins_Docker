FROM ubuntu:18.04

LABEL maintainer = "David S. Wilkinson"

RUN apt-get update && \
  apt-get install default-jre -y && \
  apt-get install curl unzip -y && \
  apt-get install awscli -y

# Download, Check checksum and install Jenkins
ARG JENKINS_SHA=79c2042b30ad71dc9cf17a5877f64eaed405fa03e24e002ca60f8db73b7ad490
ARG JENKINS_URL=http://mirrors.jenkins.io/war-stable/latest/jenkins.war

RUN curl -fsSL ${JENKINS_URL} -o /usr/local/etc/jenkins.war \
  && echo "${JENKINS_SHA}  /usr/local/etc/jenkins.war" | sha256sum -c -

# Download, Check checksum and install Packer
ARG PACKER_SHA=b4dc37877a0fd00fc72ebda98977c2133be9ba6b26bcdd13b1b14a369e508948
ARG PACKER_URL=https://releases.hashicorp.com/packer/1.4.4/packer_1.4.4_linux_amd64.zip

RUN curl -fsSL ${PACKER_URL} -o /usr/local/bin/packer_1.4.4_linux_amd64.zip \
  && echo "${PACKER_SHA}  /usr/local/bin/packer_1.4.4_linux_amd64.zip" | sha256sum -c -

RUN cd /usr/local/bin && unzip packer_1.4.4_linux_amd64.zip && rm packer_1.4.4_linux_amd64.zip

ADD ./start_jenkins.sh /.

RUN /bin/bash -c 'chmod +x /start_jenkins.sh'
CMD [ "/bin/sh", "/start_jenkins.sh" ]
