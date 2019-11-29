FROM ubuntu:18.04

LABEL maintainer = "David S. Wilkinson"

ENV TZ=Europe/Amsterdam
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000
ARG http_port=8080
ARG agent_port=50000
ARG JENKINS_HOME=/var/jenkins_home
ARG REF=/usr/share/jenkins/ref

ENV JENKINS_HOME /var/jenkins_home

RUN groupadd -g ${gid} ${group} \
    && useradd -d "$JENKINS_HOME" -u ${uid} -g ${gid} -m -s /bin/bash ${user}

VOLUME /var/jenkins_home

RUN apt-get update && apt-get install -y \
  software-properties-common \
  default-jre \
  curl unzip wget git make \
  apt-transport-https \
  ca-certificates \
  awscli

RUN add-apt-repository -y ppa:ansible/ansible
RUN apt-get install ansible -y 

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

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

RUN apt-cache policy docker-ce
RUN apt-get install docker-ce -y

ADD ./start_jenkins.sh /.

RUN /bin/bash -c 'chmod +x /start_jenkins.sh'
CMD [ "/bin/sh", "/start_jenkins.sh" ]
