from django.shortcuts import HttpResponse
from dwebsocket.decorators import accept_websocket
import json

# Create your views here.
@accept_websocket
def link(request):
    if request.is_websocket():
        message = request.websocket.wait()
        message = json.loads(str(message,'utf-8'))
        print(message)