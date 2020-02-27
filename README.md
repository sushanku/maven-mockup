# Jenkins - GitHub Deployment (small maven project)

This repo demonstrates how to deploy a maven based project from GitHub using Jenkins Pipeline and ansible.\
In this project, maven based application is built, tested and deployed.
in Build stage.\ 
Then the test deployment will be done in Test stagewhere API testing is done.\
If the pipeline builds without failure, and if every test cases are passed, it will proceed to the production i.e Deploy stage.\

See the Jenkinsfile for the exact Pipeline.

Prerequisite
------------
1. Jenkins, maven should be installed.
2. Test and Deployment is handled by ansible, therefore ansible needs to be installed as well.

Requirements
------------
1. Create a Multibranch Pipeline (or use GitHub Organization Folders) within Jenkins that references this repository.
2. Pipeline will then instructs Jenkins to proceed through build, test and deploy phase.
3. In build stage,


How it Works
------------
The Jenkins pipeline has 3 stages: Build, Test and Deploy.

* Build Stage:
  * Maven command is run to build the project.

* Test Stage:
  * To test the built project, the test deployment is carried out locally where API testing is done.\
  * First, it runs the test.sh script from jenkins/scripts/test.sh. This scripts file has necessary bash command to deploy the build project for test purpose. Scripts also uses ansible to create the mysql user and database. Before the completion of test phase, ansible removes the mysql user and db.
  * Then, Jenkins pipeline will artifact the 


If the pipeline builds without failure, and if every test cases are passed, it will proceed to the production i.e Deploy stage.\



Ansible Roles
=========
This is ansible automatation to manager users and groups in Linux server.\
Roles to create mysql user, and linux user to deploy the mockup app is explained below

Role Name
=========

Role is mysql and userManagement which is found under ansible/roles/.\
Therefore create a folder name called roles and go to that folder.\
Then, clone this repository.

Requirements
------------

Update vars/main.yml user password as required.\
Update hosts file accordingly as per your host ip.

Role Variables
--------------

vars/main.yml has the variable and it contains the user password.

Dependencies
------------
Come out of the roles directory. Then, copy the hosts file and usersetup.yml file from templates.

Example Playbook
----------------
Then execute following command from outside the roles directory.\
ansible-playbook usersetup.yml

Also, the following command will list the tags and run the tags accordingly.\
ansible-playbook usersetup.yml --list-tags

For example to run the listed tags, execute the following command:\
ansible-playbook usersetup.yml -t add_new_user\
\
-t flag let you use the tags. The above playbook will only add the new user using the tags.

Author Information
------------------

Sushan Kunwar\
Sytem Engineer/Devops Engineer
