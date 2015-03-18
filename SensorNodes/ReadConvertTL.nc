/**
* To abstract the read sensor values and conversion logic a simple interface is used to define 
* the exspected behavior
* The behavior is provided by TempLightSensorC
* val_t should always be uint16_t for the current implementation
* @author John Berlin jberlin@cs.odu.edu
*/
interface ReadConvertTL<val_t> {
	/**
	*	Return Sucess if the read commond for TempC and LightC will eventually return SUCCESS
	*   When the read is done readRawDone is siginaled 
	*/
	command error_t readRaw();
	/**
	*	Return Sucess if the read commond for TempC and LightC will eventually return SUCCESS
	*   When the read is done readConvertDone is siginaled
	*/
	command error_t readConvert();

	/**
	*	Return Sucess if the read commond for TempC and LightC will eventually return SUCCESS
	*   When the read is done readConvertDone is siginaled
	*/
	command error_t readRC();

	/**
	* val_t rt is the raw temperature reading from TempC
	* val_t rl is the raw light reading from LightC
	* result is either SUCCESS or FAILURE  
	*/
	event void readRawDone(error_t result, val_t rt, val_t rl);

	/**
	* val_t ct is the converted temperature reading from TempC
	* val_t cl is the converted light reading from LightC
	* result is either SUCCESS or FAILURE  
	*/
	event void readConvertDone(error_t result, val_t ct, val_t cl);
	
	/**
	* val_t rt is the raw temperature reading from TempC
	* val_t rl is the raw light reading from LightC
	* val_t ct is the converted temperature reading from TempC
	* val_t cl is the converted light reading from LightC
	* result is either SUCCESS or FAILURE  
	*/
	event void readRCDone(error_t result, val_t rt, val_t ct, val_t rl, val_t cl);
}