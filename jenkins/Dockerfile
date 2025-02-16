FROM jenkins/jenkins:lts

USER root

# Install prerequisites
RUN apt-get update && \
    apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    software-properties-common

# Install Docker using the convenience script
RUN curl -fsSL https://get.docker.com -o get-docker.sh && \
    sh get-docker.sh

# Install Python and pip
RUN apt-get install -y python3 python3-pip

# Install Docker Compose
RUN curl -L "https://github.com/docker/compose/releases/download/v2.23.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose

# Create required directories and set permissions
RUN mkdir -p /var/jenkins_home/logs && \
    chown -R jenkins:jenkins /var/jenkins_home && \
    chmod -R 755 /var/jenkins_home

# Add Jenkins user to Docker group
RUN usermod -aG docker jenkins

USER jenkins

# Install Jenkins plugins
RUN jenkins-plugin-cli --plugins \
    blueocean \
    docker-workflow \
    docker-commons \
    docker-plugin \
    git \
    git-server \
    pipeline-stage-view \
    python \
    ssh-slaves \
    sshd \
    workflow-aggregator
