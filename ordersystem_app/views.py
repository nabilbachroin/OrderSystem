from django.shortcuts import render

# Create your views here.
from rest_framework import viewsets, status
from rest_framework.response import Response
from .models import MenuBakso, MinumanPojokJoyo, OrderList, PorsiDetail
from .serializers import MenuBaksoSerializer, MinumanPojokJoyoSerializer, OrderListSerializer, PorsiDetailSerializer

from rest_framework.decorators import api_view
from django.contrib.auth.decorators import login_required

@api_view(['GET'])
@login_required
def get_user_role(request):
    return Response({'role': request.user.role})

class MenuBaksoViewSet(viewsets.ModelViewSet):
    queryset = MenuBakso.objects.all()
    serializer_class = MenuBaksoSerializer

class MinumanPojokJoyoViewSet(viewsets.ModelViewSet):
    queryset = MinumanPojokJoyo.objects.all()
    serializer_class = MinumanPojokJoyoSerializer

class OrderListViewSet(viewsets.ModelViewSet):
    queryset = OrderList.objects.all()
    serializer_class = OrderListSerializer

    def create(self, request, *args, **kwargs):
        ip_address = request.META.get('REMOTE_ADDR')
        existing_order = OrderList.objects.filter(ip_address=ip_address, status__in=['Sedang Diproses', 'Diantar Ke Meja']).first()
        if existing_order:
            return Response({"detail": "You already have an ongoing order."}, status=status.HTTP_400_BAD_REQUEST)
        serializer = self.get_serializer(data=request.data)
        if serializer.is_valid():
            self.perform_create(serializer, ip_address)
            headers = self.get_success_headers(serializer.data)
            return Response(serializer.data, status=status.HTTP_201_CREATED, headers=headers)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def perform_create(self, serializer, ip_address):
        serializer.save(ip_address=ip_address)