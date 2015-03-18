all: sensMsg.py thrshMsg.py reqMsg.py reportMsg.py 

sensMsg.py: ../Messages.h
	nescc-mig python -python-classname=sensMsg ../Messages.h SenseMsg -o $@

thrshMsg.py: ../Messages.h
	nescc-mig python -python-classname=thrshMsg ../Messages.h ThrshMsg -o $@

reqMsg.py: ../Messages.h
	nescc-mig python -python-classname=reqMsg ../Messages.h RequestMsg -o $@

reportMsg.py: ../Messages.h
	nescc-mig python -python-classname=reportMsg ../Messages.h ReportMsg -o $@	

clean:
	rm *py	