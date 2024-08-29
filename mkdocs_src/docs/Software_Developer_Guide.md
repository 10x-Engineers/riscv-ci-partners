# Software Developer Guide for RISC-V CI

A software developer is the end-user who will develop or build his/her projects on RISC-V CI infrastructure. This guide will cover all the things a software developer needs to create a project based on Cloud-V Continuous Integration (CI).  

## Pre-requisites

1. GitHub account.
2. GitHub project repository with owner rights.

## Getting an account for Cloud-V

You can request Cloud-V access via [Cloud-V contact-us page](https://cloud-v.co/contactus).

After requesting the account, Cloud-V team will have a meeting with you and will give you access to the platform accordingly.

## Setting up repository with Cloud-V

### Using Cloud-V automatic integration (beta)

For ease of convinience for users and eliminating time delays of manual set up, users can add their GitHub and GitLab repository in Cloud-V by just adding their repository URL on the Cloud-V page. The source code for this is open-source [here](https://github.com/10x-Engineers/Cloud-V-git-automation).

#### For GitHub

For integrating user repository with Cloud-V, there is a GitHub app which users can install in their repository. The purpose of creating the app and publishing it for users is that, GitHub app has all the permissions already set up. So, when a user installs GitHub app, the app automatically sets up all the permissions for the user's repository.

Following is the procedure for installing and integrating the repository with Cloud-V github app and for creating the CI pipeline in Cloud-V dashboard.

- Visit this [link](https://github.com/apps/cloud-v-github-integration) for installing GitHub app.
- Click on "Install" button which will take you to permissions page where you can select the permissions for the repository and also choose the repository which you would like to integrate with Cloud-V app
- Select "Only select repositories" if you would like to integrate a specific repository or number of repositories instead of integrating Cloud-V app with all the repositories.
- Click on "Install & Authorize" which will take you to the page where you can add repository URL
- Add repository URL and click on "Submit"
- The next page will show you:
  - Access Token (will be visible one-time)
  - URL of the GitHub repository which is configured (currently, one token can be configured with one repository)
  - The link of the CI pipeline which is created automatically in Cloud-V CI dashboard  

## Setting credentials for webhook

Cloud-V supports webhooks which can trigger the job from external sources such as GitHub. They work in a way such that, if a specified branch is committed or if a pull request is created, the specified job build starts running depending upon the trigger event which is set in build's configuration in Cloud-V.  

This process requires access token of the repository **CREATED BY OWNER OF REPOSITORY** on which the webhook is to be set. These credentials can be safely added to Cloud-V without anyone (even administrator) seeing the passwords as follows.

### Obtaining github access token for repository

Navigate to the dashboard of your github account and click on the your github profile picture on the top-right corner on dashboard.

![github settings1](../doc_images/github_repo_token1.png)

Then click on the "Settings" from the list.

![github settings1](../doc_images/github_repo_token2.png)

From the left option bar in Settings scroll down and click on "Developer settings".

![github settings3](../doc_images/github_repo_token3.png)

Once there, click on "Personal access tokens", then click on "Fine-grained tokens" from the dropdown list and after that click on "Generate new token".

![github settings4](../doc_images/github_repo_token4.png)

This will open the page for setting up new access token. Follow following steps for creating a token:  

1. Give your token a meaningful name under "Token name"
2. Set expiration date in "Expiration" depending upon how long you would like your repository to be integrated with Cloud-V (think of a meaningful upper bound)
3. The "Resource owner" should be the owner of the repository who can access all kinds of settings of the repository
4. Under "Repository access", check "Only select repositories" and then select the repository for which you would like to create the token
5. Under "Permissions" section, expand "Repository Permissions" and give the following two permissions:

     - "Read and write" access to "Commit statuses" (Because after the CI has run, Cloud-V will be able to set the status of the commit accordingly)
     - "Read-only" access to "Webhooks"

### Configuring repository webhook

In GitHub,

- Go to repository settings which you want to integrate for Cloud-V.  

![Github_settings](../doc_images/repo_settings.png)

- Go to `Webhooks`  

![webhooks](../doc_images/webhooks.png)  

- Click on `Add webhook`  

![add_webhook](../doc_images/newwebhook.png)

- Add `Payload URL` as `https://dash.cloud-v.co/ghprbhook/`  
- Select content type as `application/json`
- Check `Enable SSL verification`  
- In the section **Which events would you like to trigger this webhook?** check `Let me select individual events` and check `Pul requests` as individual events and dont check any other permission.

Webhook settings will look something like this:

![webhook_settings](<../doc_images/webhook-settings1.png>)  

## Setting up `cloud-v-pipeline` inside github project repository

Cloud-V will need a `cloud-v-pipeline` written with jenkinsfile pipeline syntax to start execution of tests/checks (see [link](https://www.jenkins.io/doc/book/pipeline/syntax/)). This pipeline will contain all the stages (and may be steps) of a CI/CD pipeline. This pipeline can be `scripted pipeline` which will only have stages or it can also be `declarative pipeline` which may also have steps inside stages.  

A simple scripted `Helloworld` pipeline in linux is as follows:

```shell

node{
    stage('*** Phase 1 ***') {
        //Using bash commands
        sh '''#!/bin/bash
            echo "Hello World !\n"
         '''
    }
}
```  

Upon execution of such a pipeline, the console output can be viewed as follows.  

![Console Output](<../doc_images/Console output for Hello World.png>)

_**Note:** This cloud-v-pipeline should remain same in all the branches and pull requests._  

### Configurations inside Cloud-V

_**Note:** Currently users are not able to see or modify pipeline build configuration inside Jenkins, that is currently managed by administrator. Users are requested to inform administrator about how they want their pipeline configured._

- We will provide you with Cloud-V credentials on the provided email.
- Login with provided credentials.
- Click on the `Credentials` in the left menu.  

![Credentials1](../doc_images/Credentials1.png.png)

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
  - Enter your GitHub username in `Username`
  - Enter `Password` as `GitHub personal authentication token` (PAT) which can be acquired from Github account settings.  
  - `ID` is optional but you can enter a unique `ID`. `Description` can be left empty. But it is recommended to give a suitable but careful description by which administrator will be able to identify and use these credentials to set up github webhook
  - Select `Create`
  - This process will look something like this

![Credentials5](../doc_images/Credentials5.png)  

- Now credentials will be available in the credentials list and will be shown to you as well as administrator as shown in the image below. This will create an option in configurations for using these credentials in github webhook without changing or viewing them.  

![Credentials6](../doc_images/Credentials6.png)  

- Note the credentials ID (as shown in the image below) and email it to the same administrator email on which you received the login credentials for Cloud-V. It is important that administrator knows the credentials ID because they will use it in the job build configurations.  

![Credentials6_id](../doc_images/Credentials6_id.png)  

_**Note: Please make sure to inform the administrator via email that you have added the credentials in Cloud-V Dashboard. Also, send administrator the ID of credentials via email.**_

## Requirements for administrator

After the above setup is complete from software developer's side, developer will need to provide the administrator with following information.  

- Dependencies for running the project which can be packages which are needed to install in the RISC-V CI environment by administrator.
- Events for triggering the job build.
- URL of GitHub repository.
- Path and name of `cloud-v-pipeline` file on the provided GitHub repository.
- Any additional information which should be given for successful execution of job builds.
