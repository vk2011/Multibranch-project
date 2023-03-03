pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {               
                git branch: '${BRANCH_NAME}', credentialsId: 'git-for-jenkins', url: 'https://github.com/vk2011/Multibranch-project.git'
                sh 'echo "Branch name: ${BRANCH_NAME}"'
                sh 'echo "Branch name: ${GIT_BRANCH}"'
                echo 'git pull successful'                   
            }
        }
        stage ('Declare Variables'){
            steps {
                script{
                    switch(env.GIT_BRANCH) {
                        case 'origin/qa':
                            env.DEPLOY_ENV = "qa"
                            break
                        case 'origin/main':
                            env.DEPLOY_ENV = "main"
                            break
                        default:
                            env.DEPLOY_ENV = "dev"
                            break 
                    }
                }
                sh 'echo "${DEPLOY_ENV}"'
            }
        }
        stage('Docker-compose Build'){
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
//         stage('deploy_dev'){
//             when {
//                 branch "dev"
//             } 
//             steps{
//                 sshagent(['windows-ssh-key']) {
//                 sh 'ssh -o StrictHostKeyChecking=no -l vedant 192.168.0.180'                                         
//                 }
//                 bat "docker-compose up"
//             }
//         }
//         stage('deploy_qa'){
//             when {
//                 branch "qa"
//             } 
//             steps{
//                 sshagent(['windows-ssh-key']) {
//                 sh 'ssh -o StrictHostKeyChecking=no -l vedant 192.168.0.180'                                         
//                 }
//                 bat "docker-compose up"
//             }
//         }
//         stage('deploy_main'){
//             when {
//                 branch "main"
//             } 
//             steps{
//                 sshagent(['windows-ssh-key']) {
//                 sh 'ssh -o StrictHostKeyChecking=no -l vedant 192.168.0.180'                                         
//                 }
//                 bat "docker-compose up"
//             }
//         }    
                
     }
 }
