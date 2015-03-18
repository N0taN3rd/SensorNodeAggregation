#include "../Messages.h"

/**
 * Main code for the AggBaseStation
 *
 * @author John Berlin
 */
module AggBaseStationC {
	uses{
		interface Boot;
		interface SplitControl as RadioControl;
		interface SplitControl as SerialControl;
		interface AMPacket as SerialAMPacket;
		interface Packet as SerialPacket;
		interface AMPacket as RadioAMPacket;
		interface Packet as RadioPacket;
		interface AMSend as SendSer;
		interface Receive as RReportMsg;
	}
} implementation {
	message_t serReport;
	event void Boot.booted(){
		call RadioControl.start();
		call SerialControl.start();
	}

	event void  RadioControl.startDone(error_t error){
		if(error != SUCCESS)
			call RadioControl.start();	
	}

	event void  SerialControl.startDone(error_t error){
		if(error != SUCCESS)
			call SerialControl.start();	
	}

	event void RadioControl.stopDone(error_t error){}
	event void SerialControl.stopDone(error_t error){}

	event void SendSer.sendDone(message_t* msg, error_t error){
		if(error != SUCCESS){

		} else {
			if(&serReport == msg){

			}
		}
	}

	event message_t* RReportMsg.receive(message_t* msg, void* payload, uint8_t len){
		ReportMsg* rmsg = (ReportMsg*)payload;
		ReportMsg* srmsg = (ReportMsg*) call SerialPacket.getPayload(&serReport,sizeof(ReportMsg));
		srmsg->lVal = rmsg->lVal;
		srmsg->tVal = rmsg->tVal;
		srmsg->tStamp = rmsg->tStamp;
		srmsg->exceeds =  rmsg->exceeds;
		srmsg->offenfdVal = rmsg->offenfdVal;
		srmsg->consensus = rmsg->consensus;
		call SendSer.send(AM_BROADCAST_ADDR,&serReport,sizeof(ReportMsg));
		return msg;
	}	
}