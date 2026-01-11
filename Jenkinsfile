pipeline {
    agent any

    tools {
        maven 'Maven-3'
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/MeryemeLarhzali/pipeline_ci-cd.git'
            }
        }


        stage('Build') {
            steps {
                sh 'mvn clean compile'
            }
        }

        stage('Tests') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Package') {
            steps {
                sh 'mvn package'
            }
        }
    }
}
