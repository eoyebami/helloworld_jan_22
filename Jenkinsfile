pipeline {
    agent any
    tools {
  maven 'maven3'
}
     stages{
      stage('Git clone'){
       steps {
         checkout scmGit(branches: [[name: '*/feature1']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/eoyebami/helloworld_jan_22.git']])
       }
    }
    stage('mvn build'){
        steps {
            withMaven(globalMavenSettingsConfig: '87ddb0c3-60b0-474b-a867-ce0c6404df8c', maven: 'maven3', publisherStrategy: 'EXPLICIT') {
                sh 'mvn clean deploy'
            }    
        }
      }
    }
  }