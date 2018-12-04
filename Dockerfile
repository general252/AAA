# version: 0.0.1

FROM centos:7

MAINTAINER MNicholas "475807132@qq.com"

# ADD nginx-1.12.2.tar.gz /usr/local/src


RUN cd /home \
    && echo root:"123456" | chpasswd \
    && yum install -y openssh-server \
    && ssh-keygen -q -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key -N '' \
    && ssh-keygen -q -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N '' \
    && ssh-keygen -t dsa -f /etc/ssh/ssh_host_ed25519_key -N '' \
    && yum install -y wget \
    && yum install -y gcc \
    && yum install -y mysql-devel \
    && yum install -y epel-release \
    && yum install -y python36 \
    && yum install -y python36-devel \
    && wget --no-check-certificate https://pypi.python.org/packages/source/s/setuptools/setuptools-19.6.tar.gz#md5=c607dd118eae682c44ed146367a17e26 \
    && tar -zxvf setuptools-19.6.tar.gz \
    && cd setuptools-19.6 \
    && python36 setup.py build \
    && python36 setup.py install \
    && cd .. \
    && rm -f setuptools-19.6.tar.gz \
    && rm -rf setuptools-19.6 \
    && wget --no-check-certificate https://pypi.python.org/packages/source/p/pip/pip-8.0.2.tar.gz#md5=3a73c4188f8dbad6a1e6f6d44d117eeb \
    && tar -zxvf pip-8.0.2.tar.gz \
    && cd pip-8.0.2 \
    && python36 setup.py build \
    && python36 setup.py install \
    && pip3 install --upgrade pip \
    && cd .. \
    && rm -f pip-8.0.2.tar.gz \
    && rm -rf pip-8.0.2 \
    && yum clean all \
    && rm -rf /var/cache/yum \
    && rm -rf ~/.cache/pip/*

RUN pip install Django==2.0.5 \
    && yum clean all \
    && rm -rf /var/cache/yum \
    && rm -rf ~/.cache/pip/*

# RUN pip3 install virtualenv
# RUN virtualenv -p /usr/bin/python36 /home/env
# RUN source /home/env/bin/activate \

RUN cd /home \
    && django-admin startproject project_name \
    && cd project_name \
    && python36 manage.py startapp app_name

WORKDIR /home

EXPOSE 22
EXPOSE 8000

CMD ["/usr/sbin/sshd", "-D"]
