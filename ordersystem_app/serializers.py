from rest_framework import serializers
from .models import MenuBakso, MinumanPojokJoyo, OrderList, PorsiDetail

class MenuBaksoSerializer(serializers.ModelSerializer):
    class Meta:
        model = MenuBakso
        fields = '__all__'

class MinumanPojokJoyoSerializer(serializers.ModelSerializer):
    class Meta:
        model = MinumanPojokJoyo
        fields = '__all__'

class PorsiDetailSerializer(serializers.ModelSerializer):
    details = serializers.JSONField()

    class Meta:
        model = PorsiDetail
        fields = ['nama', 'kuah', 'details', 'lainnya']

class OrderListSerializer(serializers.ModelSerializer):
    porsi_details = PorsiDetailSerializer(many=True)

    class Meta:
        model = OrderList
        fields = ['nama', 'meja', 'porsi_details', 'harga', 'pilihan', 'status', 'ip_address']

    def create(self, validated_data):
        porsi_details_data = validated_data.pop('porsi_details')
        order = OrderList.objects.create(**validated_data)
        for porsi_detail_data in porsi_details_data:
            PorsiDetail.objects.create(order=order, **porsi_detail_data)
        return order