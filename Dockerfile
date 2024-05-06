FROM public.ecr.aws/docker/library/amazonlinux:2
RUN mkdir -p /app/
RUN mkdir -p /opt/

COPY build/libs/SpringECSExample-0.0.1-SNAPSHOT.jar /app/SpringECSExample.jar
RUN yum upgrade -y
RUN yum install -y wget

#confd installation
RUN yum install python3-setuptools.noarch python3-pip.noarch python3.x86_64 python3-pip.noarch -y
RUN curl -O https://bootstrap.pypa.io/pip/3.6/get-pip.py
RUN python3 get-pip.py --user
RUN pip-3 install supervisor
RUN mkdir -p /var/log/supervisor
RUN mkdir -p /etc/supervisor/conf.d/

ADD supervisord.conf /etc/supervisor/supervisord.conf

EXPOSE 8080

#java corretto 17- installation
RUN wget https://s3.amazonaws.com/pearson-devops-public/java-17-amazon-corretto-devel-17.0.5.8-1.x86_64.rpm && \
    BASE_DIR="/usr/local/share/" && \
    rpm -Uvh java-17-amazon-corretto-devel-17.0.5.8-1.x86_64.rpm && \
    mkdir -p $BASE_DIR && \
    rm -rf java-17-amazon-corretto-devel-17.0.5.8-1.x86_64.rpm


#CrowdStrike Falcon Sensor
ADD ./devops/falcon-sensor-*.amzn2.x86_64.rpm /opt/falcon-sensor.amzn2.x86_64.rpm
RUN yum install /opt/falcon-sensor.amzn2.x86_64.rpm -y

CMD supervisord
#ENTRYPOINT ["java","-jar","/app/SpringECSExample.jar"]

