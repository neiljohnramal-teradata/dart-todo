pipeline {
  agent { dockerfile true }
  stages {
    stage('Build') {
      steps {
        sh 'docker-compose up -d --build'
      }
    }

    stage('Test') {
      steps {
        sh 'docker-compose run todo_dart_app pub run test -r expanded'
      }
    }
  }
}
