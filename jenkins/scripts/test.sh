#!/usr/bin/env sh

echo 'Deploy before testing'
pwd
cp mockup_db.sql /tmp
ansible-playbook -i ansible/localhost ansible/mysqlsetup.yml -t "create_db, add_user, import_db"
set -x
java -jar target/test-1.0-SNAPSHOT-jar-with-dependencies.jar &
set +x
cd testcase/
mvn clean install
mvn test "-Dtest=Test.Runner"
pwd
ansible-playbook -i ansible/localhost ansible/mysqlsetup.yml -t "delete_user, remove_db"
rm -rf /tmp/mockup_db.sql
