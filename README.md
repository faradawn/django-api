# A Django REST api with Swift Frontend

## How to Deploy to Ubuntu 18.04 Server [2021.6.20]

### 1 - 设置服务器
设置新host和user
```
// 更新Ubuntu
apt-get update && apt-get upgrade 

// 设置 hostname
hostnamectl set-hostname django-server
hostname 

// 在 `nano /etc/hosts` 添加 （中间用tab）
103.79.76.243     django-server 

// 新建服务器用户并赋予sudo
adduser faradawn
adduser faradawn sudo
exit
```

重新连接服务器
```
// 新建
mkdir -p ~/.ssh 

// 苹果电脑
ssh-keygen -b 4096
scp ~/.ssh/id_rsa.pub faradawn@103.000.0.0:~/.ssh/authorized_keys
```

设置权限
```
sudo chmod 700 ~/.ssh/
sudo chmod 600 ~/.ssh/*
sudo nano /etc/ssh/sshd_config (设置 PermitRootLogin no 和 #PasswordAuthentications no，未做)
sudo systemctl restart sshd
```

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


### 2 - 上传Django项目
拷贝到服务器
```
scp -r django-api faradawn@103.79.76.243:~/
sudo apt-get install python3-pip
sudo apt-get install python3-venv
```

配置虚拟环境
```
python3 -m venv django-api/django-env
source django-env/bin/activate
pip install -r requirements.txt
// 出问题见下文
```

设置django static
```
// 在 settings.py
ALLOWED_HOSTS = ['103.79.76.243']

// static 在MEIDA root 之上
STATIC_ROOT = os.path.join(DASE_DIR, 'static')

// 输入
// python manage.py collectstatic
```

安装Postgres
```
// 下载
sudo apt install postgresql postgresql-contrib

// 新建数据库
sudo -u postgres psql
postgres=# create database myapi_db;
postgres=# create user faradawn with encrypted password 'xxx';
postgres=# grant all privileges on database myapi_db to faradawn;
postgres=# ALTER DATABASE myapi_db OWNER TO faradawn;

// 倒入数据
psql -U faradawn letter_db < letter.db

// 开启服务器
source django-api/django-env/bin/activate
python manage.py runserver 0.0.0.0:8000
```

### 3 - 安装Apache
下载 apache2
```
// 下载apache
sudo apt-get install apache2
sudo apt-get install libapache2-mod-wsgi-py3
cd /etc/apache2/sites-available
sudo cp 000-default.conf django-api.conf
sudo nano django-api.conf
```
在 django-api.conf 里黏贴
```
Alias /static /home/faradawn/django-api/static
<Directory /home/faradawn/django-api/static>
    Require all granted
</Directory>

Alias /media /home/faradawn/django-api/media
<Directory /home/faradawn/django-api/media>
    Require all granted
</Directory>

<Directory /home/faradawn/django-api/mysite>
    <Files wsgi.py>
        Require all granted
    </Files>
</Directory>

WSGIScriptAlias / /home/faradawn/django-api/mysite/wsgi.py

WSGIDaemonProcess django-process python-path=/home/faradawn/django-api python-home=/home/faradawn/django-api/django-env/

WSGIProcessGroup django-process

WSGIPassAuthorization On
```

回到home
```
// 启动配置文件
sudo a2ensite django-api 
sudo a2dissite 000-default.conf

// 给予Apache文件权限
sudo chown -R :www-data /etc/postgresql/10/main (equivalent to db.sqlite)
sudo chmod 664 /etc/postgresql/10/main
sudo chown :www-data django-api/

sudo chown -R :www-data django-api/media (未做)
sudo chmod -R 775 django-api/media (未做)
```

配置SECRET_KEY
```
// 在 Home
sudo touch /etc/api-config.json
sudo vi settings
sudo nano /etc/api-config.json

{
        "SECRET_KEY": "django-insecure-rkjkqxbxxxx"
}

// 在项目 settings.py
import json
with open('/etc/api-config.json') as config_file:
    config = json.load(config_file)

SECRET_KEY = config['SECRET_KEY']
DEBUG = False
```

最后让防火墙允许http
```
sudo ufw delete allow 8000
sudo ufw allow http/tcp
sudo service apache2 restart
```


## How to Deploy to a CentOS server (宝塔面板)
### 1 - 安装 python 和 postgres 管理器
python 3.8.5, 新建项目
postgres 11

### 2 - 新建站点
pip3 freeze > requirements.txt
zip项目上传到 /wwwroot

### 3 - 配置 uwsgi.ini
新建uswgi.ini

### # - 问题集合
- [x] 宝塔
```
cd /www/wwwroot/faradcloud.live; source ./django-api_venv/bin/activate; python manage.py runserver
pip install django
pip install djangorestframework
// 出问题
sudo apt install python3-dev libpq-dev
pip3 install psycopg2

```
- [x] 尝试 runserver 如果 port 8000 already in use (只是宝塔问题)
- [x] 无法写入数据库 (`sudo chmod 775 django-api/`)
- [x] Django: no credential found (添加 `sudo nano /etc/apache2/sites-avaible/django-api.conf` ，然后重启 `sudo service apache2 restart`

