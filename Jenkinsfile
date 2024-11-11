pipeline{
	agent any
	environment {
		IMAGE_NAME = "taniajose95/transaction_check"
		IMAGE_TAG = "${BUILD_NUMBER}"
	}
	stages{
		stage('Checkout'){
			steps(
				git 'https://github.com/taniajose95/transaction_check.git'
		)
		}
		stage('Build Docker Image'){
			steps{
			script{
				docker.build{"${IMAGE_NAME}:${IMAGE_TAG}"}

			}
			}
		}
		stage('Push Docker Image'){
			steps{
				script{
				docker.withRegistry('', 'dockerhub-credentials')
				{
				docker.image("${IMAGE_NAME}:${IMAGE_TAG}").push()	
				}
				}
			}
		}	
		stage('Deploy to Kubernetes'){
		            steps {
                script {
                    sh 'sed -i "s/IMAGE_TAG/${IMAGE_TAG}/g" k8s/deploy.yaml'
                    sh 'kubectl apply -f k8s/deploy.yaml'
                }
            }
		}
	}
	
	

}
