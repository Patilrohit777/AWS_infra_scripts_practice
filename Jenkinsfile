pipeline {
    agent any

    environment {
        BASH = '"C:\\Program Files\\Git\\bin\\bash.exe"'  // Quoted for use in bat steps
    }

    stages {
        stage('Build') {
            steps {
                echo "===================================================================="
                echo 'Building the project for first stage...'
                bat "${BASH} ./build.sh"
                echo "===================================================================="
            }
        }

        stage('Test') {
            steps {
                echo 'Building Docker Image...'
                bat "${BASH} ./test.sh"
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying to the server...'
                bat "${BASH} ./deploy.sh"
            }
        }
    }

    post {
        always {
            echo 'This will always run after the pipeline completes.'
        }
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}
