from django.urls import path, include
from rest_framework import routers

from . import views

myrouter = routers.DefaultRouter()
myrouter.register(r'users', views.UserViewSet)

urlpatterns = [
    path('hey/', views.hey, name='hello'),
    path('', include(myrouter.urls)),
    path('api-auth/', include('rest_framework.urls', namespace='rest_framework'))
]