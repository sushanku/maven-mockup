pipeline {
  agent any
  stages {
    stage('Build') {
      post {
        failure {
          emailext(attachmentsPattern: 'testcase/target/surefire-reports/*html', subject: "Jenkins Build ${currentBuild.currentResult}: Job ${env.JOB_NAME}", body: "${currentBuild.currentResult}: Job ${env.JOB_NAME} build ${env.BUILD_NUMBER} \n More info at: ${env.BUILD_URL}", attachLog: true, to: 'sushan@moco.com.np', from: 'sysadmin@moco.com.np')
        }

      }
      steps {
        sh 'mvn clean install'
      }
    }

    stage('Test') {
      post {
        always {
          emailext(subject: "Jenkins Build ${currentBuild.currentResult}: Job ${env.JOB_NAME}", body: "${currentBuild.currentResult}: Job ${env.JOB_NAME} build ${env.BUILD_NUMBER} \n More info at: ${env.BUILD_URL}", attachLog: true, to: 'sushan@moco.com.np', from: 'sysadmin@moco.com.np')
          junit 'testcase/target/surefire-reports/*xml'
        }

      }
      steps {
        sh 'sh jenkins/scripts/test.sh'
        archiveArtifacts 'testcase/target/surefire-reports/*html'
      }
    }

    stage('Deploy') {
      steps {
        sh 'sh jenkins/scripts/deploy.sh'
        input 'Finished using the mockup maven app? (Click "Proceed" to continue)'
        sh 'sh jenkins/scripts/kill.sh'
        sh 'echo Thank You'
      }
    }

  }
  options {
    skipStagesAfterUnstable()
  }
}
