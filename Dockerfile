# Version: 0.0.1

FROM centos:7

MAINTAINER MNicholas "475807132@qq.com"

RUN echo root:"123456" | chpasswd
    RUN yum install -y openssh-server 
    RUN ssh-keygen -q -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key -N '' 
    RUN ssh-keygen -q -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N '' 
    RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_ed25519_key -N '' 
    RUN /usr/sbin/sshd -D
