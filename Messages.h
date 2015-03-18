#ifndef MESSAGES_H
#define MESSAGES_H

//main message sent between nodes
//contains all information concerning readings
typedef nx_struct SenseMsg{
	//the raw temperature and light readings
	nx_uint16_t rawT;
	nx_uint16_t rawL;
	//the converted temperature and light readings
	nx_uint16_t tVal;
	nx_uint16_t lVal;

	//the message number(redundant) and local time at a node
	nx_uint16_t msgNum;
	nx_uint32_t tStamp;
	
	//the node id and the value id that determines which 
	//values are important 
	nx_uint8_t nId;
	nx_uint8_t vals;

	//flag if any of the converted readings are in an error state
	nx_uint8_t tErr;
	nx_uint8_t lErr;
} SenseMsg;

//for future use if changing a threshhold on the fly is desired
typedef nx_struct ThrshMsg{
	nx_uint16_t thresh_type;
	
	nx_uint16_t thesh_l;
	
	nx_uint16_t thesh_h;
} ThrshMsg;

//message sent from a requesting node asking other nodes for specific readings
typedef nx_struct RequestMsg{
	//who wanted the readings
	nx_uint8_t reqNod;
	//which readings are desired
	nx_uint8_t valsWanted;
} RequestMsg;

//report message sent to base station containing the report of threshhold violation
typedef nx_struct ReportMsg{
	//did all neighboring nodes experience the same violation
	nx_uint8_t consensus;
	//the converted temperature value
	nx_uint16_t tVal;
	//the converted light value
	nx_uint16_t lVal;
	//did temperature or light exceed a threshold
	nx_uint16_t exceeds;
	//which threshhold was exceeded
	nx_uint16_t offenfdVal;
	//local time at the reporting node at which the violation occured
	nx_uint32_t tStamp;
} ReportMsg;

//local struct at each node for the neighboring nodes readings
typedef struct {
	uint8_t from;
	uint16_t temp;
	uint16_t light;
	uint32_t tStamp;
} receviedSense;


enum{
	//time between sensor reads
	READ_FRQ = 10000,
	//which threshhold
	THRSH_T = 1,
	THRSH_L = 2, 
	//want which values
	Req_T = 3,
	Req_L = 4,
	Req_TL = 5,
	AM_SENSEMSG = 6,
	AM_REQUESTMSG = 7,
	AM_REPORTMSG = 8,
	AM_THRSHMSG = 9
};

#endif MESSAGES_H