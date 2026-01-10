# Utiliser une image Java
FROM eclipse-temurin:21-jdk

# Ajouter le jar packagé
COPY target/tp_spring_boot-0.0.1-SNAPSHOT.jar app.jar

# Exposer le port 8080
EXPOSE 8080

# Lancer l’application
ENTRYPOINT ["java", "-jar", "app.jar"]
