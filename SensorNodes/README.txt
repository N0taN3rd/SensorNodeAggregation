README for SenseNodeAppC
Author/Contact: John Berlin jberlin@cs.odu.edu

Description:

These are sensor nodes for the sensor reading aggregation

To make the application use the command: make iris install.0 mib520,/dev/ttyUSB0
Note:
-The threshold deffinitions are defined in the make file as CFLAGS 
	TH_THRESH=55 change to 5 for violation of temperature high
	TL_THRESH=0 temperature low
	LH_THRESH=250 light high
	LL_THRESH=0  light low
-The number of neighbors to get reading from must be changed at line 44 of SenseNodeC if wanting to have more than 1 negihbor
  	which it is set at now due to me having only three motes two are nodes one is base station
-Basic printf usage for printing to screen results for more details of stages go through code and uncomment  	
