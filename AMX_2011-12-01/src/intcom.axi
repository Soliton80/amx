PROGRAM_NAME = 'intcom'


DEFINE_CONSTANT

INTEGER IntcomZnCnt = 1;

INTEGER OpnWaitTime = 30;

LONG TimeLineArr_IntcomConn[1] = {200};


DEFINE_TYPE

STRUCTURE SIntcomZn
{
    INTEGER CallBtnIcpInChnIndx;
    INTEGER CallBtnLstStat;
    INTEGER OpnRelayIcpOutChnIndx;
}


DEFINE_VARIABLE

VOLATILE SIntcomZn IntcomZns[IntcomZnCnt];

VOLATILE INTEGER IntcomOnline;

VOLATILE INTEGER SavedOpnRelayIcpOutChnIndx;


DEFINE_CALL 'CheckIntcomCallBtns'
{
    INTEGER i;
    
    FOR (i = 1; i <= IntcomZnCnt; i++)
    {
	IF (IntcomZns[i].CallBtnLstStat == 1 && IcpInDiChnVals[IntcomZns[i].CallBtnIcpInChnIndx] == 0)
	    CALL 'PressIntcomCallBtn' (i);
	    
	IntcomZns[i].CallBtnLstStat = IcpInDiChnVals[IntcomZns[i].CallBtnIcpInChnIndx];
    }
}


DEFINE_CALL 'ParseIntcomRespon' (CHAR Respon[])
{
    INTEGER OpnRelayIcpOutChnIndx;
    OpnRelayIcpOutChnIndx = 0;
    
    IF (SavedOpnRelayIcpOutChnIndx == 0)
    {
	IF (FIND_STRING(Respon, 'POB', 1) > 0)
	    OpnRelayIcpOutChnIndx =
		IntcomZns[ATOI(MID_STRING(Respon, LENGTH_STRING(Respon) - 2, 2)) + 1].OpnRelayIcpOutChnIndx;
    
	IF (OpnRelayIcpOutChnIndx > 0)
	{
	    SavedOpnRelayIcpOutChnIndx = OpnRelayIcpOutChnIndx;

	    CALL 'SetIcpOutDiChnVal' (SavedOpnRelayIcpOutChnIndx, 1);
	    
	    WAIT (OpnWaitTime)
	    {
		CALL 'SetIcpOutDiChnVal' (SavedOpnRelayIcpOutChnIndx, 0);
		SavedOpnRelayIcpOutChnIndx = 0;
	    }
	}
    }
}


DEFINE_CALL 'PressIntcomCallBtn' (INTEGER ZnIndx)
{
    SEND_STRING Intcom, "'INTC', 'CBP', FORMAT('%02d', ZnIndx - 1), $0D";
}


DEFINE_START

TIMELINE_CREATE (TimeLineId_IntcomConn, TimeLineArr_IntcomConn, 1, TIMELINE_ABSOLUTE, TIMELINE_REPEAT);

IntcomZns[1].CallBtnIcpInChnIndx = 161; IntcomZns[1].OpnRelayIcpOutChnIndx = 0;  // Лестничная клетка


DEFINE_EVENT

TIMELINE_EVENT[TimeLineId_IntcomConn]
{
    IF (IntcomOnline == false) IP_CLIENT_OPEN (Intcom.Port, IntcomIp, IntcomPort, IP_TCP);
}


DATA_EVENT[Intcom]
{
    ONLINE:
    {
	IntcomOnline = true;
    }
    
    OFFLINE:
    {
	IntcomOnline = false;
    }

    STRING:
    {
	CALL 'ParseIntcomRespon' (Data.Text);
    }
}
