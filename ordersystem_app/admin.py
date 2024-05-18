from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from .models import CustomUser
from .forms import CustomUserCreationForm, CustomUserChangeForm

# Register your models here.
from .models import MenuBakso, MinumanPojokJoyo, OrderList

class CustomUserAdmin(UserAdmin):
    add_form = CustomUserCreationForm
    form = CustomUserChangeForm
    model = CustomUser
    list_display = ['username', 'email', 'role']

admin.site.register(CustomUser, CustomUserAdmin)
admin.site.register(MenuBakso)
admin.site.register(MinumanPojokJoyo)
admin.site.register(OrderList)