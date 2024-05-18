from django.contrib import admin

# Register your models here.
from .models import MenuBakso, MinumanPojokJoyo, OrderList

admin.site.register(MenuBakso)
admin.site.register(MinumanPojokJoyo)
admin.site.register(OrderList)
