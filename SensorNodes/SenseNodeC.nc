#include <stdlib.h>
#include "../Messages.h"
#include "printf.h"

/**
 * Implementation of SenseNodeAppC
 * @author John Berlin
 */
module SenseNodeC {
	uses {
		interface Boot;
		interface Leds;

		interface SplitControl as RadioControl;

		interface Packet as SensePkt;
		interface Packet as ReportPkt;
		interface Packet as RecPkt;
		interface AMSend as SendSense;
		interface AMSend as SendReq;
		interface AMSend as SendReport;

		interface Receive as RecSense;
		interface Receive as RecRmsg;

		interface ReadConvertTL<uint16_t> as ReadTL;
		interface LocalTime<TMilli> as tStamp;
		interface Timer<TMilli> as Timer;
	}
} implementation {
	
	enum{
		AGG_LEN = 2, //how many readings to we need to have
		t = 1, //these values are used to compactly denote if temperature or light have violated a threshold
		l = 4,
		t_high = 1, //these values are used to compactly dented which threshold was violated
		t_low = 2,
		l_high = 4,
		l_low = 8,
	};


	//how many neighbors do we have
	uint8_t totalNeighbors = 1;
	//when aggergating the sensor readings from neighbors how many do we have
	uint8_t neighborCount = 0;

	//which sensor values are wanted by a neighboring node
	uint8_t valsWanted;
	//which node wanted the sensor values
	uint8_t whoWantsVals;
	// does temperature and or light violate a threshold, which threshold
	uint8_t exceedsThresh = 0, offendingValue;

	//raw temperature , light readings and message number
	uint16_t temp,light,mNum;
	//converted temperature and light readings
	uint16_t cTemp, cLight;
	//my timestamp for current readign
	uint32_t myTime;
	//average temperature
	uint32_t tav;
	//average light
	uint32_t lav;
	
	//flags for various operations
	bool busy = FALSE, sendTemps = FALSE, sendReqMsg = FALSE, consensus = FALSE, me = FALSE;
	message_t reqMT, sensMT, repMT;
	//holder of recieved sensor readings
	SenseMsg received[AGG_LEN];
	//holds the average sensor readings for all nodes
	uint32_t av[2];

	/**
	 	checks if the converted values are within the defined thresholds
		since both temperature and light may violate their respective thresholds 
		and the particular threshold violated for one or both can be different
		a bitmask scheme is employed to compactly denote which reading and which threshold 
		the values used are in the enum declared in this module
	*/
	bool withinThresh(uint16_t ctemp, uint16_t clight){
		bool good = TRUE;
		if(ctemp > TH_THRESH){
			printf("Temperature exceeds high threashhold\n");
			exceedsThresh = t;
			offendingValue = t_high;
			good = FALSE;
		}else if(ctemp < TL_THRESH){
			printf("Temperature lower than low threashhold\n");
			exceedsThresh = t;
			offendingValue = t_low;
			good = FALSE;	
		}else{ 
			printf("Temperature between threashholds\n");
		}

		if(clight >  LH_THRESH){
			printf("Light exceeds high threashhold\n");
			if(good){
				exceedsThresh = l;
				offendingValue = l_high; 
				good = FALSE;
			}else{
				exceedsThresh  = t | l;
				offendingValue = offendingValue | l_high;
			}
		}else if(clight < LL_THRESH){
			printf("Light lower than low threashhold\n");
			if(good){
				exceedsThresh = l;
				offendingValue = l_low;
				good = FALSE;
			}else{
				exceedsThresh  = t | l;
				offendingValue = offendingValue | l_low;
			}
		}else{
			printf("Light between threashholds\n");
		}		
		printfflush();
		return good;	
	}

	event void Boot.booted(){
		call RadioControl.start();
	}


	event void  RadioControl.startDone(error_t error){
		if(error != SUCCESS)
			call RadioControl.start();
		else {
			call Timer.startPeriodic(READ_FRQ);	
		}	
	}

	event void SendReport.sendDone(message_t* msg, error_t err) {
		if(&repMT == msg){
			
		}
		busy = FALSE;
	}

	/**
		Simple comparison scheme which is to get the average sensor reading for all nodes
		then if the average is violating a threshold then our own violation is not localized
		otherwise it is
		When done send a report to the basestation denoted as 0
	*/
	task void compareAgg(){
		ReportMsg* rm = (ReportMsg*)call ReportPkt.getPayload(&repMT,sizeof(ReportMsg));
		int i;
		av[0]  = cTemp;
		av[1] = cLight;
		for(i = 0; i < totalNeighbors; ++i){
			printf("neighbor num= %u\n",received[i].nId);
			printf("neighbor temp= %u\n",received[i].tVal);
			printf("neighbor light= %u\n",received[i].lVal);
			printf("neighbor time= %ld\n",received[i].tStamp);
			av[0] += received[i].tVal;
			av[1] += received[i].lVal;
			
		}
			
		tav = av[0] / totalNeighbors;
		lav = av[1] / totalNeighbors;

		switch(exceedsThresh){
			case t|l:
				printf("Temperature and Light both were not within their threashholds\n");
				switch(offendingValue){
					case t_high | l_high:
						if(tav >= TH_THRESH && lav >= LH_THRESH){
							printf("The average Temp is >= Temp high threashhold\n");
							printf("The average Light is >= Light high threashhold\n");
							consensus = TRUE;
						}else{
							printf("The average Temp is not >= Temp high threashhold\n");
							printf("The average Light is not >= Light high threashhold\n");
						}
						break;
					case t_high | l_low:
						if(tav >= TH_THRESH && lav <= LL_THRESH){
							printf("The average Temp is >= Temp high threashhold\n");
							printf("The average Light is <= Light low threashhold\n");
							consensus = TRUE;
						}else{
							printf("The average Temp is not >= Temp high threashhold\n");
							printf("The average Light is not <= Light low threashhold\n");
						}
					case t_low | l_high:
						if(tav <= TL_THRESH && lav >= LH_THRESH){
							printf("The average Temp is <= Temp low threashhold\n");
							printf("The average Light is >= Light high threashhold\n");
							consensus = TRUE;
						}else{
							printf("The average Temp is not <= Temp low threashhold\n");
							printf("The average Light is not >= Light high threashhold\n");
						}	
						break;
					case t_low | l_low:
						if(tav <= TL_THRESH && lav <= LL_THRESH){
							printf("The average Temp is <= Temp low threashhold\n");
							printf("The average Light is <= Light low threashhold\n");
							consensus = TRUE;
						}else{
							printf("The average Temp is not <= Temp low threashhold\n");
							printf("The average Light is not <= Light low threashhold\n");
						}
					    break;
					}
					break;	
				case t:
					printf("Temperature was not within its threashholds\n");
					if(offendingValue == t_high){
						if(tav >= TH_THRESH){
							printf("The average Temp is >= Temp high threashhold\n");
							consensus = TRUE;
						}else{
							printf("The average Temp is  not >= Temp high threashhold\n");
						}
					}else{
						if(tav <= TL_THRESH){
							printf("The average Temp is <= Temp low threashhold\n");
							consensus = TRUE;
						}else{
							printf("The average Temp is not <= Temp low threashhold\n");
						}
					}
					break;	
				case l:
					printf("Light was not within its threashholds\n");
					if(offendingValue == l_high){
						if(lav >= LH_THRESH){
							printf("The average Light is >= Light high threashhold\n");
							consensus = TRUE;
						}else{
							printf("The average Lgiht is not >= Light high threashhold\n");
						}
					}else{
						if(lav <= LL_THRESH){
							printf("The average Light is <= Light low threashhold\n");
							consensus = TRUE;
						}else{
							printf("The average Light is not <= Light low threashhold\n");
						}
					}
					break;
				}
		printfflush();
		if(consensus){
			printf("All nodes share the same average reading which is below the threashhold");
		}else{
			printf("Only me has a reading that is less than its threashhold");
		}
		rm->consensus = consensus ? 1 : 0;
		consensus = FALSE;		
		
		printfflush();

		rm->tVal = cTemp;
		rm->lVal = cLight;
		rm->exceeds = exceedsThresh;
		rm->offenfdVal = offendingValue;
		rm->tStamp = myTime;
		call SendReport.send(0,&repMT, sizeof(ReportMsg));
		
	}

	event void RadioControl.stopDone(error_t error){}

	/**
		For the aggregation stage when we recieve a sense message copy it to the array containing 
		neighbor readings increment the neighborcount by one to indicate we have recieved it 
		if we have all the readings from a neighbor start the comparison
		otherwise wait for another
	*/
	event message_t* RecSense.receive(message_t* msg, void* payload, uint8_t len){
		memcpy(&received[neighborCount], ((SenseMsg*)payload), len);	
		neighborCount++;
		if(neighborCount == totalNeighbors){
			neighborCount = 0;
			post compareAgg();
		}else{
			printf("Got a neighbor %u\n",neighborCount);
			printfflush();
		}
		return msg;
	}	
	
	/**
		I have recieved a request for sensor reading(s)
		get the values wanted and who wanted them 
		call for read raw and converted values
	*/
	event message_t* RecRmsg.receive(message_t* msg, void* payload, uint8_t len){
		RequestMsg* rmsg = (RequestMsg*) payload;
		printf("Receiving RequestMsg\n");
		call Leds.led0On();
		valsWanted = rmsg->valsWanted;
		whoWantsVals = rmsg->reqNod;
		sendTemps = TRUE;
		busy = TRUE;
		call ReadTL.readRC();
		return msg;
	}

	event void SendSense.sendDone(message_t* msg, error_t err) {
		if(&sensMT == msg){
			busy = FALSE;
			printf("Send sense msg done\n");
			sendTemps = FALSE;
		}
		
	}

	event void SendReq.sendDone(message_t* msg, error_t err) {
		if(&reqMT == msg){
			printf("Send temp request done\n");
			printf("Waiting on reply\n");
		}
		
	}	


	event void ReadTL.readRawDone(error_t result, uint16_t tmp, uint16_t lght){

	}
	
	/**
		When reading is done get time stamp and check if I am sending those readings to a neighboring node
		otherwise check if my readings are within their respective thresholds if not start the 
		aggergation 
	*/
	event void ReadTL.readConvertDone(error_t result,  uint16_t ct, uint16_t cl){
		cTemp = ct;
		cLight = cl;
		myTime = call tStamp.get();
		if(sendTemps){
			SenseMsg* sm = (SenseMsg*)call SensePkt.getPayload(&sensMT,sizeof(SenseMsg));
			sm->rawT = temp;
			sm->rawL = light;
			sm->tVal = cTemp;
			sm->lVal = cLight;
			sm->tStamp = myTime;
			sm->nId = TOS_NODE_ID;
			if(call SendSense.send(whoWantsVals,&sensMT, sizeof(SenseMsg)) == SUCCESS){
				//printf("Sending req\n");
				busy = FALSE;
				call Leds.led0Off();
			}else{
				//printf("Did not send\n");
			}
			sendTemps = FALSE;
		}else {
			if(!withinThresh(cTemp,cLight)){
				RequestMsg* r = (RequestMsg*)call RecPkt.getPayload(&reqMT,sizeof(RequestMsg));
				r->reqNod = TOS_NODE_ID;
				r->valsWanted = Req_TL;
				if(call SendReq.send(AM_BROADCAST_ADDR,&reqMT,sizeof(RequestMsg)) == SUCCESS){
					busy = TRUE;
					//printf("Requesting Temps\n");
				}else{
					//printf("Request failed\n");
				}
			}
		
		//printfflush();
		}
	}

	/**
		When reading is done get time stamp and check if I am sending those readings to a neighboring node
		otherwise check if my readings are within their respective thresholds if not start the 
		aggergation 
	*/
	event void ReadTL.readRCDone(error_t result, uint16_t tmp, uint16_t ct,  uint16_t lght, uint16_t cl){
		temp = tmp;
		cTemp = ct;
		light = lght;
		cLight = cl;
		myTime = call tStamp.get();
		/*
			printf("Raw temp = %u\n",t);
			printf("Converted temp = %u\n",ct);
			printf("Raw light = %u\n",l);
			printf("Converted Light = %u\n",cl);
			printf("My Time = %ld\n\n",myTime);
		*/	
		if(sendTemps){
			SenseMsg* sm = (SenseMsg*)call SensePkt.getPayload(&sensMT,sizeof(SenseMsg));
			sm->rawT = temp;
			sm->rawL = light;
			sm->tVal = cTemp;
			sm->lVal = cLight;
			sm->tStamp = myTime;
			sm->nId = TOS_NODE_ID;
			if(call SendSense.send(whoWantsVals,&sensMT, sizeof(SenseMsg)) == SUCCESS){
				//printf("Sending req\n");
				busy = FALSE;
				call Leds.led0Off();
			}else{
				//printf("Did not send\n");
			}
			sendTemps = FALSE;
		}else {
			if(!withinThresh(cTemp,cLight)){
				RequestMsg* r = (RequestMsg*)call RecPkt.getPayload(&reqMT,sizeof(RequestMsg));
				r->reqNod = TOS_NODE_ID;
				r->valsWanted = Req_TL;
				if(call SendReq.send(AM_BROADCAST_ADDR,&reqMT,sizeof(RequestMsg)) == SUCCESS){
					busy = TRUE;
					//printf("Requesting Temps\n");
				}else{
					//printf("Request failed\n");
				}
			}
		
		//printfflush();
		}
	}	

	event void Timer.fired(){
		if(busy){
			return;
		} else {
			call ReadTL.readRC();	
		}
	}

}