FROM ubuntu:16.04

MAINTAINER king.yu <806833417@qq.com>

ENV DEBIAN_FRONTEND=noninteractive

#=============
# Set WORKDIR
#=============
WORKDIR /root

#==================
# General Packages
#------------------
# openjdk-8-jdk
#   Java
# ca-certificates
#   SSL client
# tzdata
#   Timezone
# zip
#   Make a zip file
# unzip
#   Unzip zip file
# curl
#   Transfer data from or to a server
# wget
#   Network downloader
# libqt5webkit5
#   Web content engine (Fix issue in Android)
# libgconf-2-4
#   Required package for chrome and chromedriver to run on Linux
# xvfb
#   X virtual framebuffer
#==================
RUN apt-get -qqy update && \
    apt-get -qqy --no-install-recommends install \
    openjdk-8-jdk \
    xvfb \
  && rm -rf /var/lib/apt/lists/*

#===============
# Set JAVA_HOME
#===============
ENV JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64/jre" \
    PATH=$PATH:$JAVA_HOME/bin

#==================================
# Set timezone
#==================================
ENV TZ="Asia/Shanghai"
RUN echo "${TZ}" > /etc/timezone

#===============
# Expose Ports
#---------------
# 4444 selenium port
#===============
EXPOSE 4444

#====================================================
# Jar Selenium Grid And Scripts to run selenium Grid
#====================================================

COPY entry_point.sh /root/
COPY selenium-server-standalone-3.7.1.jar /root/

RUN chmod +x /root/entry_point.sh
RUN chmod +x /root/selenium-server-standalone-3.7.1.jar

#========================================
# Run xvfb and appium server
#========================================
CMD /root/entry_point.sh
