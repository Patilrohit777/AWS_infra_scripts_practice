pipeline {
    agent any

    // No need to redefine AWS_REGION if it’s already in Global Environment Variables

    stages {
        stage('Checkout') {
            steps {
                echo '📥 Checking out code...'
                checkout scm
            }
        }

        stage('Verify AWS CLI') {
            steps {
                echo '🔍 Verifying AWS CLI is available...'
                sh 'aws --version'
            }
        }

        stage('Check AWS Identity') {
            steps {
                echo '🔎 Checking AWS identity...'
                sh '''
                echo "AWS Access Key: $AWS_ACCESS_KEY_ID"
                echo "AWS Secret Key: $AWS_SECRET_ACCESS_KEY"
                aws sts get-caller-identity
                '''
            }
        }

        stage('Build Infra') {
            steps {
                echo '🏗 Building infrastructure...'
                sh "./build.sh"
            }
        }

        stage('Test Infra') {
            steps {
                echo '🧪 Testing infrastructure...'
                sh 'echo "Infra test scripts go here"'
            }
        }

        stage('Deploy Resources') {
            steps {
                echo '🚀 Deploying application/resources...'
                sh 'echo "Deployment logic here"'
            }
        }
    }

    post {
        always {
            echo '📦 Pipeline completed.'
        }
        failure {
            echo '❌ Pipeline failed.'
        }
    }
}
