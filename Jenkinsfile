pipeline {
    agent any

    environment {
        AWS_CREDENTIALS_FILE = './aws_credentials.env'
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
                echo '🔐 Loading AWS credentials from file...'
                script {
                    def envContent = readFile(file: "${env.AWS_CREDENTIALS_FILE}").split('\n')
                    for (line in envContent) {
                        if (line.trim() && !line.startsWith('#')) {
                            def (key, value) = line.tokenize('=')
                            env."${key.trim()}" = value.trim()
                        }
                    }
                }
            }
        }

        stage('Verify AWS CLI') {
            steps {
                echo '🔍 Verifying AWS CLI version...'
                sh 'aws --version'
            }
        }

        stage('Check AWS Identity') {
            steps {
                echo '🧾 Checking AWS identity...'
                sh 'aws sts get-caller-identity'
            }
        }

        stage('Build Infra') {
            steps {
                echo '🔧 Building infrastructure...'
                sh './build.sh'
            }
        }

        stage('Test Infra') {
            steps {
                echo '🧪 Testing infrastructure...'
                sh './test.sh'
            }
        }

        stage('Deploy Resources') {
            steps {
                echo '🚀 Deploying resources...'
                sh './deploy.sh'
            }
        }
    }

    post {
        success {
            echo '✅ Pipeline succeeded.'
        }
        failure {
            echo '❌ Pipeline failed.'
        }
        always {
            echo '📦 Pipeline completed.'
        }
    }
}
