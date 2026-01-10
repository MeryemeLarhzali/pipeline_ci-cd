pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/MeryemeLarhzali/CI-CD_Project.git', branch: 'main'
            }
        }

        stage('Docker Build & Run') {
            steps {
                echo "Build et lancement Docker..."
                sh '''
                    # Stopper et supprimer l'ancien conteneur s'il existe
                    docker stop gestion-produits || true
                    docker rm gestion-produits || true

                    # Construire l'image Docker (Maven inclus via Dockerfile multi-stage)
                    docker build -t gestion-produits:latest .

                    # Lancer le conteneur avec mapping de port correct
                    docker run -d -p 8081:8085 --name gestion-produits gestion-produits:latest

                    # Vérifier les conteneurs en cours
                    docker ps
                '''
            }
        }
    }

    post {
        success {
            echo 'Pipeline terminée : application accessible sur http://localhost:8081'
        }
        failure {
            echo 'Échec du build ou du déploiement Docker.'
        }
    }
}
