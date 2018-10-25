
### ssh
```
cd /root
yum install -y openssh-server

ssh-keygen -q -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key -N ''
ssh-keygen -q -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N ''
ssh-keygen -t dsa -f /etc/ssh/ssh_host_ed25519_key -N ''

/usr/sbin/sshd -D
echo root:"123456" | chpasswd
```

### wget
```
yum install -y wget
```


### openssl
```
wget https://raw.githubusercontent.com/general252/AAA/master/openssl1.1.0g.tar.gz
tar zxf openssl1.1.0g.tar.gz
mv my_openssl /usr/local/openssl
rm -f openssl1.1.0g.tar.gz

echo "/usr/local/openssl/lib" >> /etc/ld.so.conf.d/openssl.conf
ldconfig

```

在etc/profile的最后一行，添加：
```
echo "export OPENSSL=/usr/local/openssl/bin" >> /etc/profile
echo "export PATH=\$OPENSSL:\$PATH" >> /etc/profile

```


### 安装基础库(uwsgi需要gcc, python36-devel), mysqlclient需要mysql-devel
```
yum install -y gcc
yum install -y mysql-devel
```


### python3.6.6
```
yum install -y epel-release
yum install -y python36
yum install -y python36-devel

```


### 安装pip2(supervisor仅支持python2, 需要pip2安装)
```
wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py
```

### 安装supervisor
```
pip2 install supervisor
```


### 安装pip3
```
wget --no-check-certificate  https://pypi.python.org/packages/source/s/setuptools/setuptools-19.6.tar.gz#md5=c607dd118eae682c44ed146367a17e26

tar -zxvf setuptools-19.6.tar.gz
cd setuptools-19.6

python36 setup.py build
python36 setup.py install


wget --no-check-certificate  https://pypi.python.org/packages/source/p/pip/pip-8.0.2.tar.gz#md5=3a73c4188f8dbad6a1e6f6d44d117eeb

tar -zxvf pip-8.0.2.tar.gz
cd pip-8.0.2

python36 setup.py build
python36 setup.py install

pip3 install --upgrade pip
```

### 安装virtualenv
···
pip3 install virtualenv

···

### 配置工程虚拟环境
```
cd /root
virtualenv -p /usr/bin/python36 env

source /root/env/bin/activate

wget https://raw.githubusercontent.com/general252/AAA/master/bvr_openssl-0.5-cp36-cp36m-linux_x86_64.whl
pip3 install bvr_openssl-0.5-cp36-cp36m-linux_x86_64.whl

wget https://raw.githubusercontent.com/general252/AAA/master/requirements.txt
pip3 install -r requirements.txt

pip3 install uwsgi

yum clean all

rm -rf ~/.cache/pip/*
```


