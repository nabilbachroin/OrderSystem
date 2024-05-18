from rest_framework import serializers
from .models import MenuBakso, MinumanPojokJoyo, OrderList

class MenuBaksoSerializer(serializers.ModelSerializer):
    class Meta:
        model = MenuBakso
        fields = '__all__'

class MinumanPojokJoyoSerializer(serializers.ModelSerializer):
    class Meta:
        model = MinumanPojokJoyo
        fields = '__all__'

class OrderListSerializer(serializers.ModelSerializer):
    class Meta:
        model = OrderList
        fields = '__all__'
