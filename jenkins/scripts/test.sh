#!/usr/bin/env sh

echo 'Deploy before testing'
#cp mockup_db.sql /tmp
mysql -u mockup -pmockup123 mockup_db < mockup_db.sql
#ansible-playbook -i ansible/hosts --extra-vars "db_name=mockup_db host=localhost username=mockup password=mockup123" -t "create_db, add_user, import_db" ansible/mysqlsetup.yml
set -x
java -jar /home/jenkins/deploy/maven-mockup/test-1.0-SNAPSHOT-jar-with-dependencies.jar &
set +x
cd testcase/
mvn clean install
mvn test "-Dtest=Test.Runner"
cd ..
#ansible-playbook -i ansible/hosts --extra-vars "db_name=mockup_db username=mockup" -t "delete_user, remove_db" ansible/mysqlsetup.yml
#rm -rf /tmp/mockup_db.sql
#rsync target/test-1.0-SNAPSHOT-jar-with-dependencies.jar jenkins@192.168.58.100:/home/jenkins/deploy/maven-mockup
