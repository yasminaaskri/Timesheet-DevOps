pipeline {
    agent any

    tools {
        jdk 'JAVA_HOME'
        maven 'M2_HOME'
    }

    environment {
        IMAGE_NAME     = 'timesheet-devops'
        IMAGE_TAG      = '1.0'
        DOCKERHUB_USER = 'yasminaaa7'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/yasminaaskri/Timesheet-DevOps.git'
            }
        }

        stage('Compile') {
            steps {
                sh 'mvn compile'
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Package') {
            steps {
                sh 'mvn package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                    docker rmi -f $IMAGE_NAME:$IMAGE_TAG || true
                    docker build -t $IMAGE_NAME:$IMAGE_TAG .
                '''
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                        echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                        docker tag $IMAGE_NAME:$IMAGE_TAG $DOCKERHUB_USER/$IMAGE_NAME:$IMAGE_TAG
                        docker push $DOCKERHUB_USER/$IMAGE_NAME:$IMAGE_TAG
                    '''
                }
            }
        }
    }
}
