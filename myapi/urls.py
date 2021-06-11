from django.urls import path, include
from rest_framework import routers

from . import views

myrouter = routers.DefaultRouter()
myrouter.register(r'users', views.UserViewSet)

urlpatterns = [
    path('', include(myrouter.urls)),
    path('api-auth/', include('rest_framework.urls', namespace='rest_framework'))
]