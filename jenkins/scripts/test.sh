#!/usr/bin/env sh

echo 'Deploy before testing'
mysql -u mockup -phellomoco mockup_db < mockup_db.sql
set -x
java -jar target/test-1.0-SNAPSHOT-jar-with-dependencies.jar &
set +x
cd testcase/
mvn clean install
mvn test "-Dtest=Test.Runner"
