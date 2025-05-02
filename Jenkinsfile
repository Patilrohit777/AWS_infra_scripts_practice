pipeline {
    agent any
    environment {
        sh = "C:/Program Files/Git/bin/bash.exe"
    }
    stages {
        stage('Build') {
            steps {
		echo "===================================================================="
                echo 'Building the project for first stage...'
		bat '"C:\\Program Files\\Git\\bin\\bash.exe" "./build.sh"'
			          echo "===================================================================="
                // Add your build commands here, e.g., running a build tool like Maven or Gradle
            }
        }

        stage('Test') {
            steps {
                echo 'Building Docker Image...'
		script {
		    bat '"C:\\Program Files\\Git\\bin\\bash.exe" './test.sh'
				}
                // Add your test commands here, e.g., running unit tests
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying to the server...'
				script {
				sh 'chmod +x script.sh'
		    sh './deploy.sh'
				}
                // Add your deploy commands here, e.g., deploying to a staging server
            }
        }
    }

    post {
        always {
            echo 'This will always run after the pipeline completes.'
            // Cleanup or other tasks you want to run regardless of success or failure
        }
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}

