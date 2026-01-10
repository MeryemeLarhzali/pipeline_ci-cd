pipeline {
    agent any

    tools {
        maven 'MavenDefault'  // doit être configuré dans Jenkins → Global Tool Configuration
        jdk 'JavaDefault'     // doit être configuré dans Jenkins → Global Tool Configuration
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/MeryemeLarhzali/CI-CD_Project.git', branch: 'main'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean compile'
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Package') {
            steps {
                sh 'mvn package'
            }
        }

        stage('Archive') {
            steps {
                archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
            }
        }
    }

    post {
        success { echo 'Build et tests réussis !' }
        failure { echo 'Le build ou les tests ont échoué.' }
    }
}
