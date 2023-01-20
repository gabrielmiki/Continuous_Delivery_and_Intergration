FROM jenkins/jenkins:alpine
MAINTAINER Gabriel Miki <gabrielmiki@gmail>

USER root

COPY --chown=jenkins:jenkins plugins.txt /usr/share/jenkins/ref/plugins.txt

RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt

EXPOSE 8080
