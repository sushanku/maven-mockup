#!/usr/bin/env sh

echo 'Deploy Finally'
cp mockup_db.sql /tmp
#mkdir -p /home/jenkins/deploy/maven-mockup
ansible-playbook -i ansible/hosts --limit localhost --extra-vars "db_name=mockup_db host=localhost username=mockup password=mockup123" -t "create_db,add_user,import_db" ansible/mysqlsetup.yml
ansible-playbook -i ansible/hosts --limit localhost -t "add_new_user,copy_pub_key,generate_ssh_keys,create_dir,copy_deploy_file" ansible/usersetup.yml
rm -rf /tmp/mockup_db.sql
ssh mockup@localhost
cd /home/mockup/deploy
set -x
java -jar /home/mockup/deploy/test-1.0-SNAPSHOT-jar-with-dependencies.jar &
set +x
