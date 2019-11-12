#!/usr/bin/python3

import math
import time

i = 0;
"""
a = 24
om = 0.15
off = 30
sleep = 0.05
args = []
"""

def readVals():
	global a, om, off, sleep
	helix = open("helix.txt","r");
	for line in helix:
		args = line.split(",");
		a = int(args[0])
		om = float(args[1])
		off = int(args[2])
		sleep = float(args[3].strip('\n'))
	# print(args)
	helix.close()

while True:
	global a, om, off, sleep
	if i%10 == 0:
		readVals()
	for j in range(0, math.floor(a*math.sin(i*om))+off):
		print(" ", end='');
	print('\033[38;5;201mo')
	for j in range(0, math.floor(a*math.sin(i*om + math.pi))+off):
		print(" ", end='')
	print('\033[38;5;10mo');
	for j in range(0, math.floor(a*math.cos(i*om + math.pi))+off):
		print(" ", end='')
	print('\033[38;5;11mo');
	i+=1
	time.sleep(sleep);


