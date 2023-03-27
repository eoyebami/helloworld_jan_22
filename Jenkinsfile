pipeline {
    agent any
    tools {
  maven 'maven3'
}
     stages{
      stage('Git clone'){
       steps {
         git branch: 'main', url: 'https://github.com/eoyebami/helloworld_jan_22.git'
       }
    }
      stage('mvn build'){
        steps {
          sh 'mvn clean package'
        }
      }
    }
  }