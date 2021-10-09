from django.http import HttpResponse
from account import models as account_models
from django.core import serializers
from django.db.models import Q
from GoChat.settings import MEDIA_ROOT
import json,random,os,datetime


# Create your views here.

def ReturnFormat(code,msg,accesstoken="",data=[]):
    for col in range(len(data)):
        for cell in data[col]["fields"].keys():
            if data[col]["fields"][cell] == None:
                data[col]["fields"][cell] = ""
    return json.dumps({"code":code,"msg":msg,"accesstoken":accesstoken,"data":data})

def randomId():
    random_str = 'gxid_'
    base_str = 'ABCDEFGHIGKLMNOPQRSTUVWXYZabcdefghigklmnopqrstuvwxyz0123456789'
    length = len(base_str) - 1
    for i in range(15):
        random_str += base_str[random.randint(0, length)]
    return random_str

def initUserFiles(id):
    # 新建聊天记录文件夹，以及temporary文件夹，储存文件
    if os.path.exists(MEDIA_ROOT+"/ChatHistory/{}".format(id)) == False:
        os.makedirs(MEDIA_ROOT+"/ChatHistory/{}".format(id)+"/temporary")
    # 新建信息文件夹
    if os.path.exists(MEDIA_ROOT+"/UserInfo/{}".format(id)) == False:
        os.makedirs(MEDIA_ROOT+"/UserInfo/{}".format(id))
    # 新建friends.json储存通讯录字符串
    with open(MEDIA_ROOT+"/UserInfo/{}".format(id)+"/friends.json","w") as f:
        json.dump({},f)

def signin(request):
    if request.method == "POST":
        email = request.POST["account"]
        password = request.POST["password"]
        user = account_models.Account.objects.filter(Q(email=email)&Q(password=password))
        if len(user) == 1:
            request.session["id"] = user[0].id
            request.session.save()
            return HttpResponse(ReturnFormat(code=200,msg="登录成功",accesstoken=request.session.session_key))
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
        while True:
            user = account_models.Account.objects.filter(Q(id=id))
            if len(user) == 0 :
                break
            else:
                id = randomId()
        user = account_models.Account.objects.filter(Q(email=email))
        if len(user) != 0:
            return HttpResponse(ReturnFormat(code=403,msg="邮箱已被注册"))
        try:
            icon = request.FILES["icon"]
            account_models.Account.objects.create(id=id,username=username,email=email,password=password,icon=icon)
        except:
            account_models.Account.objects.create(id=id,username=username,email=email,password=password)
        initUserFiles(id)
        request.session["id"] = id
        request.session.save()
        return HttpResponse(ReturnFormat(code=200,msg="注册成功",accesstoken=request.session.session_key))        
    else:
        return HttpResponse(ReturnFormat(code=405,msg="请求方法不正确"))

def signout(request):
    if "id" in request.session.keys():
        del request.session["id"]
    return HttpResponse(ReturnFormat(code=200,msg="已注销"))

def getUserInfo(request):
    if request.method == "POST":
        if "id" in request.session.keys():
            user = account_models.Account.objects.filter(Q(id=request.session["id"]))
            if len(user) == 1:
                data = json.loads(serializers.serialize("json", user,fields=("sex","username","email","icon")))
                return HttpResponse(ReturnFormat(code=200,msg="获取个人信息成功",accesstoken=request.session.session_key,data=data))
            else:
                return HttpResponse(ReturnFormat(code=400,msg="用户不存在"))
        else:
            return HttpResponse(ReturnFormat(code=401,msg="未登录"))
    else:
        return HttpResponse(ReturnFormat(code=405,msg="请求方法不正确"))

def checkToken(request):
    request.session.clear_expired()
    if "id" in request.session.keys():
        return HttpResponse(ReturnFormat(code=200,msg="已登录"))
    else:
        return HttpResponse(ReturnFormat(code=401,msg="未登录"))

def searchUser(request):
    if request.method == "POST":
        if "id" in request.session.keys():
            result = account_models.Account.objects.filter(Q(id__icontains=request.POST["key"]) & ~Q(id=request.session["id"]))
            data = json.loads(serializers.serialize("json", result, fields=("sex","username","icon")))
            return HttpResponse(ReturnFormat(code=200,msg="查询成功",accesstoken=request.session.session_key,data=data))
    else:
        return HttpResponse(ReturnFormat(code=405,msg="请求方法不正确"))

def getFriendInfo(request):
    if request.method == "POST":
        if "id" in request.session.keys():
            user = account_models.Account.objects.filter(Q(id=request.POST["id"]))
            if len(user) == 1:
                data = json.loads(serializers.serialize("json", user,fields=("sex","username","icon")))
                return HttpResponse(ReturnFormat(code=200,msg="获取个人信息成功",accesstoken=request.session.session_key,data=data))
            else:
                return HttpResponse(ReturnFormat(code=400,msg="用户不存在"))
        else:
            return HttpResponse(ReturnFormat(code=401,msg="未登录"))
    else:
        return HttpResponse(ReturnFormat(code=405,msg="请求方法不正确"))

def getFriendList(request):
    if request.method == "POST":
        if "id" in request.session.keys():
            data = dict()
            with open(MEDIA_ROOT+"/UserInfo/{}".format(request.session["id"])+"/friends.json","r", encoding="utf-8") as f:
                data = json.load(f)
            return HttpResponse(ReturnFormat(code=200,msg="获取好友列表成功",accesstoken=request.session.session_key,data=data))
        else:
            return HttpResponse(ReturnFormat(code=401,msg="未登录"))
    else:
        return HttpResponse(ReturnFormat(code=405,msg="请求方法不正确"))

def sendFriendRequest(request):
    if request.method == "POST":
        if "id" in request.session.keys():
            user = account_models.Account.objects.filter(id=request.session["id"])[0]
            friendId = account_models.Account.objects.filter(id=request.POST["id"])[0]
            application = account_models.FriendApplication.objects.filter(Q(applicant=request.session["id"])&Q(receiver=request.POST["id"]))
            if len(application) == 0:
                account_models.FriendApplication.objects.create(applicant=user,receiver=friendId,expire_date=(datetime.datetime.now()+datetime.timedelta(days=3)))
            return HttpResponse(ReturnFormat(code=200,msg="发送好友请求成功",accesstoken=request.session.session_key))
        else:
            return HttpResponse(ReturnFormat(code=401,msg="未登录"))
    else:
        return HttpResponse(ReturnFormat(code=405,msg="请求方法不正确"))

def acceptFriendRequest(request):
    if request.method == "POST":
        if "id" in request.session.keys():
            id=request.session["id"]
            result = account_models.FriendApplication.objects.filter(receiver=id)
            data = json.loads(serializers.serialize("json", result, fields=("applicant","create_time","expire_date")))
            return HttpResponse(ReturnFormat(code=200,msg="获取好友申请列表成功",accesstoken=request.session.session_key,data=data))
        else:
            return HttpResponse(ReturnFormat(code=401,msg="未登录"))
    else:
        return HttpResponse(ReturnFormat(code=405,msg="请求方法不正确"))

def getFriendRequestList(request):
    if request.method == "POST":
        if "id" in request.session.keys():
            id=request.session["id"]
            result = account_models.FriendApplication.objects.filter(receiver=id)
            data = json.loads(serializers.serialize("json", result, fields=("applicant","create_time","expire_date")))
            return HttpResponse(ReturnFormat(code=200,msg="获取好友申请列表成功",accesstoken=request.session.session_key,data=data))
        else:
            return HttpResponse(ReturnFormat(code=401,msg="未登录"))
    else:
        return HttpResponse(ReturnFormat(code=405,msg="请求方法不正确"))