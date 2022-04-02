# version: 0.0.1

FROM centos:7

MAINTAINER MNicholas "auth@163.com"

# ADD nginx-1.12.2.tar.gz /usr/local/src

RUN    cd /home \
    && echo root:"123456" | chpasswd \
    && yum install -y openssh-server \
    && ssh-keygen -q -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key -N '' \
    && ssh-keygen -q -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N '' \
    && ssh-keygen -t dsa -f /etc/ssh/ssh_host_ed25519_key -N '' \
    && yum install -y wget \
    && yum install -y gcc \
    && yum install -y mysql-devel \
    && yum install -y epel-release \
    && sed -i '3,4s/#baseurl/baseurl/g'   /etc/yum.repos.d/epel.repo \
    && sed -i '3,4s/metalink/#metalink/g' /etc/yum.repos.d/epel.repo \
    && yum install -y python36 \
    && yum install -y python36-devel \
    && ln -s /usr/bin/python3.6 /usr/bin/python36 \
    && whereis python36 && python36 --version \
    && wget --no-check-certificate https://files.pythonhosted.org/packages/6a/fa/5ec0fa9095c9b72cb1c31a8175c4c6745bf5927d1045d7a70df35d54944f/setuptools-59.6.0.tar.gz \
    && tar -zxf setuptools-59.6.0.tar.gz \
    && cd setuptools-59.6.0 \
    && python36 setup.py build \
    && python36 setup.py install \
    && cd .. \
    && rm -f setuptools-59.6.0.tar.gz \
    && rm -rf setuptools-59.6.0 \
    && wget --no-check-certificate https://files.pythonhosted.org/packages/da/f6/c83229dcc3635cdeb51874184241a9508ada15d8baa337a41093fab58011/pip-21.3.1.tar.gz \
    && tar -zxf pip-21.3.1.tar.gz \
    && cd pip-21.3.1 \
    && python36 setup.py build \
    && python36 setup.py install \
    && pip3 install --upgrade pip \
    && cd .. \
    && rm -f pip-21.3.1.tar.gz \
    && rm -rf pip-21.3.1 \
    && yum clean all \
    && rm -rf /var/cache/yum \
    && rm -rf ~/.cache/pip/*

RUN    pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org --trusted-host mirrors.aliyun.com -i https://mirrors.aliyun.com/pypi/simple/ Django==2.0.5 \
    && pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org --trusted-host mirrors.aliyun.com -i https://mirrors.aliyun.com/pypi/simple/ asn1crypto==0.24.0 \
    && pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org --trusted-host mirrors.aliyun.com -i https://mirrors.aliyun.com/pypi/simple/ cffi==1.11.5 \
    && pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org --trusted-host mirrors.aliyun.com -i https://mirrors.aliyun.com/pypi/simple/ cryptography==2.4.2 \
    && pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org --trusted-host mirrors.aliyun.com -i https://mirrors.aliyun.com/pypi/simple/ idna==2.8 \
    && pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org --trusted-host mirrors.aliyun.com -i https://mirrors.aliyun.com/pypi/simple/ PyMySQL==0.9.2 \
    && pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org --trusted-host mirrors.aliyun.com -i https://mirrors.aliyun.com/pypi/simple/ pytz==2018.7 \
    && pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org --trusted-host mirrors.aliyun.com -i https://mirrors.aliyun.com/pypi/simple/ redis==2.10.6 \
    && pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org --trusted-host mirrors.aliyun.com -i https://mirrors.aliyun.com/pypi/simple/ six==1.11.0 \
    && pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org --trusted-host mirrors.aliyun.com -i https://mirrors.aliyun.com/pypi/simple/ django-redis==4.9.0 \
    && pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org --trusted-host mirrors.aliyun.com -i https://mirrors.aliyun.com/pypi/simple/ uWSGI==2.0.17.1 \
    && pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org --trusted-host mirrors.aliyun.com -i https://mirrors.aliyun.com/pypi/simple/ pyzmq==18.0.1 \
    && pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org --trusted-host mirrors.aliyun.com -i https://mirrors.aliyun.com/pypi/simple/ rsa==4.0 \
    && pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org --trusted-host mirrors.aliyun.com -i https://mirrors.aliyun.com/pypi/simple/ APScheduler==3.6.0 \
    && pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org --trusted-host mirrors.aliyun.com -i https://mirrors.aliyun.com/pypi/simple/ pycryptodome==3.8.1 \
    && pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org --trusted-host mirrors.aliyun.com -i https://mirrors.aliyun.com/pypi/simple/ grpcio==1.45.0 \
    && pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org --trusted-host mirrors.aliyun.com -i https://mirrors.aliyun.com/pypi/simple/ grpcio-tools==1.45.0 \
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
