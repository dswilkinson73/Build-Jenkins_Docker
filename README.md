# Jenkins-WithTools-Docker
Building Jenkins Docker Image

- build the image:
docker build --tag jenkins-withTools-docker .

- Run the image with a volume:
docker run -p 8080:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home jenkins-withTools-docker

.
