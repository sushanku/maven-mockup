#!/usr/bin/env sh

echo 'Deploy before testing'
cp target/test-1.0-SNAPSHOT-jar-with-dependencies.jar mockup_db.sql /tmp
ansible-playbook -i ansible/hosts --limit localhost --extra-vars "db_name=mockup_db host=localhost username=mockup password=mockup123" --tags "create_db,add_user,import_db" ansible/mysqlsetup.yml
set -x
java -jar target/test-1.0-SNAPSHOT-jar-with-dependencies.jar &
set +x
cd testcase/
mvn test "-Dtest=Test.Runner"
cd ..
ansible-playbook -i ansible/hosts --limit --extra-vars "db_name=mockup_db username=mockup" -t "delete_user, remove_db" ansible/mysqlsetup.yml
rm -rf /tmp/mockup_db.sql
