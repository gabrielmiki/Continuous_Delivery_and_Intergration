# Continuous_Intergration
Repo related to studies in continuous integration. Main goal is to develop abilities in Jenkins and Docker tools.

### First Goal
Set the Jenkins environment with the Docker tool trough a Dockerfile. 
Dockerfile documents must start with FROM, command which specifies the parent image from which we are building. It is possible to have more than one FROM in one Dockerfile to create multiple images or use one build stage as a dependency for another one.
Based on Jenkins GitHub guide use it is possible to intall more tools. This is made running container as root via apt-get. It says as well that it is good practice to drop back to the regular jenkins user.

### Building Dockerfiles 
The Dockerfile are translated into images with the build command: docker build -t image_name:image_version Dockerfile_Path.

### Plugins 
Rely on the plugin manager CLI to set the plugins. Possible to install custom plugins with the Docker command: COPY --chown=jenkins:jenkins path/to/custom/hpi /usr/share/jenkins/ref/plugins/. Where the custom.hpi is the file contaning the plugin.

### Volumes 
It is possible to set a volume in the Dockerfile. This statement declares that a specific path of the container must be mounted to a Docker volume. When you run the container, Docker will create an anonymous volume (volume with a unique id as the name) and mount it to the specified path. Appenrently the best way to create a volume is indeed, directly, trougth the command line.
The Jenkins usage guide suggests to make a persistent volume with the command: -v jenkins_home:/var/jenkins_home. What creates a docker volume on the host machine retaining the content even when the container is stopped, started or deleted. 

### Jenkins Configuration  

### Result
Had a lot of problems in setting the port to be exposed and the volume in the Dockerfile. Best way was to set the environment with the especifications of the Dockerfile just relying on the main Jenkins image and the Docker command: docker run -d -p 8080:8080 -v jenkins_home:/var/jenkins_home --name jenkins image_built:image_tag.

## Second Goal 
Set a docker compose enviroment.
