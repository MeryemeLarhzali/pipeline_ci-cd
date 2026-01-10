pipeline {
    agent any

    tools {
        maven 'Maven-3'
    }

    stages {

        stage('Checkout') {
            steps {
                echo 'Clonage du code'
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

        stage('Deployement') {
            steps {
                echo 'Déploiement avec Docker...'
                sh '''
                # Nouveau nom d'image et de conteneur
                docker build -t gestion_produits_image:latest .
                docker stop gestion_produits_container || true
                docker rm gestion_produits_container || true
                docker run -d -p 8080:8080 --name gestion_produits_container gestion_produits_image:latest
                '''
            }
        }

    }
}
