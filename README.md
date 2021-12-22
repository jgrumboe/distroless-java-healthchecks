# Java Distroless and container Healthchecks

## Intro

This repo is a minimal implementation which includes a mini webserver implemented in Java, running on distroless-java base image and including a container healthcheck.

The interesting aspect with distroless-java base image is that it can only run JAR files. With Java11 it's also possible to run `.java` files directly without compiling and that's what is used here for the health check.

## Get started

The following commands will compile the mini webserver, bundle it into a JAR file and build the container

```shell
javac TheComSunNetHttpServer.java
jar -c -e TheComSunNetHttpServer -v -f TheComSunNetHttpServer.jar TheComSunNetHttpServer.class 
docker build . -t mini-webserver
```

Start the container in the background, it will listen on port 8080 and print "Hello, World!" on requests.

```shell
docker run -d -p 8080:8080 mini-webserver
sleep 2
curl http://localhost:8080
```

You can check and see that it gets healthy

```
❯ docker ps                      
CONTAINER ID   IMAGE     COMMAND                  CREATED          STATUS                    PORTS                    NAMES
009a72a63438   test      "/usr/bin/java -jar …"   52 seconds ago   Up 51 seconds (healthy)   0.0.0.0:8080->8080/tcp   friendly_cannon
```

## Clean up

```shell
container_id=$(docker ps | grep mini-webserver | awk '{print $1}')
docker stop $container_id
docker rm $container_id
docker rmi mini-webserver
```

## Credits

- Mini webserver: https://syntaxcorrect.com/Java/5_Ultra_Lightweight_Http_Server_Implementations_in_Java_for_Blazing_Fast_Microservices_APIs_or_Even_Websites
- Health check: https://mflash.dev/blog/2021/03/01/java-based-health-check-for-docker/
