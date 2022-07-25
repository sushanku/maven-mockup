pipeline {
  agent any
  stages {  
    stage('Install Deps') {
      steps {
        //Install dependecies
        withMaven (maven: 'maven') {
          sh "mvn compile"
        }
      }
    }
    stage('SonarQube Analysis') {
      steps {
        withSonarQubeEnv('sonar-jenkins-scanner') {
          withMaven (maven: 'maven') {
          sh "mvn clean verify sonar:sonar -Dsonar.projectKey=random-project"
          }
        }
      }
    }
        
    stage ('OWASP Dependency-Check Vulnerabilities') {
      steps {
        dependencyCheck additionalArguments: ''' 
        -o "./" 
        --scan "./"
        -f "ALL" 
        --prettyPrint''', odcInstallation: 'OWASP-DC'
        dependencyCheckPublisher pattern: 'dependency-check-report.xml'
      }
    }    
  }
}
