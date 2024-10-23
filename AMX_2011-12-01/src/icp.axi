// Input Control Processor
PROGRAM_NAME = 'icp'


DEFINE_CONSTANT
//digital out
INTEGER IcpOutDiChsCnt = 56;
//analog out
INTEGER IcpOutAnChsCnt = 4;
//digital in
INTEGER IcpInDiChsCnt = 176;
//analog in
INTEGER IcpInAnChsCnt = 7;

//define timeline arrays for connection and request events.
LONG TimeLineArr_IcpConn[1] = {200};
LONG TimeLineArr_IcpOutRqst[1] = {200};
LONG TimeLineArr_IcpInRqst[1] = {200};


DEFINE_VARIABLE
//store the values of digital and analog channels for ICP output/input devices.
VOLATILE INTEGER IcpOutDiChnVals[IcpOutDiChsCnt];
VOLATILE INTEGER IcpOutAnChnVals[IcpOutAnChsCnt];
VOLATILE INTEGER IcpInDiChnVals[IcpInDiChsCnt];
VOLATILE INTEGER IcpInAnChnVals[IcpInAnChsCnt];

//indicate the online status of ICP output and input devices.
VOLATILE INTEGER IcpOutOnline;
VOLATILE INTEGER IcpInOnline;


//functions for sending commands to ICP devices to get the values of digital and analog channels for both output and input devices.
DEFINE_CALL 'GetIcpOutDiChnVals'
{
	SEND_STRING IcpOut, "$00, $00, $00, $00, $00, $06, $01, $01, $00, $00, IcpOutDiChsCnt >> 8, IcpOutDiChsCnt";
}


DEFINE_CALL 'GetIcpOutAnChnVals'
{
	SEND_STRING IcpOut, "$00, $00, $00, $00, $00, $06, $01, $03, $00, $00, IcpOutAnChsCnt >> 8, IcpOutAnChsCnt";
}


DEFINE_CALL 'GetIcpInDiChnVals'
{
	SEND_STRING IcpIn, "$00, $00, $00, $00, $00, $06, $01, $02, $00, $00, IcpInDiChsCnt >> 8, IcpInDiChsCnt";
}


DEFINE_CALL 'GetIcpInAnChnVals'
{
	SEND_STRING IcpIn, "$00, $00, $00, $00, $00, $06, $01, $04, $00, $00, IcpInAnChsCnt >> 8, IcpInAnChsCnt";
}



//These functions parse the responses from ICP devices and update the channel values accordingly.

DEFINE_CALL 'ParseIcpOutRespon_Di' (CHAR Respon[])
{
	INTEGER i;
	INTEGER j;
	INTEGER k;
	CHAR Temp;
	INTEGER ResponLen;
	ResponLen = LENGTH_ARRAY(Respon);
	
	FOR (i = 1, j = 10; i <= IcpOutDiChsCnt && j <= ResponLen; j++)
	{
		Temp = Respon[j];
		FOR (k = 0; k < 8 && i <= IcpOutDiChsCnt; k++, i++)
		{
			IcpOutDiChnVals[i] = Temp & $01;
			Temp = Temp >> 1;
		}
	}
}


DEFINE_CALL 'ParseIcpOutRespon_An' (CHAR Respon[])
{
	INTEGER i;
	INTEGER j;
	INTEGER ResponLen;
	ResponLen = LENGTH_ARRAY(Respon);
	
	FOR (i = 1, j = 10; i <= IcpOutAnChsCnt && j <= ResponLen; i++, j = j + 2)
	IcpOutAnChnVals[i] = (Respon[j] << 8) + Respon[j + 1];
}


DEFINE_CALL 'ParseIcpInRespon_Di' (CHAR Respon[])
{
	INTEGER i;
	INTEGER j;
	INTEGER k;
	CHAR Temp;
	INTEGER ResponLen;
	ResponLen = LENGTH_ARRAY(Respon); //31
	
	FOR (i = 1, j = 10; i <= IcpInDiChsCnt && j <= ResponLen; j++)
	{
		Temp = Respon[j];
		FOR (k = 0; k < 8 && i <= IcpInDiChsCnt; k++, i++)
		{
			IcpInDiChnVals[i] = Temp & $01;
			Temp = Temp >> 1;
			
			/////////////////////////////////////////////////////////
			IF (IcpInDiChnVals[i] == 1) SEND_STRING AmxConsole, "'pushed channel - ', ITOA(i)";
			/////////////////////////////////////////////////////////
		}
	}
}

DEFINE_CALL 'ParseIcpInRespon_An' (CHAR Respon[])
{
	INTEGER i;
	INTEGER j;
	INTEGER ResponLen;
	ResponLen = LENGTH_ARRAY(Respon);
	
	FOR (i = 1, j = 10; i <= IcpInAnChsCnt && j <= ResponLen; i++, j = j + 2)
	IcpInAnChnVals[i] = (Respon[j] << 8) + Respon[j + 1];
}



//These functions set the values of digital and analog channels for ICP output devices.

DEFINE_CALL 'SetIcpOutDiChnVal' (INTEGER ChnIndx, INTEGER ChnVal)
{
	INTEGER Temp;
	Temp = ChnIndx - 1;
	// SEND_STRING AmxConsole, "'Call SetIcpOutDiChnVal is not executed yet!'"
	SEND_STRING IcpOut, "$00, $00, $00, $00, $00, $06, $01, $05, Temp >> 8, Temp, $FF * ChnVal, $00";
	SEND_STRING AmxConsole, "'Call SetIcpOutDiChnVal is executed!'"
}


DEFINE_CALL 'SetIcpOutAnChnVal' (INTEGER ChnIndx, INTEGER ChnVal)
{
	INTEGER Temp;
	Temp = ChnIndx - 1;
	
	SEND_STRING IcpOut, "$00, $00, $00, $00, $00, $06, $01, $06, Temp >> 8, Temp, ChnVal >> 8, ChnVal";
}

DEFINE_CALL 'SetIcpOutMultDiChnVal' (INTEGER BitCount, INTEGER ChnVal[])
{
	// SEND_STRING AmxConsole, "'Call SetIcpOutMultDiChnVal is not executed yet!'"
	SEND_STRING AmxConsole, "$00, $00, $00, $00, $00, $06, $01, $0F, $00, $00, BitCount >> 8, BitCount, (BitCount + 7)/8, ChnVal[1] >> 8, ChnVal[1], ChnVal[2] >> 8"
	SEND_STRING IcpOut, "$00, $00, $00, $00, $00, $06, $01, $0F, $00, $00, BitCount >> 8, BitCount, (BitCount + 7)/8, ChnVal[1] >> 8, ChnVal[1], ChnVal[2] >> 8"
	SEND_STRING AmxConsole, "'Call SetIcpOutMultDiChnVal is executed!'"
}

//This section initializes timelines for ICP connection and request events.


DEFINE_START

TIMELINE_CREATE (TimeLineId_IcpConn, TimeLineArr_IcpConn, 1, TIMELINE_ABSOLUTE, TIMELINE_REPEAT);

TIMELINE_CREATE (TimeLineId_IcpOutRqst, TimeLineArr_IcpOutRqst, 1, TIMELINE_ABSOLUTE, TIMELINE_REPEAT);
TIMELINE_CREATE (TimeLineId_IcpInRqst, TimeLineArr_IcpInRqst, 1, TIMELINE_ABSOLUTE, TIMELINE_REPEAT);


DEFINE_EVENT

TIMELINE_EVENT[TimeLineId_IcpConn]
{
	IF (IcpOutOnline == false) IP_CLIENT_OPEN (IcpOut.Port, IcpOutIp, IcpOutPort, IP_TCP);
	
	IF (IcpInOnline == false) IP_CLIENT_OPEN (IcpIn.Port, IcpInIp, IcpInPort, IP_TCP);
}


TIMELINE_EVENT[TimeLineId_IcpOutRqst]
{
	CALL 'GetIcpOutDiChnVals';
	CALL 'GetIcpOutAnChnVals';
}


TIMELINE_EVENT[TimeLineId_IcpInRqst]
{
	CALL 'GetIcpInDiChnVals';
	CALL 'GetIcpInAnChnVals';
}


DATA_EVENT[IcpOut]
{
	ONLINE:
	{
		IcpOutOnline = true;
	}
	
	OFFLINE:
	{
		IcpOutOnline = false;
	}
	
	STRING:
	{
		SWITCH (Data.Text[8])
		{
			CASE $01:
			{
				CALL 'ParseIcpOutRespon_Di' (Data.Text);
				
				CALL 'TpRelaysRefresh';
			}
			CASE $03:
			{
				CALL 'ParseIcpOutRespon_An' (Data.Text);
				
				//CALL 'DamperRefresh';
			}
		}
	}
}


DATA_EVENT[IcpIn]
{
	ONLINE:
	{
		IcpInOnline = true;
	}
	
	OFFLINE:
	{
		IcpInOnline = false;
	}
	
	STRING:
	{
		SWITCH (Data.Text[8])
		{
			CASE $02:
			{
				CALL 'ParseIcpInRespon_Di' (Data.Text);
				
				CALL 'CheckRelayWallBtns';
				CALL 'CheckDimWallBtns';
				//CALL 'CheckBlindWallBtns';
				//CALL 'CheckMediaWallBtns';
				//CALL 'CheckIntcomCallBtns';
				//CALL 'CheckLeakSnsrs';
			}
			CASE $04:
			{
				CALL 'ParseIcpInRespon_An' (Data.Text);
			}
		}
	}
}
