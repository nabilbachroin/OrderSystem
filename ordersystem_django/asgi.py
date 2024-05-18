"""
ASGI config for ordersystem_django project.

It exposes the ASGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/4.2/howto/deployment/asgi/
"""

import os
import django
from channels.routing import get_default_application

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'ordersystem_django.settings')
django.setup()
application = get_default_application()

application = ProtocolTypeRouter({
  "http": get_asgi_application(),
  # (Tambahkan rute WebSocket di sini jika ada)
})