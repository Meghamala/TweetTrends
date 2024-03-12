def registry = 'https://tweet14.jfrog.io'
def imageName = 'tweet14.jfrog.io/ttrend-docker-local/ttrend'
def version   = '0.0.1-SNAPSHOT'
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

      //  stage("Quality Gate"){
      //  steps{
      //  script{
      //    timeout(time: 1, unit: 'HOURS') { // Just in case something goes wrong, pipeline will be killed after a timeout
      //      def qg = waitForQualityGate() // Reuse taskId previously collected by withSonarQubeEnv
      //      if (qg.status != 'OK') {
      //        error "Pipeline aborted due to quality gate failure: ${qg.status}"
      //      }
      //    }
      //  }
      //  }
      //  }

      //  stage("Jar Publish") {
      //          steps {
      //              script {
      //                      echo '<--------------- Jar Publish Started --------------->'
      //                       def server = Artifactory.newServer url:registry+"/artifactory" ,  credentialsId:"artifact-cred"
      //                       def properties = "buildid=${env.BUILD_ID},commitid=${GIT_COMMIT}";
      //                       def uploadSpec = """{
      //                            "files": [
      //                              {
      //                                "pattern": "jarstaging/(*)",
      //                                "target": "tweet-maven-libs-release-local/",
      //                                "flat": "false",
      //                                "props" : "${properties}",
      //                                "exclusions": [ "*.sha1", "*.md5"]
      //                              }
      //                           ]
      //                       }"""
      //                       def buildInfo = server.upload(uploadSpec)
      //                       buildInfo.env.collect()
      //                       server.publishBuildInfo(buildInfo)
      //                       echo '<--------------- Jar Publish Ended --------------->'

      //              }
      //          }
      //      }

        stage(" Docker Build ") {
      steps {
        script {
           echo '<--------------- Docker Build Started --------------->'
           app = docker.build(imageName+":"+version)
           echo '<--------------- Docker Build Ends --------------->'
        }
      }
    }

            stage (" Docker Publish "){
        steps {
            script {
               echo '<--------------- Docker Publish Started --------------->'  
                docker.withRegistry(registry, 'artifact-cred'){
                    app.push()
                }    
               echo '<--------------- Docker Publish Ended --------------->'  
            }
        }
    }

stage(" Deploy ") {
       steps {
         script {
            echo '<--------------- Helm Deploy Started --------------->'
            sh 'helm install ttrend ttrend-1.0.1.tgz'
            echo '<--------------- Helm deploy Ends --------------->'
         }
       }
     }  


    }
    }
