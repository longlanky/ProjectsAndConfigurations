import socket
import board
import time
import adafruit_scd30
from datetime import datetime

i2c = board.I2C()
scd = adafruit_scd30.SCD30(i2c)

HOST = 'local host'
PORT = 65432

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind(('', PORT))
while "True":
	s.listen(1)
	c, addr = s.accept()
	co2 = round(scd.CO2,2)
	msg = str(co2)
	print("CLIENT:", str(addr), msg)
	c.send(msg.encode())
	c.close()