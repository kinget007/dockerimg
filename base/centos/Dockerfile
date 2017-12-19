FROM centos:7
MAINTAINER king.yu <806833417@qq.com>

# Install packages necessary to run EAP
RUN yum update -y && yum -y install xmlstarlet saxon augeas bsdtar unzip && yum clean all

# Create a user and group used to launch processes
# The user ID 1000 is the default for the first "regular" user on Fedora/RHEL,
# so there is a high chance that this ID will be equal to the current user
# making it easier to use volumes (no permission issues)
RUN groupadd -r run -g 1000 && useradd -u 1000 -r -g run -m -d /opt/run -s /sbin/nologin -c "run user" user && \
    chmod 755 /opt/run

# Set the working directory to run' user home directory
WORKDIR /opt/run

# Specify the user which should be used to execute all commands below
USER user
