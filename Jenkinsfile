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
                        case 'qa':
                            env.DEPLOY_ENV = "qa"
                            break
                        case 'main':
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
                // sh "docker info"
                sh "docker --version"
                sh "docker-compose --version"
                sh "docker container prune -f"
                sh "docker-compose build"
                echo "Build successful"                        
                // sh "docker-compose up"
                sh 'docker save docker.io/library/fastapi_image -o image.tar'
            }
        }
        stage('transfer build code'){
            environment {
                REMOTE_HOST = credentials("FastAPI-${DEPLOY_ENV}-remote-host")
                REMOTE_USER = credentials("FastAPI-${DEPLOY_ENV}-remote-user")
                RWD = "deployments/FastAPI/${DEPLOY_ENV}"
            }
            steps {
                sshagent(["windows-ssh-key"]) {


                    // Check SSH Connection
                    sh 'ssh -o StrictHostKeyChecking=no ${REMOTE_USER}@${REMOTE_HOST} "ls"'
                    sh 'ssh ${REMOTE_USER}@${REMOTE_HOST} "rm -rf ${RWD}"'
                    sh 'ssh ${REMOTE_USER}@${REMOTE_HOST} "mkdir -p ${RWD}"'


                    // Transfer required files on server
                    sh 'scp -r images.tar ${REMOTE_USER}@${REMOTE_HOST}:${RWD}/'
                    sh 'scp -r docker/docker-compose.yml ${REMOTE_USER}@${REMOTE_HOST}:${RWD}/'
                    sh 'scp -r docker/compose/dev.yml ${REMOTE_USER}@${REMOTE_HOST}:${RWD}/'
                }
            }          
        }
        
        stage('deploy on dev'){
            when {
                expression {env.DEPLOY_ENV == 'dev'}
            } 
            steps{
                sshagent(['windows-ssh-key']) {
                sh 'ssh -o StrictHostKeyChecking=no -l ${REMOTE_USER}@${REMOTE_HOST}'                                         
                }
                echo 'deploying on dev server'
                sh "docker-compose down"
                sh "docker-compose up"
            }
        }
        stage('deploy on qa'){
            when {
                expression {env.DEPLOY_ENV == 'qa'}
            }
            steps{
                sshagent(['windows-ssh-key']) {
                sh 'ssh -o StrictHostKeyChecking=no -l ${REMOTE_USER}@${REMOTE_HOST}'                                         
                }
                echo 'deploying on qa server'
                sh "docker-compose down"
                sh "docker-compose up"
            }
        }
        stage('deploy on prod'){
            when {
                expression {env.DEPLOY_ENV == 'main'}
            } 
            steps{
                sshagent(['windows-ssh-key']) {
                sh 'ssh -o StrictHostKeyChecking=no -l ${REMOTE_USER}@${REMOTE_HOST}'                                         
                }
                echo 'deploying on prod server'
                sh "docker-compose down"
                sh "docker-compose up"
            }
        }    
                
    }
}
