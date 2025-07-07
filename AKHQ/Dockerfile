# Utiliser l'image officielle d'AKHQ comme base
FROM tchiotludo/akhq:latest

WORKDIR /app

COPY ./application.yml /app/application.yml

EXPOSE 8080

CMD ["java", "-jar", "/app/akhq.jar"]