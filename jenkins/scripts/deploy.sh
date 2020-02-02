#!/usr/bin/env sh

echo 'Deploy Finally'
ansible-playbook -i ansible/localhost ansible/mysqlsetup.yml -t "create_db, add_user, import_db"
rm -rf /home/jenkins/deploy/maven-mockup/*
cp target/test-1.0-SNAPSHOT-jar-with-dependencies.jar /home/jenkins/deploy/maven-mockup
cp -r etc /home/jenkins/deploy/maven-mockup/
set -x
java -jar /home/jenkins/deploy/maven-mockup/test-1.0-SNAPSHOT-jar-with-dependencies.jar &
set +x
