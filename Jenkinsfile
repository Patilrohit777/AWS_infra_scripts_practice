pipeline {
    agent any

    environment {
        BASH = '"C:\\Program Files\\Git\\bin\\bash.exe"'
        AWS_REGION = 'us-east-1'  // Set your desired AWS region
    }

    stages {
        stage('Configure AWS Credentials') {
            steps {
                echo "🔐 Setting up AWS credentials..."
                withCredentials([
                    usernamePassword(
                        credentialsId: 'aws-credentials',
                        usernameVariable: 'AWS_ACCESS_KEY_ID',
                        passwordVariable: 'AWS_SECRET_ACCESS_KEY'
                    )
                ]) {
                    bat """
                    ${BASH} -c "mkdir -p ~/.aws"
                    ${BASH} -c "echo '[default]' > ~/.aws/credentials"
                    ${BASH} -c "echo 'aws_access_key_id=${AWS_ACCESS_KEY_ID}' >> ~/.aws/credentials"
                    ${BASH} -c "echo 'aws_secret_access_key=${AWS_SECRET_ACCESS_KEY}' >> ~/.aws/credentials"
                    ${BASH} -c "echo '[default]' > ~/.aws/config"
                    ${BASH} -c "echo 'region=${AWS_REGION}' >> ~/.aws/config"
                    ${BASH} -c "aws sts get-caller-identity"
                    """
                }
            }
        }

        stage('Build Infra') {
            steps {
                echo '🏗️ Running build.sh to provision AWS resources...'
                bat "${BASH} ./build.sh"
            }
        }

        stage('Test Infra') {
            steps {
                echo '🔍 Running test.sh to test AWS infrastructure...'
                bat "${BASH} ./test.sh"
            }
        }

        stage('Deploy Resources') {
            steps {
                echo '🚀 Running deploy.sh to deploy services...'
                bat "${BASH} ./deploy.sh"
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
