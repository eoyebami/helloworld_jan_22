pipeline {
    agent any
    tools {
  maven 'M2_HOME'
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
          nexusArtifactUploader artifacts: [[artifactId: '${POM_ARTIFACTID}', classifier: '', file: 'target/${POM_ARTIFACTID}-${POM_VERSION}.${POM_PACKAGING}', type: '${POM_PACKAGING}']], credentialsId: 'nexus-credentials', groupId: '${POM_GROUPID}', nexusUrl: '100.24.60.118:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'mvn-app', version: '${POM_VERSION}'
        }
      }
    
    }

}
