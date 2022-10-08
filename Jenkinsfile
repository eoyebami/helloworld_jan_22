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
          dir('/var/lib/jenkins/workspace/mvn-automated/webapp/') {
    sh 'mvn clean install package'
          }
      
        }
      }
      stage('Nexus Artifactory Uploader'){
        steps {
          nexusArtifactUploader artifacts:
           [[artifactId: "${POM_ARTIFACTID}",
            classifier: '',
             file: "webapp/target/${POM_ARTIFACTID}-${POM_VERSION}.${POM_PACKAGING}",
              type: "${POM_PACKAGING}"]],
               credentialsId: NEXUS_CREDENTIAL_ID ,
                groupId: "${POM_GROUPID}",
                 nexusUrl: NEXUS_URL ,
                  nexusVersion: NEXUS_VERSION ,
                   protocol: NEXUS_PROTOCOL ,
                    repository: NEXUS_REPOSITORY ,
                     version: "${POM_VERSION}"
        }
      }
    
    }

}
