pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {               
                git branch: 'main', credentialsId: 'git-for-jenkins', url: 'https://github.com/vk2011/docker-fastapi-test.git'                    
            }
        }
        stage('Docker-compose Build'){
            steps{
                bat "docker info"
                bat "docker --version"
                bat "docker-compose --version"
                bat "docker container prune -f"
                bat "docker-compose build"
                bat "docker-compose up"
                
            }
        }
    }
}