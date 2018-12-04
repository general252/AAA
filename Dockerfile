# Version: 0.0.1

FROM centos:7

MAINTAINER MNicholas "475807132@qq.com"

RUN echo root:"123456" | chpasswd \
    && yum install -y openssh-server \
    && ssh-keygen -q -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key -N '' \
    && ssh-keygen -q -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N '' \
    && ssh-keygen -t dsa -f /etc/ssh/ssh_host_ed25519_key -N '' \
    /usr/sbin/sshd -D
