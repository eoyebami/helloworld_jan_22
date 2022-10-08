pipeline {
    agent any
    tools {
  maven 'M2_HOME'
}
  environment {
        NEXUS_VERSION = "nexus3"
        NEXUS_PROTOCOL = "http"
        NEXUS_URL = "54.172.230.136:8081"
        NEXUS_REPOSITORY = "mvn-app"
        NEXUS_CREDENTIAL_ID = "nexus-repo-manager"
    }
     stages{
      stage('Git clone'){
       steps {
         git branch: 'dev', url: 'https://github.com/eoyebami/helloworld_jan_22.git'
       }
    }
      stage('Maven clean, install, package'){
        steps {
          sh 'mvn clean install package'
      
        }
      }
      stage('Nexus Artifactory Uploader'){
        steps {
          script {
          def mavenPom = readMavenPom file: 'pom.xml'    

          nexusArtifactUploader artifacts:
           [[artifactId: "${mavenPom.artifactId}",
            classifier: '',
             file: "webapp/target/${mavenPom.artifactId}-${mavenPom.version}.${mavenPom.packaging}",
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
