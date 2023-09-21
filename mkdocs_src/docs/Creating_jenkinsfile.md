# Creating a Jenkinsfile

## What is a Jenkinsfile

A Jenkinsfile is a Continuous Integration (CI) pipeline script which is written Java. It describes various stages (and possibly steps) which are executed in the defined pattern. These stages can be written in bash or they can be written in Java itself.  
Mainly Jenkinsfiles are of two types:  

1. **Scripted:** Only contains stages
2. **Declarative:** Contains stages as well as steps

 This documentation will cover how to create a jenkinsfile in bash script and run it on various compute instances (which are known as `Nodes` in jenkins).

## Jenkins Node

In jenkins, node represents a compute instance. In simple words, it is the platform on which our job build is going to run.  

### Jenkins Master

There is a `jenkins Master` node which is actually the compute instance on which Jenkins is installed. It is the node which schedules builds on runners. For security reason, no job is allowed to run on this node.

### Jenkins Slave

Jenkins slave nodes are the compute instances on which our job builds run safely. They may be attached with jenkins master via hardware or they may be connected through remote SSH connection.

## Jenkinsfile written in Bash  

### Simple Hello World Jenkinsfile

In Cloud-V, all the platforms are running Linux operating system, so the jenkinsfile should be written in bash.
Following script is an example of how can we run a bash script in scripted pipeline Jenkinsfile.  

```java

node{
    stage('*** Phase 1 ***') {
        //Using bash commands
        sh '''#!/bin/bash
            echo "Hello World !\n"
         '''
    }
}
```  

The keyword `sh` is used to specify a shell script

As there is nothing mentioned with `node`, so the script will run job build on any available compute instance.  

### Jenkinsfile for a Specific Node  

In previous script, the jenkinsfile would run on any compute instances which are available. But in case if someone wants to run a job build on specific node, then a compute instance name must be specified with keyword `node`. The following script is an example of running above `Hello World` program on node named `hifive_unleashed`.  

```java

node('hifive_unleashed'){
    stage('*** Phase 1 ***') {
        //Using bash commands
        sh '''#!/bin/bash
            echo "Hello World !\n"
         '''
    }
}
```  

## Jenkinsfile for Cross-Platform Compilation and Execution

Cloud-V supports cross-compilation and execution on emulated RISC-V compute instances. Following tools help in cross compilation and cross-platfrom execution:  

- RISC-V GNU Toolchain
- QEMU user mode
- QEMU System (with Linux installed)  

An example pipeline script is given below in scripted pipeline.  

```java
node('x86_runner2'){
    checkout scm //Getting content of this repo
    stage('*** Compilation Phase ***') { // for display purposes
        //Compiling helloworld.c using bash commands
        sh '''#!/bin/bash
            gcc -g ./helloworld.c -o helloworld.out
            riscv64-unknown-linux-gnu-gcc ./helloworld.c -o helloworld_riscv_compiled.out //Cross compiling for RISC-V
         '''
    }
    stage (' *** Running Binaries ***'){
        sh '''#!/bin/bash
            ./helloworld.out
            qemu-riscv64 -L $RISCV_SYSROOT helloworld_riscv_compiled.out //Running executable on RISC-V emulated platform
         '''
    }
}
```

The equivalent declarative pipeline is as follows:  

```java
pipeline {
    agent {label "x86_runner2"}

    stages {
        stage('Clone Repository') {
            steps('delegate'){
                    checkout scm //Clones the repository on the local machine
            }
        }
        stage ('Compilation Phase'){
            steps{
                    sh '''#!/bin/bash
                        gcc -g ./helloworld.c -o helloworld.out
                    '''
                    sh '''#!/bin/bash
                        riscv64-unknown-linux-gnu-gcc ./helloworld.c -o helloworld_riscv_compiled.out
                    '''
            }
        }
        stage ('Running Binaries'){
            steps {
                    sh ''' #!/bin/bash
                        ./helloworld.out
                    '''
                    sh'''#!/bin/bash
                        qemu-riscv64 -L $RISCV_SYSROOT helloworld_riscv_compiled.out
                    '''
            }
        }
    }
}
```

## Reference Links

<https://www.jenkins.io/doc/book/pipeline/syntax/>
