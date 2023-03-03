pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {               
                git branch: '$GIT_BRANCH', credentialsId: 'git-for-jenkins', url: 'https://github.com/vk2011/Multibranch-project.git'
                echo 'git pull successful'                   
            }
        }
        stage('Docker-compose Build'){
                when {
                    branch "*"
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
        // stage('docker-compose up'){
        //     steps{
        //         steps{
        //             when(env.BRANCH_NAME == 'main'){ 
        //                 sshagent(['windows-ssh-key']) {
        //                 sh 'ssh -o StrictHostKeyChecking=no -l vedant 192.168.0.180'                                         
        //                 }
        //                 bat "docker-compose up"
        //             }
        //             when(env.BRANCH_NAME == 'qa'){
        //                 sshagent(['credential ID']) {
        //                 sh 'ssh -o StrictHostKeyChecking=no -l <username> <ipaddress>'                                         
        //                 }    
        //                 bat "docker-compose up"
        //             }
        //             when(env.BRANCH_NAME == 'qa'){
        //                 sshagent(['credential ID']) {
        //                 sh 'ssh -o StrictHostKeyChecking=no -l <username> <ipaddress>'                                         
        //                 }    
        //                 bat "docker-compose up"

        //             }             
        //         }
        //     }
        // }   
    }
}