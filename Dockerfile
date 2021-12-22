FROM gcr.io/distroless/java
WORKDIR /app
COPY TheComSunNetHttpServer.jar .
COPY HealthCheck.java .

CMD ["TheComSunNetHttpServer.jar","8080"]
EXPOSE 8080
USER nonroot
HEALTHCHECK --start-period=5s --interval=2s --timeout=3s --retries=2 CMD ["java", "HealthCheck.java"]
