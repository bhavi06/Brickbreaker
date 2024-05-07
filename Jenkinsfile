pipeline{
    agent any
    tools{
        maven 'maven_3_9_6'
    }
    stages{
        stage('checkout scm'){
            steps{
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/bhavi06/Brickbreaker.git']])
            }
        }
        stage('Build maven tool') {
            steps{
            script{
                sh 'mvn clean install'
              }
            }
        }
        stage('Build docker image'){
            steps{
              script{
                sh 'docker build -t bhavi/brickbreaker .'
              }
            }
        }
        stage('Push an image to docker hub')
        {
            steps{
                script{
                    withCredentials([string(credentialsId: 'docker_password', variable: 'docker_pwd')]) {
                    sh 'docker login -u bhavi061999019 -p ${docker_pwd}'
                    }
                    sh 'docker tag bhavi/brickbreaker bhavi061999019/brickbreaker'
                    sh 'docker push bhavi061999019/brickbreaker'
                }
            }
        }
        stage('Deploy to Kubernetes cluster')
        {
            steps{
                script{
                    sh 'sudo kubectl --kubeconfig=/home/bhavitha/config get pods'
                   sh 'sudo kubectl --kubeconfig=/home/bhavitha/config create -f Deployment.yml' 
                }
            }
        }
    }
}
