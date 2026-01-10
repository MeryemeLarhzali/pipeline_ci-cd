pipeline {
    agent any

    tools {
        maven 'MavenDefault'  // Configuré dans Jenkins → Global Tool Configuration
        jdk 'JavaDefault'     // Configuré dans Jenkins → Global Tool Configuration
    }

    stages {
        stage('Clean Workspace') {
            steps {
                echo 'Nettoyage du workspace...'
                deleteDir()
            }
        }

        stage('Checkout') {
            steps {
                echo 'Récupération du code depuis Git...'
                git branch: 'main', url: 'https://github.com/MeryemeLarhzali/CI-CD_Project.git'
            }
        }

        stage('Build') {
            steps {
                echo 'Compilation du projet...'
                sh 'mvn clean compile'
            }
        }

        stage('Test') {
            steps {
                echo 'Exécution des tests...'
                sh 'mvn test'
            }
        }

        stage('Package') {
            steps {
                echo 'Packaging du projet...'
                sh 'mvn package'
            }
        }

        stage('Archive Artifacts') {
            steps {
                echo 'Archivage du JAR...'
                archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
            }
        }

        stage('Docker Build & Run') {
            steps {
                echo 'Build et lancement Docker...'
                sh '''
                    # Construire l'image Docker
                    docker build -t gestion-produits:latest .

                    # Stopper et supprimer l'ancien conteneur s'il existe
                    docker stop gestion-produits || true
                    docker rm gestion-produits || true

                    # Lancer le conteneur
                    docker run -d -p 8081:8085 --name gestion-produits gestion-produits:latest
                '''
            }
        }
    }

    post {
        success {
            echo 'Build, tests et déploiement Docker réussis !'
        }
        failure {
            echo 'Échec du build, des tests ou du déploiement Docker.'
        }
    }
}
