pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-1'  // or your preferred region
    }

    stages {
        stage('Checkout') {
            steps {
                echo '📥 Checking out code...'
                checkout scm
            }
        }

        stage('Load AWS Credentials') {
            steps {
                echo '🔐 Loading AWS credentials from Jenkins secrets...'
                withCredentials([
                    string(credentialsId: 'aws-access-key-id', variable: 'AWS_ACCESS_KEY_ID'),
                    string(credentialsId: 'aws-secret-access-key', variable: 'AWS_SECRET_ACCESS_KEY')
                ]) {
                    echo '✅ Credentials loaded into environment.'
                }
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
                sh 'aws sts get-caller-identity'
            }
        }

        stage('Build Infra') {
            steps {
                echo '🏗 Building infrastructure...'
                sh 'echo "Terraform/CloudFormation logic here"'
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
