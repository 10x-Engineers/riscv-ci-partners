# Creating a CI/CD pipeline in Jenkins

## Pre Requisistes

For sake of this documentation, jenkins built-in sample script is used to create and execute a cd/cd pipeline in jenkins. In the built-in script maven is used as M3, so one must install `Maven` plugin inside jenkins and name it `M3`. Usually maven is already present inside jenkins and can be configured from `Global Configuration Tools`. Following steps demonstrate configuring Maven plugin.  

- Go to Jenkins `Dashboard` and click on `Manage Jenkins`
- In `Manage Jenkins`, under `System Configuration` section, click on `Global Tool Configuration`.  

![unnamed](<../doc_images/unnamed.png>)

- In `Global Tool Configuration`, scroll down to Maven section and click on the respective option under the `Maven` Section (should be `Maven installations…` or `Add Maven`).  

![unnamed (1)](<../doc_images/unnamed (1).png>)

- Under `Maven installations`, enter `M3` in “name” text box, check `Install Automatically` and select `Version` greater than 3, then click `Apply` and `Save`.  

- This should install Maven version 3 and configure as `M3`.

## Steps for Jenkins pipeline creation

- After installing Jenkins and having all the suggested plugins installed, go to Jenkins dashboard and click on `Create Job`.  

- On the next page, give your pipeline a name, select `Pipeline` and click `OK`.

![unnamed (2)](<../doc_images/unnamed (2).png>)

- A `Configuration` page for the pipeline will appear.  

- Select `Build Triggers` options and `General` options according to need and scroll down to the Pipeline section.

![unnamed (3)](<../doc_images/unnamed (3).png>)

- Definition section contains configuration for stages and steps of the pipeline. Under `Definition` section, you can either choose `Pipeline script` and try writing your own script or try some sample pipeline (like `Hello World`, `Github+Maven` etc) or you could select `Pipeline script from SCM` and give a github repository containing configurations of Pipeline.  

- Press `Save` and `Apply`.  

- This should take you to the Pipeline and you can build the pipeline and if no unresolved dependencies are present, the pipeline should build without any error.
