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
                    // Install kubectl to a directory with write permissions
                    sh '''
                        curl -LO "https://dl.k8s.io/release/v1.26.0/bin/linux/amd64/kubectl"
                        chmod +x ./kubectl
			mkdir /home/myjenkins
			chmod 755 /home/myjenkins
                        mv ./kubectl /home/myjenkins
                    '''
                    // Add kubectl to PATH
                    sh '''
                        echo "export PATH=\$PATH:/home/myjenkins" >> ~/.bashrc
                        source ~/.bashrc
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
                    sh '/home/jenkins/kubectl apply -f k8s/deploy.yaml'
                }
            }
        }
    }
}

