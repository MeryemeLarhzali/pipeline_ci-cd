pipeline {
    agent any

    environment {
        APP_NAME = "tp_spring_boot_app"
        IMAGE_NAME = "${APP_NAME}:latest"
        APP_PORT = "8080"
        HOST_PORT = "8081"
    }

    stages {

        stage('Checkout') {
            steps {
                echo 'Clonage du code depuis GitHub'
                git 'https://github.com/MeryemeLarhzali/pipeline_ci-cd.git'
            }
        }

        stage('Build & Package') {
            steps {
                echo 'Compilation et package Maven'
                script {
                    docker.image('maven:3.9.9-eclipse-temurin-21').inside {
                        sh 'mvn clean package -DskipTests=false'
                    }
                }
            }
        }

        stage('Run Tests') {
            steps {
                echo 'Exécution des tests unitaires'
                script {
                    docker.image('maven:3.9.9-eclipse-temurin-21').inside {
                        sh 'mvn test'
                    }
                }
            }
        }

        stage('Docker Build') {
            steps {
                echo 'Construction de l’image Docker de l’application'
                script {
                    docker.build("${IMAGE_NAME}", ".")
                }
            }
        }

        stage('Docker Run') {
            steps {
                echo "Déploiement de l'application sur le port ${HOST_PORT}"
                script {
                    // Supprimer le conteneur précédent s'il existe
                    sh """
                        docker rm -f ${APP_NAME} || true
                        docker run -d --name ${APP_NAME} -p ${HOST_PORT}:${APP_PORT} ${IMAGE_NAME}
                    """
                }
            }
        }
    }

    post {
        success {
            echo "Pipeline terminé avec succès ! L'application tourne sur le port ${HOST_PORT}"
        }
        failure {
            echo "La pipeline a échoué. Vérifier les logs."
        }
    }
}
