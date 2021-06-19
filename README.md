# A Django REST api with Swift Frontend

## Deploy to Ubuntu 18.04
### 1 - setup
设置新host和user
`apt-get update && apt-get upgrade` 更新系统  

`hostnamectl set-hostname django-server` 设置hostname, 输入 `hostname` 检测

`nano /etc/hosts`   添加 103.79.76.243     django-server

`adduser faradawn` 密码，其他回车

 `adduser faradawn sudo` 赋予sudo权利

`exit` 退出root

重新链接

use ssh keybased authentication,
`mkdir -p ~/.ssh` 检测用 ls -la

copy ssh key to web, at local 

`ssh-keygen -b 4096` 这样login without password

`scp ~/.ssh/id_rsa.pub faradawn@103.79.76.243:~/.ssh/authorized_keys` 复制到server check by `ls .ssh`

设置权限

`sudo chmod 700 ~/.ssh/`

`sudo chmod 600 ~/.ssh/*`

取消其他人

`sudo nano /etc/ssh/sshd_config` 设置 PermitRootLogin no 和 #PasswordAuthentications no

`sudo systemctl restart sshd` 重启

防火墙
```
sudo apt-get install ufw
sudo ufw default allow outgoing
sudo ufw default deny incoming
sudo ufw allow ssh
sudo ufw allow 8000
sudo ufw enable
sudo ufw status
// 之后再allow http
```




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

