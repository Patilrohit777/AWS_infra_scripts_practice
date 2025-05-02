pipeline {
    agent any

    environment {
        BASH = '"C:\\Program Files\\Git\\bin\\bash.exe"'
        AWS_REGION = 'us-east-1' // Update as needed
    }

    stages {
        stage('Verify AWS CLI') {
            steps {
                echo '🔍 Verifying AWS CLI is available...'
                bat """
                ${BASH} -c "aws --version"
                """
            }
        }

        stage('Configure AWS Credentials') {
            steps {
                echo '🔐 Setting up AWS credentials...'
                withAWS(credentials: 'aws-credentials', region: "${AWS_REGION}") {
                    bat """
                    ${BASH} -c "aws sts get-caller-identity"
                    """
                }
            }
        }

        stage('Build Infra') {
            steps {
                echo '🏗️ Running build.sh to provision AWS resources...'
                withAWS(credentials: 'aws-credentials', region: "${AWS_REGION}") {
                    bat "${BASH} ./build.sh"
                }
            }
        }

        stage('Test Infra') {
            steps {
                echo '🧪 Running test.sh to validate infrastructure...'
                withAWS(credentials: 'aws-credentials', region: "${AWS_REGION}") {
                    bat "${BASH} ./test.sh"
                }
            }
        }

        stage('Deploy Resources') {
            steps {
                echo '🚀 Running deploy.sh to deploy services...'
                withAWS(credentials: 'aws-credentials', region: "${AWS_REGION}") {
                    bat "${BASH} ./deploy.sh"
                }
            }
        }
    }

    post {
        always {
            echo '📦 Pipeline completed.'
        }
        success {
            echo '✅ Pipeline succeeded!'
        }
        failure {
            echo '❌ Pipeline failed.'
        }
    }
}
