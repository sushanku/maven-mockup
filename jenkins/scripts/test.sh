#!/usr/bin/env sh

echo 'Deploy before testing'
cp mockup_db.sql /tmp
ansible-playbook -i localhost --extra-vars "db_name=osticket host=localhost username=osticket password=ticket123" -t "create_db, add_user, import_db" ansible/mysqlsetup.yml
set -x
java -jar target/test-1.0-SNAPSHOT-jar-with-dependencies.jar &
set +x
cd testcase/
mvn clean install
mvn test "-Dtest=Test.Runner"
cd ..
ansible-playbook -i localhost --extra-vars "db_name=osticket username=osticket" -t "delete_user, remove_db" ansible/mysqlsetup.yml
rm -rf /tmp/mockup_db.sql
