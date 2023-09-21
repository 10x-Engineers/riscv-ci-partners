# Creating a Jenkins Node on LXC Container

## What is a container

A container is a virtualization method for isolating the applications (or even operating systems) from each other.

## Why do we need a container for Jenkins node

In Jenkins, node is a location where our jobs run. One user can use one node for all of his processes and multiple users may also use one node for all of their processes. In Jenkins freestyle project, we can use bash shell or windows command shell due to which there is a possibility to navigate anywhere in the server machine. This possibility can lead to various security and integrity issues for server administrators and also for other users using that webserver. So one must isolate each node and allocate each node to each user separately.

## What is LXC Container

LXC stands for Linux Containers. LXC is a package for linux operating systems and provides linux users with containers which may contain a whole linux operating system while also being lightweight than a virtual machine. More information regarding LXC can be found at
<https://linuxcontainers.org/lxc/introduction/>

On ubuntu 20.04 one can install LXC using command  
`[sudo] apt-get install lxc`  

## Creating a container with LXC

**_NOTE: Throughout this document, the name of the container will be `my-container` and the name of the user will be `user1`. So wherever my-container is written, one may change the name to whatever one wants to give it._**

## Pre-requisites

Before proceeding, it is important to mention that at the point of writing this document following are the specifications for linux kernel and distribution:

**Linux Kernel**: 5.15.0-46-generic (can be checked on ubuntu by command `uname -r`)  
**Distribution**: Ubuntu focal (20.04) (can be checked on ubuntu by command `lsb_release -a`)  

By default linux users are not allowed to create any network device on the machine. For doing that, one must add `uid` and `gid` in the `/etc/lxc/lxc-usernet`. The uid and gid of the user you want to use can be found in the files `/etc/uid` and `/etc/gid` respectively.

After getting the `gid` and `uid` of the user you want to allow for creating the network devices, one must go to `/etc/lxc/lxc-usernet` and add the `uid` and `gid` in the following format:
  
`<username> veth lxcbr0 10`  
e.g.  
`jenkins veth lxcbr0 10`  
  
In above example `jenkins` is the username, `veth` is the command used for creating the bridges between virtual network devices and physical network devices (you will be able to see that ethernet device in our container will be `lxcbr0`) and `lxbr0` is the network device we want to create. ‘10’ represents the number of devices we want to create using our specified user.

According lxc documentation, in ubuntu 20.04 an additional command is required before creating lxc container:  
`export DOWNLOAD_KEYSERVER="hkp://keyserver.ubuntu.com"`  

## Creating image

After this, one can create container using following command  
  
`systemd-run --unit=my-unit --user --scope -p "Delegate=yes" -- lxc-create -t download -n my-container`  
  
This runs lxc container with unit name `my-unit`, container name `my-container` and delegates a control group (also known as the `cgroup`) which is needed for resource allocation for processes in container.

This will output the list of available linux distributions in which one may want to run the container and will prompt for Distribution as shown in the following image.  
  
![unnamed (4)](<../doc_images/unnamed (4).png>)
  
After selecting the suitable distribution, release and architecture (which is also mentioned in the table), the container may be created as shown in the image below:  
  
![unnamed (5)](<../doc_images/unnamed (5).png>)  
  
Next thing is to start a container which will change its state from STOPPED to RUNNING using the following command.  
  
`lxc-start -n my-container`  
  
Above command will have no output if it succeeds.  
The state of the container can be checked using the following command.  
  
`lxc-info -n my-container`  
  
After starting the container, its state will be set as running and is just like turning a linux machine ON.  
  
From this point onwards, if one wants to use the machine in the terminal then use the following command and this will switch the terminal to the root of the container.  
  
`lxc-attach my-container`  
  
![unnamed (6)](<../doc_images/unnamed (6).png>)
  
Now the container is ready to be used and is completely isolated from the host machine.

## Using SSH to access container with username and password

The above mentioned method can be used to attach the host machine terminal to the container and this can be used to access the container. But if one wants to access the machine remotely then one possible and well-known method will be to configure and use SSH on the container.

As it is an out of the box linux distro and only the root user is present, so first create another user using the following command and then manage its permissions for `/home folder`.

```shell
#Considering you remain the root user for execution of all the  following #commands

useradd user1
cd /home
mkdir user1    #Creating home directory for user1
chown user1:user1 user1  #Giving ownership of home directory to new user

#For adding the same shell and bashrc configurations for new user, use #following
#command, otherwise the shell will be very basic for new user and will be #very inconvenient to use.

usermod -s /bin/bash user1
```  
  
For the sake of simplicity of this document the name used for the new user is `user1` here.
(You may want to set the password for `user1` by executing the `passwd` command in root.)

At this point `user1` is not in sudoers. For adding it to the sudoers, it must be added in the sudo group which can be done by using the following command.  
  
`usermod -a -G sudo user1`  
  
Now switch to the user1 using the following command.  
  
`su - user`  
  
Now install openssh-server for configuring the ssh on user1.  
  
`sudo apt install openssh-server`  
  
After that one must find the ip of the container we are using, for this either run following command while in container with user1,

```shell
sudo apt-install net-tools

#Because ifconfig is part of net-tools which are by default not installed on new #container

Ifconfig -a
```  
  
![unnamed (7)](<../doc_images/unnamed (7).png>)  
  
OR open a new terminal in the host machine and execute the following command.  
  
`lxc-info my-container -iH`  
  
![unnamed (8)](<../doc_images/unnamed (8).png>)  
  
So, the ip of the container is `10.0.3.127`.
The command for establishing an ssh connection to a remote machine is mentioned below and it will ask for the password of the remote machine which is actually the container in our case.  
  
`ssh user1@10.0.3.127`  
  
After entering the password, terminal will switch to the container’s user1 as can be seen in the following image.
  
![unnamed (9)](<../doc_images/unnamed (9).png>)  
  
## Using SSH to access Jenkins agents on the container

First install some initial dependencies (git, jdk, jre) on the containers for running agents on the container.

```shell
sudo apt update
sudo apt install default-jdk default-jre git maven
```  

Now login to jenkins with administrator privileges and create a node in it from `Dashboard > Manage Jenkins > Nodes` and press `+ New Node`. Enter a name for the node and select the desirable node type.
For this documentation, the node will be a permanent type and the name will be `temp_node`.  
  
![unnamed (10)](<../doc_images/unnamed (10).png>)  
  
After this click on `Create` which will display the configuration page of the node.  

1. Write the description of the node as desired.  
2. Number of executors means number of threads running at a time (it will be better to set it to the number of processors present on the machine which is running this node).  
3. Remote root directory will be the directory where the jobs will run by default on the node. In our case this will be a specified directory inside the container.  
4. Labels indicate that this node will run only when a job with specified labels is run, otherwise this node will not be used (also depends on the usage method in the next option). If the purpose is to use the node by default for every job, then leave it empty.  
5. Select a desired usage option.  
6. In launch methods, select “Launch agents via SSH”  
    - In “Host” enter the ip address of the container which is 10.0.3.127 in our case.  
    - In “Credentials”, click Add and this will open another sub dialog for entering credentials information.  
    - Select the kind as “Username wih password”.  
    - Leave other options as is and write the username and password of the container user, in our case the username will be user1 and password will be the password which was set for user1.  
    - “ID” and “Description” are optional.  
    - Click on “Add”.  
    - Now as the credentials are added, click on the dropdown menu and select the username you just added. In our case it is user1 as the username added was user1.  
7. After this rest of the options need not to be changed if this node is going to be a default node.  
8. Click on “Save”.  
After complete setup, the configuration for this node will look something like this.  

![unnamed (11)](<../doc_images/unnamed (11).png>)  
  
![unnamed (12)](<../doc_images/unnamed (12).png>)  
  
![unnamed (13)](<../doc_images/unnamed (13).png>)  
  
If no issue is encountered during this whole setup, jenkins will take us to the log and after sometime (when the ssh connection is established) we can see “Agent successfully connected and online” at the bottom of the log as can be seen in the screenshot below.  
  
![unnamed (14)](<../doc_images/unnamed (14).png>)  
  
**After this point, node will be able to run jobs from the container directory.**  

## Reference Links

Documentation for LXC containers can be found at: <https://linuxcontainers.org>  
Details regarding Jenkins ssh agents can be found at: <https://acloudguru.com/blog/engineering/adding-a-jenkins-agent-node>
