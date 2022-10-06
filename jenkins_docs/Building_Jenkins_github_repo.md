# Building Github Repository of Jenkins
### Linux kernel version, distribution and release at the time of build process
**Linux Kernel**: 5.15.0-46-generic (can be checked using `uname -r` in ubuntu)  
**Distribution**: Ubuntu  
**Release**: focal (20.04); also works without issue on ubuntu 22.04 (release can be checked using `lsb_release -a` in ubuntu)  
## Cloning the github repository
First clone the repository using the command below (here it is assumed to be cloned at user's home directory: ~/)  
`git clone https://github.com/jenkinsci/jenkins.git`  
## Resolving the dependencies  
After cloning the repository at ~/, the file `CONTRIBUTING.md` should be available in ~/jenkins/. This file contains all the information to resolve the dependencies and building the repository.
Some notable dependencies are Java Development Kit (JDK), Apache Maven (latest version will be preferable) and git. Running Following command will resolve the mentioned dependencies.
```
sudo apt update && sudo apt install default-jdk default-jre maven git -y
```
## Building Jenkins using maven on linux
For having the jenkins build up as fast as possible, following command can be used in ~/jenkins/.  
`mvn -am -pl war,bom -Pquick-build clean install`

## Executing Jenkins
After the above commands successfully completes execution, `jenkins.war` should be present in `~/jenkins/war/target` and can be executed to run at port 8080 on localhost using following command.  
`java -jar ~/jenkins/war/target/jenkins.war --httpPort=8080 #Considering jenkins repo is cloned at ~/`

**After this process jenkins UI can be accessed using http://localhost:8080 in a browser and a password will be shown on terminal to login to jenkins first time**  
After this, Jenkins UI will go through a very simple post installation process which one can configure according to his needs.  
  
<p align="center">
  <b>END OF DOCUMENTATION<b>
</p>
