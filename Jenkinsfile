pipeline {
    agent any

    tools {
        maven 'MavenDefault'  // Nom du Maven configuré dans Jenkins → Global Tool Configuration
        jdk 'JavaDefault'     // Nom du JDK configuré dans Jenkins → Global Tool Configuration
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
                echo 'Clonage du dépôt Git...'
                git branch: 'main', url: 'https://github.com/MeryemeLarhzali/CI-CD_Project.git'
            }
        }

        stage('Build') {
            steps {
                echo 'Compilation du projet Maven...'
                sh 'mvn clean compile'
            }
        }

        stage('Test') {
            steps {
                echo 'Exécution des tests Maven...'
                sh 'mvn test'
            }
        }

        stage('Package') {
            steps {
                echo 'Création du JAR...'
                sh 'mvn package'
            }
        }

        stage('Archive Artifacts') {
            steps {
                echo 'Archivage du fichier JAR...'
                archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
            }
        }

        stage('Docker Build & Run') {
            steps {
                echo 'Construction et lancement du conteneur Docker...'
                sh '''
                    # Construire l'image Docker
                    docker build -t gestion-produits:latest .

                    # Stopper et supprimer l'ancien conteneur s'il existe
                    docker stop gestion-produits || true
                    docker rm gestion-produits || true

                    # Lancer le conteneur avec mapping du port 8085 → 8081
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
