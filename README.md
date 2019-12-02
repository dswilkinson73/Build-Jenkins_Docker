# Jenkins-WithTools-Docker
Building Jenkins Docker Image

- build the image:
docker build --tag jenkins-withTools-docker .

- Run the image:
docker run -p 8081:8081 -p 50001:50001 -it jenkins-withTools-docker

- Run the image with a volume:
docker run -p 8080:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock jenkins-withTools-docker
