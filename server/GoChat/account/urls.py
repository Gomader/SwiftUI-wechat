from django.urls import path
from account import views

urlpatterns = [
    path('signin/',views.signin,name="signin"),
    path('signup/',views.signup,name="signup"),
    path('signout/',views.signout,name="signout"),
    path('getUserInfo/',views.getUserInfo,name="getUserInfo"),
    path('checkToken/',views.checkToken,name="checkToken"),
    path('searchUser/',views.searchUser,name="searchUser"),
    path('getFriendInfo/',views.getFriendInfo,name="getFriendInfo"),
    path('getFriendList/',views.getFriendList,name="getFriendList"),
]