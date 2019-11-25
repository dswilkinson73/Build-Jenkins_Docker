# Build-Jenkins_Docker
Building Jenkins Docker Image

To build the image:

docker build --tag ubuntu_jenkins .

To Run the image:
docker run -p 8081:8081 -p 50001:50001 -it ubuntu_jenkins

To Run the image with a volume:
docker run -p 8080:8080 -p 50000:50000 -v $PWD:/var/jenkins_home ubuntu_jenkins
