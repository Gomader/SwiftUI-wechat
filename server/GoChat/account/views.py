from django.http import HttpResponse
from account import models as account_models
from django.db.models import Q
import json
import random


# Create your views here.

def ReturnFormat(code,msg,accesstoken="",data=""):
    return json.dumps({"code":code,"msg":msg,"accesstoken":accesstoken,"data":data})

def randomId():
    random_str = 'gxid_'
    base_str = 'ABCDEFGHIGKLMNOPQRSTUVWXYZabcdefghigklmnopqrstuvwxyz0123456789'
    length = len(base_str) - 1
    for i in range(15):
        random_str += base_str[random.randint(0, length)]
    return random_str

def signin(request):
    if request.method == "POST":
        email = request.POST["account"]
        password = request.POST["password"]
        user = account_models.Account.objects.filter(Q(email=email)&Q(password=password))
        if len(user) == 1:
            request.session["id"] = user[0].id
            request.session.save()
            return HttpResponse(ReturnFormat(code=200,msg="登录成功",accesstoken=request.session.session_key,data={"id":user[0].id}))
        else:
            return HttpResponse(ReturnFormat(code=401,msg="用户名或密码错误"))
    else:
        return HttpResponse(ReturnFormat(code=405,msg="请求方法不正确"))

def signup(request):
    if request.method == "POST":
        username = request.POST["username"]
        email = request.POST["email"]
        password = request.POST["password"]
        id = randomId()
        print(request.FILES.keys())
        while True:
            user = account_models.Account.objects.filter(Q(id=id))
            if len(user) == 0 :
                break
            else:
                id = randomId()
        user = account_models.Account.objects.filter(Q(email=email))
        if len(user) != 0:
            return HttpResponse(ReturnFormat(code=403,msg="邮箱已被注册"))
        #try:
        icon = request.FILES["icon"]
        account_models.Account.objects.create(id=id,username=username,email=email,password=password,icon=icon)
        #except:
        #    account_models.Account.objects.create(id=id,username=username,email=email,password=password)
        return HttpResponse(ReturnFormat(code=200,msg="注册成功"))
        
    else:
        return HttpResponse(ReturnFormat(code=405,msg="请求方法不正确"))