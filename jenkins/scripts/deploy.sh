#!/usr/bin/env sh

echo 'Deploy Finally'
#cp mockup_db.sql /tmp
mysql -u mockup -pmockup123 mockup_db < mockup_db.sql
#mkdir -p /home/jenkins/deploy/maven-mockup
#rsync -avz mockup_db.sql sushan@192.168.58.100:/tmp
#ansible-playbook -i ansible/hosts --extra-vars "db_name=mockup_db host=localhost username=mockup password=mockup123" -t "create_db, add_user, import_db" ansible/mysqlsetup.yml
#rm -rf /tmp/mockup_db.sql
rm -rf /home/jenkins/deploy/maven-mockup/*
#cp target/test-1.0-SNAPSHOT-jar-with-dependencies.jar /home/jenkins/deploy/maven-mockup
cp -r etc /home/jenkins/deploy/maven-mockup/
set -x
java -jar /home/jenkins/deploy/maven-mockup/test-1.0-SNAPSHOT-jar-with-dependencies.jar &
set +x
