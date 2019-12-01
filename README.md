# Build-Jenkins_Docker
Building Jenkins Docker Image

- build the image:
docker build --tag Jenkins-WithTools-Docker .

- Run the image:
docker run -p 8081:8081 -p 50001:50001 -it Jenkins-WithTools-Docker

- Run the image with a volume:
docker run -p 8080:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home Jenkins-WithTools-Docker

