pipeline {
  agent any
  stages {
    stage("Compile") {
      steps {
        sh "javac app/src/main/java/commit_pipeline/App.java"
        echo "Code Compile Completed!"
      }
    }
  }
}
