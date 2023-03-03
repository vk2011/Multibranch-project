pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {               
                git branch: '$GIT_BRANCH', credentialsId: 'git-for-jenkins', url: 'https://github.com/vk2011/Multibranch-project.git'                    
            }
        }
        stage('Docker-compose Build'){
            steps{
                when {
                    expression { env.BRANCH_NAME == 'production' }
                }
                step{
                    sshagent(['windows-ssh-key']) {
                    sh 'ssh -o StrictHostKeyChecking=no -l <username> <ipaddress>'               
                    } 
                }   
                step{                    
                    // bat "docker info"
                    bat "docker --version"
                    bat "docker-compose --version"
                    bat "docker container prune -f"
                    bat "docker-compose build"                        
                    // bat "docker-compose up"                   
                }
                
            }
        }
        stage('docker-compose up'){
            steps{
                step{
                    when(env.BRANCH_NAME == 'dev'){ 
                        sshagent(['windows-ssh-key']) {
                        sh 'ssh -o StrictHostKeyChecking=no -l <username> <ipaddress>'                                         
                        }
                        bat "docker-compose up"
                    }
                    // when(env.BRANCH_NAME == 'qa'){
                    //     sshagent(['credential ID']) {
                    //     sh 'ssh -o StrictHostKeyChecking=no -l <username> <ipaddress>'                                         
                    //     }    
                    //     bat "docker-compose up"
                    // }
                    // when(env.BRANCH_NAME == 'qa'){
                    //     sshagent(['credential ID']) {
                    //     sh 'ssh -o StrictHostKeyChecking=no -l <username> <ipaddress>'                                         
                    //     }    
                    //     bat "docker-compose up"

                    // }
                }
            }
        }   
    }
}