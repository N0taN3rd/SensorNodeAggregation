#include "../Messages.h"
#include "Timer.h"

/**
 * Configuration for the AggBaseStationApp
 * Instantiates the messaging componets and
 * does all the necessary wiring.
 *
 * @author John Berlin
 */
configuration AggBaseStationAppC{

} implementation {
	components MainC,AggBaseStationC, LedsC, ActiveMessageC;
	components SerialActiveMessageC;
  	components new SerialAMSenderC(AM_REPORTMSG) as SendReport;
	components new TimerMilliC() as Timer;
	components new AMReceiverC(AM_REPORTMSG) as RecReport;
	AggBaseStationC.Boot -> MainC;
	AggBaseStationC.RadioControl -> ActiveMessageC;
	AggBaseStationC.SerialControl -> SerialActiveMessageC;
	AggBaseStationC.SendSer ->  SendReport;
	AggBaseStationC.SerialAMPacket -> SerialActiveMessageC;
	AggBaseStationC.SerialPacket-> SerialActiveMessageC;
	AggBaseStationC.RReportMsg -> RecReport;
	AggBaseStationC.RadioPacket -> ActiveMessageC;
	AggBaseStationC.RadioAMPacket -> ActiveMessageC;
}