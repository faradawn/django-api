from django.shortcuts import render
from rest_framework import viewsets
from django.http import HttpResponse, Http404

from .serializer import UserSerializer
from .models import User

# Create your views here.

def hey(request):
    return HttpResponse('heeyyy')

def nope(request):
    return Http404('error 404 wooo')

class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all().order_by('username')
    serializer_class = UserSerializer

