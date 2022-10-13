pipeline {
    agent {
      docker {
        image 'maven:3.8.6-openjdk-18'
  }
}
    tools {
  maven 'M2_HOME'
}
  environment {
        NEXUS_VERSION = "nexus3"
        NEXUS_PROTOCOL = "http"
        NEXUS_URL = "54.145.114.69:8081"
        NEXUS_REPOSITORY = "mvn-app"
        NEXUS_CREDENTIAL_ID = "nexus-repo-manager"
    }
     stages{
      stage('Git clone'){
       steps {
         git branch: 'main', url: 'https://github.com/eoyebami/helloworld_jan_22.git'
       }
    }
      stage('Build & SonarQube Analysis'){
        agent any
        steps {
          withSonarQubeEnv( installationName: 'SonarServer' , credentialsId: 'sonar_token') {
            sh 'verify org.sonarsource.scanner.maven:sonar-maven-plugin:sonar -Dsonar.projectKey=eoyebami_helloworld_jan_22'
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
             file: "/var/lib/jenkins/.m2/repository/com/example/maven-project/maven-project/1.0-SNAPSHOT/${mavenPom.artifactId}-${mavenPom.version}.${mavenPom.packaging}",
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
            dir('/var/lib/jenkins/workspace/mvn-total-int-pipeline/server/') {
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
            dir('/var/lib/jenkins/workspace/mvn-total-int-pipeline/webapp/') {
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
    }
  }