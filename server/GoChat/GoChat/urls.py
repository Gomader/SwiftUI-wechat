"""GoChat URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.urls import path,re_path
from django.urls import include
from django.views.static import serve
from GoChat import views
from GoChat.settings import MEDIA_ROOT
from GoChat.settings import STATIC_ROOT

urlpatterns = [
    path('account/', include('account.urls')),
    path('chat/',include('chat.urls')),
    re_path(r'^media/(?P<path>.*)$', serve, {'document_root': MEDIA_ROOT}),
    re_path(r'^static/(?P<path>.*)$', serve, {'document_root': STATIC_ROOT}),
]
