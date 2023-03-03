pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {               
                git branch: 'main', credentialsId: 'git-for-jenkins', url: 'https://github.com/vk2011/Multibranch-project.git'
                sh 'echo "Branch name: ${GIT_BRANCH}"'
                echo 'git pull successful'                   
            }
        }
        stage('Docker-compose Build'){
                when {
                    branch "dev"
                }
                steps{
                    sshagent(['windows-ssh-key']) {
                    sh 'ssh -o StrictHostKeyChecking=no -l vedant 192.168.0.180 uname -a'               
                    }                    
                    // bat "docker info"
                    bat "docker --version"
                    bat "docker-compose --version"
                    bat "docker container prune -f"
                    bat "docker-compose build"                        
                    // bat "docker-compose up"                   
                }
                
            
        }
        stage('deploy_dev'){
            when {
                branch "dev"
            } 
            steps{
                sshagent(['windows-ssh-key']) {
                sh 'ssh -o StrictHostKeyChecking=no -l vedant 192.168.0.180'                                         
                }
                bat "docker-compose up"
            }
        }
        stage('deploy_qa'){
            when {
                branch "qa"
            } 
            steps{
                sshagent(['windows-ssh-key']) {
                sh 'ssh -o StrictHostKeyChecking=no -l vedant 192.168.0.180'                                         
                }
                bat "docker-compose up"
            }
        }
        stage('deploy_main'){
            when {
                branch "main"
            } 
            steps{
                sshagent(['windows-ssh-key']) {
                sh 'ssh -o StrictHostKeyChecking=no -l vedant 192.168.0.180'                                         
                }
                bat "docker-compose up"
            }
        }            
    }
}
