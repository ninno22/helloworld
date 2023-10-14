pipeline {
    agent any 
    environment {
        DOCKER_HUB_CREDENTIALS = 'Your_Docker_Hub_Credentials_ID'
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build and Test') {
            steps {
                sh 'docker build -t my_fastapi_app:latest .'
            }
        }
        stage('Push to Docker Hub') {
            steps {
                withCredentials([string(credentialsId: env.DOCKER_HUB_CREDENTIALS, variable: 'DOCKER_HUB_PASS')]) {
                    sh '''
                        echo "$DOCKER_HUB_PASS" | docker login --username your_dockerhub_username --password-stdin
                        docker tag my_fastapi_app:latest your_dockerhub_username/my_fastapi_app:latest
                        docker push your_dockerhub_username/my_fastapi_app:latest
                    '''
                }
            }
        }
        stage('Deploy to Server') {
            steps {
                sshagent(credentials: ['Your_SSH_Credentials_ID']) {
                    sh '''
                        ssh your_username@your_application_server_ip "docker pull your_dockerhub_username/my_fastapi_app:latest && docker stop my_fastapi_app || true && docker rm my_fastapi_app || true && docker run --name my_fastapi_app -d -p 8000:80 your_dockerhub_username/my_fastapi_app:latest"
                    '''
                }
            }
        }
    }
}
