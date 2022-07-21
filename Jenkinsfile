pipeline {
  agent any
  stages {  
    stage('Install Deps') {
      steps {
        //Install dependecies
        withMaven {
          sh "mvn clean verify"
        }
      }
    }
        
    stage ('OWASP Dependency-Check Vulnerabilities') {
      steps {
        dependencyCheck additionalArguments: ''' 
        -o "./" 
        -s "./"
        -f "ALL" 
        --prettyPrint''', odcInstallation: 'OWASP-DC'
        dependencyCheckPublisher pattern: 'dependency-check-report.xml'
      }
    }    
  }
  options {
    skipStagesAfterUnstable()
  }
}
