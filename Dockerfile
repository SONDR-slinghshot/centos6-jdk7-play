FROM centos:6.10

# Fix CentOS 6 repository
RUN sed -i '/^mirrorlist/s/^/#/;/^#baseurl/{s/#//;s/mirror.centos.org\/centos\/$releasever/vault.centos.org\/6.10/}' /etc/yum.repos.d/*B* && \
    yum update -y && \
    yum install -y \
        java-1.7.0-openjdk-devel \
        curl \
        git \
        tar \
        unzip \
        wget

ADD ./errorMailer.zip /srv/

RUN cd /srv/ && \
    wget https://downloads.typesafe.com/play/1.2.7/play-1.2.7.zip && \
    unzip play-1.2.7.zip && \
    cd /srv/play-1.2.7/modules && \
    unzip /srv/errorMailer.zip

ENV PLAY_PATH=/srv/play-1.2.7
ENV JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk.x86_64
ENV PATH=$PATH:$PLAY_PATH

CMD /bin/bash
