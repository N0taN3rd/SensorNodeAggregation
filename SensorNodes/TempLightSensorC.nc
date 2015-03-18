/**
* This configuration provides the behavior of interface ReadConvertTL through the 
* help of TempLightSensorP
* @author John Berlin jberlin@cs.odu.edu
*/
generic configuration TempLightSensorC() {
	provides interface ReadConvertTL<uint16_t>;
} implementation {
	components new PhotoC() as PhotSensor;
	components new TempC() as TempSenor;
	components new TempLightSensorP();
	ReadConvertTL = TempLightSensorP.ReadConvertTL;
	TempLightSensorP.ReadL -> PhotSensor;
	TempLightSensorP.ReadT -> TempSenor;
}