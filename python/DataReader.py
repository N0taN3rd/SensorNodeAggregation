#!/usr/bin/env python
import os
import sys
import time
import struct
import traceback
import string
import reportMsg
import math
import random


from tinyos.message import *
from tinyos.message.Message import *
from tinyos.message.SerialPacket import *
from tinyos.packet.Serial import Serial

class DataReader:
	def __init__(self, motestring):
		self.mif = MoteIF.MoteIF()
		self.tos_source = self.mif.addSource(motestring)
		self.mif.addListener(self, reportMsg.reportMsg)
		self.more = True
		self.t_high = 1
		self.t_low = 2 
		self.l_high = 4
		self.l_low = 8
		random.seed(time.gmtime())

	def receive(self, src, msg):
		offend = msg.get_offenfdVal()
		print msg
		print "consensus= ", msg.get_consensus();
		print "temperature value = ", msg.get_tVal();
		print "light value= ", msg.get_lVal();
		exceeds = msg.get_exceeds()

		if exceeds == 1 | 4:
			print "Both temperature and light have values that exceeded a threshold"
		elif exceeds == 1:
			print "Temperature only exceeds a threshold"
		elif exceeds == 4:
			print "Light only exceeds a threshold"		
		
		if offend == self.t_high | self.l_high:
			print "The threshold that was exceeded was both temperature high and light high"
		elif offend == self.t_high | self.l_low:
			print "The threshold that was exceeded was both temperature high and light low"
		elif offend == self.t_low | self.l_high:
			print "The threshold that was exceeded was both temperature low and light high"
		elif offend == self.t_low | self.l_low:
			print "The threshold that was exceeded was both temperature low and light low"
		elif offend == self.t_low:
			print "The threshold that was exceeded was temperature low"
		elif offend == self.t_high:
			print "The threshold that was exceeded was temperature high"
		elif offend == self.l_low:
			print "The threshold that was exceeded was light low"
		elif offend == self.l_high:
			print "The threshold that was exceeded was light high"

		print "The local time at node when threshold was exceeded was ",msg.get_tStamp()
		print "\n"	
		sys.stdout.flush() 	

	def main_loop(self):
		while self.more:
			time.sleep(3)
	
					 

def main():
		dr = DataReader(sys.argv[1])
		dr.main_loop()

if __name__ == "__main__":
	main() 		  