pipeline {
  agent {
    docker { image 'google/dart' }
  }
  stages {
    stage('Build') {
      steps {
        sh 'pub get --no-precompile'
      }
    }

    stage('Test') {
      steps {
        sh 'pub run test -r expanded'
      }
    }
  }
}
