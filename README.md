# Continuous Intergration and Countinuos Delivery 
Repo related to studies in continuous integration. Main goal is to develop abilities in Jenkins and Docker tools.
The continuous delivery starts with a quick, safe and sustainable delivery. These condition is achieved through a greater automation in the development cycle called continuous integration. A more complete and developed continuous delivery process involves an automated deployment pipeline devided in three stages: Continuous Integration, Automated Testing, Configuration Management.
On the contrary, the traditional division in the development process (developers, quality assurance and operations), leads to slower deliverys, longer feedback cycles, and others. 

### First Goal
Set the Jenkins environment with the Docker tool trough a Dockerfile. Jenkins is a tool that helps creating continuous integration and delivery pipelines.
Dockerfile documents must start with FROM, command which specifies the parent image from which we are building. It is possible to have more than one FROM in one Dockerfile to create multiple images or use one build stage as a dependency for another one.
Based on Jenkins GitHub guide use it is possible to intall more tools. This is made running container as root via apt-get. It says as well that it is good practice to drop back to the regular jenkins user.
Finaly, the objective is to make some initial configurations in the Jenkins environment created and publish in GitHub Packages.

### Docker Commit
Once a container is created, in some cases, it is possible to interact with it and make some changes in it. In orther to maintain this configuration, it is possible to write an image based on that container with the docker commit command.
```
docker commit container_name image_name
```

### Building Dockerfiles 
The Dockerfile is a file where it is possible to specify all the instructions that should be executed to build a Docker image. They are translated into images with the build command: 
```
docker build -t image_name:image_version Dockerfile_Path.
```

### Copy 
Copies a file or directory into the filesystem of the image. 

### Docker Networking
Used to comunicate with other systems over the network. Originally there is no conection between the container and the host. Container has its own IP address found through inspect, under NetworkingSettings.
```
docker inspect container_name
```

### Expose 
To expose a container's port we use the expose command, this does not mean that the port is automatically published.

### Volumes 
It is possible to set a volume in the Dockerfile. This statement declares that a specific path of the container must be mounted to a Docker volume. When you run the container, Docker will create an anonymous volume (volume with a unique id as the name) and mount it to the specified path. It allows the container to write to the host's filesystem.
The Jenkins usage guide suggests to make a persistent volume with the command: -v jenkins_home:/var/jenkins_home. What creates a docker volume on the host machine retaining the content even when the container is stopped, started or deleted. 

### Entrypoints
Set the point, in the container, to start. Therfor offers the possibility to run specific commands from the command line. Also defines which application should be run in the executable container.

### Jenkins Configuration
Jenkins is a tool that allows the implementation of continuous integration and delivery. It supports most of the programming langueges and frameworks.     
- #### Definitions
  - Job: A user-configured description of the work that Jenkins will manage
  - Build: When Jenkins run through the instructions in a job
  - Build Step: Task that Jenkins will run
  - Build Trigger: Event that starts a build (Manual or Automate)
- #### Job Configuration:
  - Description: Describes the job and what it does.
  - Discard Old Builds: Manage the old builds by only keeping builds by a maximum amount of time or a maximum number of builds. 
  - Build Environment: give control over the space the job will run and the steps to take.
  - Build: Where to inform a specific requisition. 
  - Post-build Actions: additional steps to take before the entire build wraps up (archive something, send an email, …). 
  - Source Code Management: Control the way Jenkins interact with any code you have stored in a Git repository
- #### Different Types of Jobs
  - Free Style Job: Let you freely control the way Jenkins Manages the taks you want to automate.
  - Pipeline: Useful for more complex jobs. Can run build steps in parallel. And even use different computer platforms to run steps.
  - Multi-configuration Project: Useful when you might have multiple jobs that do the same thing but for a different combinations of parameters. Instead of creating many job for each set of parameters, you can use the multi-configuration project to create one job that apply the parameters for you.
  - GitHub Organization and Multibranch Pipeline: Are specially suited for working with code repositories. 
    - GitHub Organization: Are configured to scan GitHub repositories for files that Jenkins uses to configures jobs automatically.
    - Multibranch Pipeline: Can be used to configure jobs for different branches belonging to the same repo.
  - Folder is not really a job. Jenkins uses folders to group things together.
- #### Build Triggers 
  - How Jobs can be started:
    - Trigger build remotely: process outside Jenkins starts jobs via URL. 
    - Build after other projects are built: Jenkins start jobs immediately after other jobs are finished.
    - Build Periodically: Jobs that need to be run hourly, daily, … 
    - GitHub hook trigger for GITScm polling: Projects that are tied to GitHub. Allows Jenkins to start jobs based on activity on GitHub like releases, tags or other types of commits. 
    - Poll SCM: Start a job based on activity in a repo. Not as efficient as trigger from a GitHub hook.  
- #### Build Environment
  - Delete workspaces before build starts: Jenkins remove the workspace, place where the files generated by previous jobs are storage, and recreate for each new run.
  - Use secret texts or files: useful for injecting secrets into your job in runtime. 
  - Abort the build if it is stuck: useful to keep jobs from running on and on if something keeps the job from starting normally.
  - Add timestamps to the console output: gives more detail on when a certain item was written to the log.
- #### Build Steps 
  - Invoke top-level Maven targets: opens a dialog where we can select our maven version and enter the goals for our build
    - Java command that will run the code at Maven's build: java -cp target/hello-1.0-SNAPSHOT.jar com.learningjenkins.App
- #### Artifacts
  - Jenkins generate products at the end of each build, the artifacts. 
  - How to look at a Artifact of a Job:
    - At the end of the job's command line, in a line where it is written "Building jar".
    - It is possible to manage artifacts with a Post-build step.
      - Post-build Action
        - Archive the Artifacts: specify the exact files we want to have archived for each successful build.
          - **/hello-1.0-SNAPSHOT.jar
- #### Scheduling Jobs
  - Jenkins Scheduler Format
    - \*(Minute, 0-59)
    - \s\*(Hour, 0-23)
    - \s\s\*(Day of the Month)
    - \s\s\s\*(Month)
    - \s\s\s\s\*(Day of the week)
      - * -> All
      - H -> Spread out jobs around the desired time. That way if there are multiple jobs scheduled for the exact same time, Jenkins can spread them out.
      - @hourly
      - @daily
      - @midnight
      - @weekly
      - @monthly
- #### Views and Folders
  - Views provide a way to associate jobs on a dashboard and display them together. Filter.
  - Folders allow you to create structures that are very similar to file systems on a disc. Each folder can contain jobs, views and other folders.
- #### Pipelines
  - Stored in a file named Jenkinsfile. Can be versioned in a code repository. Configure Jenkins Jobs. Contain Stages and Steps
  - Pipeline Stages are sections of the pipeline. These stages describe and manage the flow of the code through the pipeline.
  - Steps are configured inside a Stage. Each Stage must have at least one Step. Steps are the actions taken at each Stage.

### Result
Had a lot of troubles setting the port to be exposed and the volume in the Dockerfile. Best way was to set the environment with the especifications of the Dockerfile just relying on the main Jenkins image and the Docker command:
```
docker run -d -p 8080:8080 -v jenkins_home:/var/jenkins_home --name jenkins image_built:image_tag
```
The container published into GitHub packages linked in this repository (jenkins_dockerfile:1.0) envolves some Jenkins Jobs configured with the features described above.

## Second Goal 
For the second part the main goal is to set a docker compose enviroment, build a more complex pipeline and use a Jenkinsfile from this repo to set the Job stages and steps.

### Docker Compose Configurations
The docker compose file starts with the services statment. This part is responsible to define the containers to be used. It is posible to pick any name for the service, feature displayed rigth below the service statment and with an identation. We can create as much services as we want and aress each of the services created by the name given.
Inside the named service, using the image state, the image to be pulled from the Docker Hub is instanciated, or the build state, to use a dockerfile in the current directory. Other configurations such as command, port, volume, working_dir and environment are also set.
The docker compose file is run with the command: docker compose up (-d, if want to dettach it).

### Adding Plugins Through Docker Compose
To add a plugin with a docker compose file it is important to set the service name and the image it comes from.

### Docker Compose Utilities
The compose file allows you to document and configure all the application's service dependencies. With the compose it is possible to start one or more containers along with the dependencies needed. Compose also provides a convinient way to creat and destroy isolate testing enviroments facilitating the continuous delivery and integration. Docker compose substitute the need to create several containers and use the Docker network to link them all. 

### Master and Slaves
The Jnekins Master is resposible for receiving build triggers, send notifications, handling HTTP requests and managing the build environment. The Jenkins Slave, otherwise, takes care of everything that happens after the build starts. Master and slaves communicate wether through the SSH protocol, or via Java web start. Beyond the communication settings it is possible to configure the slaves to be static or dynamic and also generic or specific. This possibilities leads us to four different strategies for agents configurations:
1. Permanent Agents 
2. Permanent Docker Agents
3. Jenkins Swarm Agets
4. Dynamically provisioned Docker Agents

#### 1. Permanent Agents
Permanently add agent nodes. Implies the need of multiple agent types for different projects. This configuration can be done through Jenkins UI, Manage Nodes section. Some of the parameters to be defined when creating a new node:
- # of executions: number of builds that can be run on the slave.
- Remote root directory: directory the agent uses to run build jobs.
- Labels: tags to match specific builds
- Usage: defines wether the node will be used for specific builds or general ones.
- Launch Method: via Java Web Start, via execution of command on the master, via SSH
- Availability: agent should be up all the time or just under certain conditions.

#### 2. Permanent Docker Agents 
Each slave is identically configured (with Docker installed), and each build is defined along with the Docker image inside which the build is run. When the build is started, the Jenkins slave starts a container from the Docker image and executes all the pipeline steps inside that container. This excludes the ceed to configurwe multiple slaves for diferent project types.
```
pipeline {
  agent {
    docker {
      image "image_name"
    }
  }
  ...
}
```

#### 3. Jenkins Swarm Agents
Jenkins Swarm allows you to dynamically add slaves. In orther to use Jenkins Swarm Agents it is necessary to have the Self-Organizing Plugin Modules and run the Jenkins Swarm slave application in every agent.

#### 4. Dinamically Provisioned Docker Agents
Sets up Jenkins to dinamically creates a new agent each time a build is started. The number of slaves dinamically adjusts to the number of builds. When Jenkins job is started the master runs a new container from the jenkins-slave image on the slave Docker host.
1. Install Docker Plugin
2. On the manager jenkins page, click on the Configure System link 
3. On the cloud section, click on Add a new Cloud and choose Docker
4. Configure the Docker agent details (Docker host URL, Add a Docker Template, Max number of Slaves)
The main difference between this solution and the Permanent Docker Agent is that the entire agent is dockerize, instead of just the environment.

### Vertical and Horizontal Scaling 
A vertical scaling is related to a growth in the resources applied to the master's machine and its main advatage is the maintance of the process. The horizontal scaling is related to a multiplication of the master.

### Commit Pipeline
Starts with a commit to the main repository and results in a report about the build success or failure. Since it runs after each change a limit amount of time and resource are important. This phase is the starting point of the Continuous Delivery process and provides constant information if the code is in healthy state.
- Developer Checks in the code to the Repository -> CI Server detects the Change -> Build Starts
- Fundamental Commit Pipeline Stages:
	- Checkout: download code from the repository
	- Compile: compile the source code
	- Unit Tests: run a suite of unit tests


#### Checkout Stage
```
pipeline {
  agents any
  stages {
    stage("Checkout") {
      steps {
        git url: 
      }
    }
  }
}
```

#### Compile Stage 
```
stage("Compile") {
  steps {
    sh "./gradlew compileJava"
  }
}
```
#### Unit Tests Stage
```
stage("Unit Test") {
  steps {
    sh "./gradlew test"
  }
}
```

### Code Quality Stages

#### Code Coverage
Tests and verifies which parts of the code have been executed, than creates a report that shows the untested sections. 

##### JaCoCo
One tool to do such a thing is the JaCoCo. 
In orther to set the build to fail in case of low code coverage (20% in this case):
```
jacocoTestCoverageVerification {
  violationRuled {
    rule {
      limit {
        minimum = 0.2
      }
    }
  }
}
```
The Jenkinsfile stage and step are:
```
stage("Code Coverage") {
  steps {
    sh "./gradlew jacocoTestReport"
    sh "./gradlew jacocoTestCoverageVerification"
  }
}
```

#### Static Code Analysis
The static code analysis is the automatic process of checking the code without actually executing it. In most cases, it implies checking a number of rules on the source code. These rules may apply, for example: all public classes need to have a Javadoc comment, the maximum length of a line, ... Some of the tools to perform static code on the Java code are: CheckStyle, FindBugs and PMD. 

#### Adding a Checkstyle Configuration
In orther to add the Checkstyle configuration, we need to define the rules against which the code is checked. This is done by specifying the config/checkstyle/checkstyle.xml file:
```
<?xml version = "1.0">
<!DOCTYPE module public
  "-//Puppy Crawl
...
</module>
```

#### Add the Checkstyle to the build.gradle ???
```
apply plugin: 'checkstyle'
```

#### Use the tool only for the source code and run it
```
checkstyle {
  checkstyleTest.enable = false
}
```
```
$ ./gradlew checkstyleMain
```

#### Adding Static Code Analysis to Pipeline
Finally we add the analysis to the pipeline:
```
stage("Static code Analysis") {
  stapes {
    sh "./gradlew checkstyleMain"
  }
}
```
And to displey the Checkstyle report to Jenkins:
```
publishHTML (target: [
  reportDir: 'build/reports/checkstyle',
  reportFiles: 'main.html',
  reportName: "Checkstyle Report"
])
```
