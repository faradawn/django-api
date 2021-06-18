# A Django REST api with Swift Frontend

## Deploy to Ubuntu 20.04
### 1 - setup
`apt update`
`hostnamectl set-hostname django-server` check by hostname
`nano /etc/hosts`   添加103.79.76.243     django-server
`adduser faradawn` 密码，其他回车
`adduser faradawn sudo` 赋予sudo权利
`exit` 退出root
重新ssh faradawn@103.79.76.243
use ssh keybased authentication,
`mkdir -p ~/.ssh` check by ls la
copy ssh key to web, at local 
`ssh-keygen -b 4096` 这样login without password
`scp ~/.ssh/id_rsa.pub faradawn@103:~/.ssh/authorized_keys` 复制到server check by `ls .ssh`

设置权限
`sudo chmod 700 ~/.ssh/`
`sudo chmod 600 ~/.ssh/*`

取消其他人
`sudo nano /etc/ssh/sshd_config`
`sudo 


## Deploy to a CentOS server (宝塔面板)
### 1 - 安装 python 和 postgres 管理器
python 3.8.5, 新建项目
postgres 11

### 2 - 新建站点
pip3 freeze > requirements.txt
zip项目上传到 /wwwroot

### 3 - 配置 uwsgi.ini
新建uswgi.ini

### 4 - 若Internal Excess Error
开启virtualenv
```
cd /www/wwwroot/faradcloud.live; source ./django-api_venv/bin/activate; python manage.py runserver
pip install django
pip install djangorestframework
pip install psycopg2-binary

```
尝试 runserver 如果 port 8000 already in use
```
//
```

### 5 - 


## Django Questions
- [ ] What is model __str__(self)
- [ ] 

