pipeline {
  agent any
  stages {  
    stage('Install Deps') {
      steps {
        //Install dependecies
        sh 'mvn dependency:resolve'
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
