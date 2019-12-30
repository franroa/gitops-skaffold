pipeline {
  agent none
  stages {
    stage('Build') {
      agent {
        label "lead-toolchain-skaffold"
      }
      steps {
        container('skaffold') {
          scmSkip(deleteBuild: true, skipPattern:'[ci skip]')
          sh "skaffold build"
        }
      }
    }
  }
}
