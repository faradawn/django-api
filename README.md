# A Django REST api with Swift Frontend

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

