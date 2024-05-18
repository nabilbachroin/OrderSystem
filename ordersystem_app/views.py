from django.shortcuts import render

# Create your views here.
from rest_framework import viewsets
from .models import MenuBakso, MinumanPojokJoyo, OrderList
from .serializers import MenuBaksoSerializer, MinumanPojokJoyoSerializer, OrderListSerializer

class MenuBaksoViewSet(viewsets.ModelViewSet):
    queryset = MenuBakso.objects.all()
    serializer_class = MenuBaksoSerializer

class MinumanPojokJoyoViewSet(viewsets.ModelViewSet):
    queryset = MinumanPojokJoyo.objects.all()
    serializer_class = MinumanPojokJoyoSerializer

class OrderListViewSet(viewsets.ModelViewSet):
    queryset = OrderList.objects.all()
    serializer_class = OrderListSerializer
