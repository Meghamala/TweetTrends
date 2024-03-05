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
//         stage('Clone-code') {
//             steps {
//                 git 'https://github.com/Meghamala/TweetTrends.git'
//             }
//         }
            stage('build'){
                steps{
                    sh 'mvn clean deploy'
                }
           }
    }
}
