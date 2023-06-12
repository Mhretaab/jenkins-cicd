pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'mberhe/jenkins_cicd'
        KUBECONFIG_CREDENTIALS = 'mykube-config'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Maven build') {
            steps {
                sh './mvnw clean package'
            }
        }

        stage('Test') {
            steps {
                sh './mvnw test'
            }
        }

        stage('Build Docker Image') {
            steps{
                script {
                    echo "build number: ${env.BUILD_NUMBER}"
                    docker.build("${DOCKER_IMAGE}:${env.BUILD_NUMBER}")
                }
            }
        }

        stage('Push Docker Image') {
            steps{
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker-hub') {
                        docker.image("${DOCKER_IMAGE}:${env.BUILD_NUMBER}").push('latest')
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    //kubernetesDeploy(configs: "myweb.yaml", kubeconfigId: "mykube-config")

                    withKubeConfig([credentialsId: KUBECONFIG_CREDENTIALS]) {
                        sh "kubectl apply -f myweb.yaml"
                    }
                }
            }
        }
    }
}
