pipeline {
  agent any
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

  post {
    always {
      sh 'docker-compose down -v'
    }
  }
}
