#include "../Messages.h"
#include "Timer.h"
#include "printf.h"

/**
 * Configuration for the Sensor Nodes
 * Instantiates the sensors, messaging componets and
 * does all the necessary wiring.
 *
 * @author John Berlin
 */
configuration SenseNodeAppC {

} implementation {
	components MainC, SenseNodeC, ActiveMessageC,LedsC,LocalTimeMilliC;
	components new TimerMilliC() as Timer;
	
	components new AMReceiverC(AM_SENSEMSG) as RecSense,new AMReceiverC(AM_REQUESTMSG) as RecRmsg;
	
	components new AMSenderC(AM_SENSEMSG) as SendSense,new AMSenderC(AM_REQUESTMSG) as SendReq,
	 			new AMSenderC(AM_REPORTMSG) as SendReport;
	
	components new TempLightSensorC() as tlSensor;

	components PrintfC, SerialStartC;

	SenseNodeC.Boot -> MainC;
	SenseNodeC.Leds -> LedsC;
	SenseNodeC.Timer -> Timer;

	SenseNodeC.RadioControl -> ActiveMessageC;
	SenseNodeC.SensePkt ->  SendSense;
	SenseNodeC.RecPkt -> SendReq;

	SenseNodeC.RecSense -> RecSense;
	SenseNodeC.RecRmsg -> RecRmsg;

	SenseNodeC.SendSense -> SendSense;
	SenseNodeC.SendReq -> SendReq;
	
	SenseNodeC.SendReport -> SendReport;
	SenseNodeC.ReportPkt -> SendReport;

   	SenseNodeC.ReadTL -> tlSensor.ReadConvertTL;
   	SenseNodeC.tStamp -> LocalTimeMilliC;
}