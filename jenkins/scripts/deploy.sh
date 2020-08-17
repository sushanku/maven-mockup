#!/usr/bin/env sh

echo 'Deploy Finally'
cp mockup_db.sql /tmp
#mkdir -p /home/jenkins/deploy/maven-mockup
ansible-playbook -i ansible/localhost --extra-vars "db_name=mockup_db host=localhost username=mockup password=mockup123" -t "create_db, add_user, import_db" ansible/mysqlsetup.yml
ansible-playbook -i ansible/localhost --extra-vars "deploy_user=mockup" -t "add_new_user,copy_pub_key,generate_ssh_keys,create_dir" ansible/usersetup.yml
rm -rf /tmp/mockup_db.sql
rsync -avz --stats --progress /tmp/test-1.0-SNAPSHOT-jar-with-dependencies.jar mockup@localhost:/home/mockup/deploy/
rsync -avz --stats --progress etc mockup@localhost:/home/mockup/deploy/
ssh mockup@localhost
set -x
java -jar /home/mockup/deploy/test-1.0-SNAPSHOT-jar-with-dependencies.jar &
set +x
