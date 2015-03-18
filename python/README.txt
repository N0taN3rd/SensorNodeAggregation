This directory contains the make file to produce the python classes that are used by DataReader.py 

To make the other files required by DataReader.py issue the command make
Once make finishes the correct classes will be generated. 
The generation of the python classes is executed using the command nescc-mig python ....

Currently only the report message is being sent to the base station 

To use DataReader.py issue these commands in order:
- make *if you have not generated the message files yet
- java net.tinyos.sf.SerialForwarder -comm serial@/dev/ttyUSB1:iris
- python DataReader.py sf@localhost:9002

The DataReader is an infinit loop listening for messages
When a message is recieved it displays its contents to standard out