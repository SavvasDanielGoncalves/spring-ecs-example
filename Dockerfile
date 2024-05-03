FROM public.ecr.aws/docker/library/amazonlinux:2
RUN mkdir -p /app/
COPY build/libs/SpringECSExample-0.0.1-SNAPSHOT.jar /app/SpringECSExample.jar
RUN yum upgrade -y
RUN yum install -y wget

EXPOSE 8080

#java corretto 17- installation
RUN wget https://s3.amazonaws.com/pearson-devops-public/java-17-amazon-corretto-devel-17.0.5.8-1.x86_64.rpm && \
    BASE_DIR="/usr/local/share/" && \
    rpm -Uvh java-17-amazon-corretto-devel-17.0.5.8-1.x86_64.rpm && \
    mkdir -p $BASE_DIR && \
    rm -rf java-17-amazon-corretto-devel-17.0.5.8-1.x86_64.rpm

ENTRYPOINT ["java","-jar","/app/SpringECSExample.jar"]

