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
        stage('docker-compose up'){
                when {
                    branch "dev"
                } 
                steps{
                    sshagent(['windows-ssh-key']) {
                    sh 'ssh -o StrictHostKeyChecking=no -l vedant 192.168.0.180'                                         
                    }
                    bat "docker-compose up"
                }
                when {
                    branch "qa"
                }
                steps{ 
                    sshagent(['credential ID']) {
                    sh 'ssh -o StrictHostKeyChecking=no -l <username> <ipaddress>'                                         
                    }    
                    bat "docker-compose up"
                }
                     when {
                    branch "main"
                }
                steps{
                    sshagent(['credential ID']) {
                    sh 'ssh -o StrictHostKeyChecking=no -l <username> <ipaddress>'                                         
                    }    
                    bat "docker-compose up"
                }
        }             
    }
}
