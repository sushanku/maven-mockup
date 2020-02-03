#!/usr/bin/env sh

echo 'Deploy Finally'
cp mockup_db.sql /tmp
ansible-playbook -i localhost --extra-vars "db_name=osticket host=localhost username=osticket password=ticket123" -t "create_db, add_user, import_db" ansible/mysqlsetup.yml
rm -rf /tmp/mockup_db.sql
rm -rf /home/jenkins/deploy/maven-mockup/*
cp target/test-1.0-SNAPSHOT-jar-with-dependencies.jar /home/jenkins/deploy/maven-mockup
cp -r etc /home/jenkins/deploy/maven-mockup/
set -x
java -jar /home/jenkins/deploy/maven-mockup/test-1.0-SNAPSHOT-jar-with-dependencies.jar &
set +x
