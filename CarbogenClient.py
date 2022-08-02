import socket

host = 'localhost'
port = 65432

s = socket.socket(socket.AF_INET,
				socket.SOCK_STREAM)
s.connect(('127.0.0.1', port))
msg = s.recv(1024)
while msg:
	print(msg.decode())
	msg = s.recv(1024)
s.close()
