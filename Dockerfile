# version: 0.0.1

FROM centos:7

MAINTAINER MNicholas "auth@163.com"

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
    && pip install asn1crypto==0.24.0 \
    && pip install cffi==1.11.5 \
    && pip install cryptography==2.4.2 \
    && pip install idna==2.8 \
    && pip install PyMySQL==0.9.2 \
    && pip install pytz==2018.7 \
    && pip install redis==2.10.6 \
    && pip install six==1.11.0 \
    && pip install django-redis==4.9.0 \
    && pip install uWSGI==2.0.17.1 \
    && pip install pyzmq==18.0.1 \
    && yum clean all \
    && rm -rf /var/cache/yum \
    && rm -rf ~/.cache/pip/*

# RUN pip install virtualenv
# RUN virtualenv -p /usr/bin/python36 /home/env
# RUN source /home/env/bin/activate \

# datetime, encode
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo 'Asia/Shanghai' > /etc/timezone \
    && echo export LC_ALL=en_US.UTF-8 >> /etc/profile \
    && source /etc/profile \
    && locale \
    && echo "now time is : $(date +%Y-%m-%d\ %H:%M:%S)"

RUN cd /home \
    && django-admin startproject project_name \
    && cd project_name \
    && python36 manage.py startapp app_name

WORKDIR /home

EXPOSE 22 8000

CMD ["/usr/sbin/sshd", "-D"]
