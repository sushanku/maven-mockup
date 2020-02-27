# Jenkins - GitHub Deployment (small maven project)

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
