pipeline {
    agent {
        node{
            label 'maven-slave'
        }
    }

environment{
    PATH = "/opt/apache-maven-3.9.6/bin:$PATH"
   }
    stages {
        stage("build"){
            steps{
             echo "------------------build started---------------------"
                sh 'mvn clean deploy -Dmaven.test.skip=true'
                echo "------------------build ended---------------------"
                }
            }
        stage("test"){
        steps{
        echo "------------------unit test started---------------------"
            sh 'mvn surefire-report:report'
             echo "------------------unit test ended---------------------"
        }}

           stage('SonarQube analysis') {
           environment{
           scannerHome = tool 'tweet_sonar-scanner'; // name same what defined in jenkins
           }
           steps{
               withSonarQubeEnv('tweet_sonarqube-server') { // server
                 sh "${scannerHome}/bin/sonar-scanner"
               }
             }
           }

           stage("Quality Gate"){
           steps{
           script{
             timeout(time: 1, unit: 'HOURS') { // Just in case something goes wrong, pipeline will be killed after a timeout
               def qg = waitForQualityGate() // Reuse taskId previously collected by withSonarQubeEnv
               if (qg.status != 'OK') {
                 error "Pipeline aborted due to quality gate failure: ${qg.status}"
               }
             }
           }
           }
           }
    }
    }
