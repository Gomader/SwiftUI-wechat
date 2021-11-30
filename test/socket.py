from socket import socket,AF_INET,SOCK_STREAM

tcp = socket(AF_INET,SOCK_STREAM)
tcp.bind(("127.0.0.1",8090))
tcp.listen(100)

client,address = tcp.accept()

while True:
    print(client.recv(10240).decode())