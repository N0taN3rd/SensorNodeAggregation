#include "math.h"

/**
* This is the main logic for reading sensor values and converting them
* the temperature conversion was discovered through the example at
* http://home.roboticlab.eu/en/examples/sensor/thermistor
* @author John Berlin jberlin@cs.odu.edu
*/
generic module TempLightSensorP() {
	provides interface ReadConvertTL<uint16_t>;
	uses {
		interface Read<uint16_t> as ReadT;
		interface Read<uint16_t> as ReadL;
	}
} implementation {
   bool raw = FALSE, both = FALSE;

 /**
  Table for converting  ADC values to temperature values
  Every element of the array marks one Celsius degree
  Elements begin from -20 degree and end at 100 degree
  There are 121 elements in the array
  The table is used to avoid using the following equation for ADC to Kelvin
  Kelvin = 1 / {A + B[ln(R)] + C[ln(R)]^3}
  where A = 0.001129148, B = 0.000234125 and C = 8.76741E-08
 */
  const unsigned short conversion_table[] = {
    91,96,102,107,113,119,125,132,139,146,153,
  160,168,176,184,192,201,210,219,228,238,247,
  257,267,277,288,298,309,319,330,341,352,364,
  375,386,398,409,421,432,444,455,467,478,489,
  501,512,523,534,545,556,567,578,588,599,609,
  619,629,639,649,658,667,677,685,694,703,711,
  720,728,736,743,751,758,766,773,780,786,793,
  799,805,811,817,823,829,834,839,844,849,854,
  859,863,868,872,876,880,884,888,892,896,899,
  903,906,909,912,915,918,921,924,927,929,932,
  934,937,939,941,943,945,947,949,951,953,955
  };
 
  const signed short min_t = -20;
  const signed short max_t = 100;
  
  uint16_t t, tc, l, lc;

//main conversion logic
  task void convert(){
  	signed short celsius = -1;
    double volt = 5.0 * ( (double) l / 1024);
    double resistance = (10.0 * 5.0) / volt - 10.0;
    double lums = 255.84 * pow(resistance, -10/9);

    lc = lums;

  //loop through the table backwards 
    for(celsius = max_t - min_t; celsius >= 0; celsius--){
      // If the value in the table is the same or higher than measured 
      // value, then the temperature is at least as high as the 
      // temperature corresponding to the element
      if(t >= conversion_table[celsius]){ 
      // Since the table begins with 0 but values of the elements 
      // from -20, the value must be shifted
        celsius += min_t; 
        break;
      }
    }
    //we have found our value
    tc = celsius;

    //if we want the raw and coverted readings signal that we are done 
    //else signal that we are done converting
    if(both)
      signal ReadConvertTL.readRCDone(SUCCESS,t,tc,l,lc);
    else
      signal ReadConvertTL.readConvertDone(SUCCESS,tc,lc);
    raw = FALSE;
    both = FALSE;  
  }

  //we have an error report fail
   task void error(){
      if(raw)
        signal ReadConvertTL.readRawDone(FAIL,0,0);
      else if(both)
        signal ReadConvertTL.readRCDone(FAIL,0,0,0,0);
      else 
        signal ReadConvertTL.readConvertDone(FAIL,0,0);
      raw = FALSE;
      both = FALSE; 
  }

  //raw values wanted 
  command error_t ReadConvertTL.readRaw(){
    raw = TRUE;
    return call ReadT.read();
  }

  //converted values wanted
  command error_t ReadConvertTL.readConvert() {
    return call ReadT.read();
  }

  //raw and converted values wanted
  command error_t ReadConvertTL.readRC(){
    both = TRUE;
    return call ReadT.read();
  }

  event void ReadT.readDone(error_t result, uint16_t data) {
  	t = data;
  	call ReadL.read();
  }	

  event void ReadL.readDone(error_t result, uint16_t data) {
       if(result != SUCCESS){
           post error();
       } else {
          if(raw)
            signal ReadConvertTL.readRawDone(result,t,data);
          else{
             l = data;
             post convert();
          }
       }  
   } 
}