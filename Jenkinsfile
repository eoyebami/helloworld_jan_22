pipeline {
    agent any
    tools {
  maven 'M2_HOME'
}
  environment {
        NEXUS_VERSION = "nexus3"
        NEXUS_PROTOCOL = "http"
        NEXUS_URL = "54.86.23.84:8081"
        NEXUS_REPOSITORY = "mvn-app"
        NEXUS_CREDENTIAL_ID = "nexus-repo-manager"
        IMAGE_REPO_NAME = "mavenpipeline"
        REPOSITORY_URI = "738921266859.dkr.ecr.us-east-1.amazonaws.com/${IMAGE_REPO_NAME}"
        registryCredentials = "aws_key"
        dockerimage = ""
    }
     stages{
      stage('Git clone'){
       steps {
         git branch: 'main', url: 'https://github.com/eoyebami/helloworld_jan_22.git'
       }
    }

      stage('Build & SonarQube Analysis'){
        agent {
      docker {image 'maven:3.8.6-openjdk-11-slim' }
            }
        steps {
          withSonarQubeEnv( installationName: 'SonarServer', credentialsId : 'sonar_token') {
            sh 'mvn verify sonar:sonar -Dsonar.projectKey=eoyebami_helloworld_jan_22 -Dsonar.java.binaries=.'
          }
        }
      }

      stage("Quality Gate") {
            steps {
              echo 'Checking Quality Gate ....'
              script {
                  timeout(time: 20, unit: 'MINUTES') {
                    def qg = waitForQualityGate()
                    if (qg.status != 'OK') {
                      error "Pipeline stopped because of quality gate status: ${qg.status}"
              }
            }
          }
        }   
      }

      stage('Maven clean, install, package'){
        steps {
          sh 'mvn clean install package'
        }
      }

      stage('Maven Pom Uploader'){
        steps {
           
          script {
          def mavenPom = readMavenPom file: 'pom.xml'

          nexusArtifactUploader artifacts:
           [[artifactId: "${mavenPom.artifactId}",
            classifier: '',
             file: "/var/lib/jenkins/workspace/mvn-sonar-nexus/?/.m2/repository/com/example/maven-project/maven-project/1.0-SNAPSHOT/${mavenPom.artifactId}-${mavenPom.version}.${mavenPom.packaging}",
              type: "${mavenPom.packaging}"]],
               credentialsId: NEXUS_CREDENTIAL_ID ,
                groupId: "${mavenPom.groupId}",
                 nexusUrl: NEXUS_URL ,
                  nexusVersion: NEXUS_VERSION ,
                   protocol: NEXUS_PROTOCOL ,
                    repository: NEXUS_REPOSITORY ,
                     version: "${mavenPom.version}"
          }
        }
      }

      stage('Server Jar Uploader'){
        steps {
           
          script {
            dir('/var/lib/jenkins/workspace/mvn-sonar-nexus/server/') {
          def mavenPom = readMavenPom file: 'pom.xml'

          nexusArtifactUploader artifacts:
           [[artifactId: "${mavenPom.artifactId}",
            classifier: '',
             file: "target/${mavenPom.artifactId}-${mavenPom.version}.${mavenPom.packaging}",
              type: "${mavenPom.packaging}"]],
               credentialsId: NEXUS_CREDENTIAL_ID ,
                groupId: "${mavenPom.groupId}",
                 nexusUrl: NEXUS_URL ,
                  nexusVersion: NEXUS_VERSION ,
                   protocol: NEXUS_PROTOCOL ,
                    repository: NEXUS_REPOSITORY ,
                     version: "${mavenPom.version}"
            }
          }
        }
      }
      
      stage('Webapp war Uploader'){
        steps {
           
          script {
            dir('/var/lib/jenkins/workspace/mvn-sonar-nexus/webapp/') {
          def mavenPom = readMavenPom file: 'pom.xml'

          nexusArtifactUploader artifacts:
           [[artifactId: "${mavenPom.artifactId}",
            classifier: '',
             file: "target/${mavenPom.artifactId}-${mavenPom.version}.${mavenPom.packaging}",
              type: "${mavenPom.packaging}"]],
               credentialsId: NEXUS_CREDENTIAL_ID ,
                groupId: "${mavenPom.groupId}",
                 nexusUrl: NEXUS_URL ,
                  nexusVersion: NEXUS_VERSION ,
                   protocol: NEXUS_PROTOCOL ,
                    repository: NEXUS_REPOSITORY ,
                     version: "${mavenPom.version}"
            }
          }
        }
      }

      stage('Build Docker image'){
        steps {
          script{
            def mavenPom = readMavenPom file: 'pom.xml'
            sh 'docker login -u AWS -p $(aws ecr get-login-password --region us-east-1) $REPOSITORY_URI'
            dockerimage = docker.build "${IMAGE_REPO_NAME}:${mavenPom.version}"
          }
        }
      }

      stage('Push Docker image to ECR'){
        steps {
          script {
             def mavenPom = readMavenPom file: 'pom.xml'
            sh "docker tag ${IMAGE_REPO_NAME}:${mavenPom.version} ${REPOSITORY_URI}:${mavenPom.version}"
            sh "docker push ${REPOSITORY_URI}:${mavenPom.version}"
            }
          }
        }
      }
    }