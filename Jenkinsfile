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
