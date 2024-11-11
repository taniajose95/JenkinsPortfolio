pipeline {
    agent any
    environment {
        IMAGE_NAME = "taniajose95/transaction_check"
        IMAGE_TAG = "${BUILD_NUMBER}"
    }
    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/taniajose95/JenkinsPortfolio.git', branch: 'main', credentialsId: 'github_cred'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${IMAGE_NAME}:${IMAGE_TAG}")
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('', 'e132848b-4ec1-49e5-89e7-73329b4c2d56') {
                        docker.image("${IMAGE_NAME}:${IMAGE_TAG}").push()
                    }
                }
            }
        }
        stage('Install kubectl') {
            steps {
                script {
                    // Install kubectl
                    sh '''
                        curl -LO "https://dl.k8s.io/release/v1.26.0/bin/linux/amd64/kubectl"
                        chmod +x ./kubectl
                        mv ./kubectl /usr/local/bin/kubectl
                    '''
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    // Update image tag in deployment YAML
                    sh 'sed -i "s/IMAGE_TAG/${IMAGE_TAG}/g" k8s/deploy.yaml'
                    // Apply the deployment to Kubernetes
                    sh 'kubectl apply -f k8s/deploy.yaml'
                }
            }
        }
    }
}

