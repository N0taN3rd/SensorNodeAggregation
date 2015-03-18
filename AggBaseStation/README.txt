README for AggBaseStationApp
Author/Contact: John Berlin jberlin@cs.odu.edu

Description:
The AggBaseStationApp is a simple base station whoes only purpose is to send report messages to a computer via the SerialForwarder.
The data sent is viewed using DataReader.py located in the python directory

To make the application use the command: make iris install.0 mib520,/dev/ttyUSB0
The makefile is written under the new Make system version 3 as described on TinyOS github https://github.com/tinyos/tinyos-main/tree/master/support/make

If you do not use this utility put the sensor node app on a node and use the command 
java net.tinyos.tools.PrintfClient -comm serial@/dev/ttyUSB1:iris to view its output

See the README in SensorNodes and python 


