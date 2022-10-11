# Software Developer Guide for RISC-V CI
A software developer is the end-user who will develop or build his/her projects on RISC-V CI infrastructure. This guide will cover all the things a software developer needs to create a project based on RISC-V Continuous Integration (CI).  
Currently, the specifications for RISC-V CI is as follows.
- Jenkins latest version
- Ubuntu 22.04 LTS  
## Pre-requisites
1. GitHub account.
2. GitHub project repository with owner rights.
  
## Setting up `Jenkinsfile` inside github project repository
Jenkins pipeline will need a `Jenkinsfile` written with jenkins pipeline syntax to start execution of tests/checks (see [link](https://www.jenkins.io/doc/book/pipeline/syntax/)). This pipeline will contain all the stages (and may be steps) of a CI/CD pipeline. This pipeline can be `scripted pipeline` which will only have stages or it can also be `declarative pipeline` which may also have steps inside stages.  

A simple scripted `Helloworld` pipeline in linux is as follows:
```
node{
    stage('*** Compilation Phase ***') {
        //Using bash commands
        sh '''#!/bin/bash
            echo "Hello World !\n"
         '''
    }
}
```  
Upon execution of such a pipeline, the console output can be viewed as follows.  
  
![Console Output](<../doc_images/Console output for Hello World.png>)
  
_**Note:** This jenkinsfile should remain same in all the branches and pull requests._  
  
## Setting credentials for webhook:
Jenkins supports webhooks which can trigger the job from external sources such as GitHub. They work in a way such that, if a specified branch is committed or if a pull request is created, the specified job build starts running depending upon the trigger event which is set in build's configuration in jenkins.  
  
This process requires GitHub credentials of owner of repository on which the webhook is to be set. These credentials can be safely added to jenkins without anyone (even administrator) seeing the passwords as follows.
- Login with provided credentials.
- Click on the drop down near user profile as shown in image below.  
  
![Credentials1](../doc_images/Credentials1.png)
  
- This will take you to the credentials page.
- Scroll down to the `Stores scoped to Jenkins` and click on the `System` as shown in the image.  
  
![Credentials2](../doc_images/Credentials2.png)  
  
- Click on `Global credentials (unrestricted)`.  
  
![Credentials3](../doc_images/Credentials3.png)
  
- Click on `Add Credentials`.  
  
![Credentials4](../doc_images/Credentials4.png)
  
- This will take you to the `New Credentials` page.
    - Select `Kind` as `Username with password`.
    - Select `Scope` as `Global (Jenkins, nodes, items, all child items etc)`.
    - Enter the GitHub username in `Username`.
    - You may check `Treat username as secret` which will mask username in console output of builds, but this is not recommended by jenkins due to performance issues.
    - Enter `Password` as `GitHub personal authentication token` (PAT) which can be acquired from Github account settings.  
    - `ID` and `Description` can be left empty. But it is recommended to give a unique ID and a suitable but careful description by which administrator will be able to identify and use these credentials to set up github webhook.
    - Select `Create`.
    - This process will look something like this.
  
![Credentials5](../doc_images/Credentials5.png)  
  
- Now credentials will be available in the credentials list and will be shown to you as well as administrator as shown in the image below. This will create an option in configurations for using these credentials in github webhook without changing or viewing them.  
  
![Credentials6](../doc_images/Credentials6.png)
  
## Requirements for administrator
After the above setup is complete from software developer's side, developer will need to provide the administrator with following information.
- Dependencies for running the project which can be packages which are needed to install in the RISC-V CI environment by administrator.
- Events for triggering the job build.
- URL of GitHub repository.
- Path and name of Jenkinsfile on the provided GitHub repository.
- Any additional information which should be given for successful execution of job builds.