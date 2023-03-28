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
          sh 'mvn clean deploy'
        }
      }
    }
  }