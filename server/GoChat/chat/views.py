from django.shortcuts import render
from dwebsocket.decorators import accept_websocket
from GoChat.settings import MEDIA_ROOT
import json

# Create your views here.

clients = dict()

def MessageFormat(sender,message):
    return json.dumps({"sender":str(sender),"message":str(message)}) #系统消息sender为-1

@accept_websocket
def link(request):

    if request.is_websocket:

        if "id" not in request.session.keys():
            return
        elif request.session["id"] not in clients.keys(): #初次登入放到clients字典中
            clients[request.session["id"]] = request.websocket

        while True:

            message = request.websocket.wait()
            message = json.loads(str(message,'utf-8'))

            print(message)
            # if message["reciver"] in clients.keys():
            #     clients[message["reciver"]].send(MessageFormat(sender=session["id"],message=message["message"]))
        
        del clients[request.session["id"]]

def friendRequest(data):
    clients[data.applicant.id].send("hi")