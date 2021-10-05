from django.shortcuts import render
from dwebsocket.decorators import accept_websocket
from django.contrib.sessions.backends.db import SessionStore
from GoChat.settings import MEDIA_ROOT
import json

# Create your views here.

clients = dict()

def MessageFormat(sender,message):
    return json.dumps({"sender":str(sender),"message":str(message)}) #系统消息sender为-1

@accept_websocket
def link(request):

    if request.is_websocket:

        while True:

            message = request.websocket.wait()
            message = json.loads(str(message,'utf-8'))

            accessToken = message["accessToken"] #检查session
            session = SessionStore(session_key=accessToken)
            if "id" not in session:
                break
            
            if session["id"] not in clients.keys(): #初次登入放到clients字典中
                clients[session["id"]] = request.websocket

            

            if message["reciver"] in clients.keys():
                clients[message["reciver"]].send(MessageFormat(sender=session["id"],message=message["message"]))
