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
                sh 'mvn clean deploy'
                }
            }

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
    }
    }
