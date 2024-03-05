pipeline {
    agent {
        node{
            label 'maven-slave'
        }
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
