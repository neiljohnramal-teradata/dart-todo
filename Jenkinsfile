pipeline {
  agent {
    docker { image 'google/dart' }
    stages {
      stage('build') {
        steps {
          sh 'dart --version'
        }
      }
    }
  }
}