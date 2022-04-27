FROM openjdk:8
LABEL maintainer="javaguids.net"
ADD target/foodpandatest-0.0.1-SNAPSHOT.war foodpandatest.war
ENTRYPOINT ["java","-jar","foodpandatest.war"]
