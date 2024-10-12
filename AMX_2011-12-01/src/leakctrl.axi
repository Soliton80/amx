PROGRAM_NAME = 'leakctrl'


DEFINE_CONSTANT

INTEGER LeakSnsrsCnt = 1;


DEFINE_TYPE

STRUCTURE SLeakSnsr
{
    INTEGER IcpInChnIndx;
    INTEGER Val;
}


STRUCTURE SLeakVlv
{
    SLeakSnsr LeakSnsrs[LeakSnsrsCnt];
    INTEGER RelayIcpOutChnIndx;
}


DEFINE_VARIABLE

DEVCHAN TpLeakChns[] = {{Tp1Leak, 1},
			{Tp2Leak, 1},
			{Tp3Leak, 1}};

VOLATILE SLeakVlv LeakVlv;

VOLATILE INTEGER IsLeak;


DEFINE_CALL 'CheckLeakSnsrs'
{
    INTEGER i;
    FOR (i = 1; i <= LeakSnsrsCnt; i++)
    {
	IF (IcpInDiChnVals[LeakVlv.LeakSnsrs[i].IcpInChnIndx] == 1)
	{
	    LeakVlv.LeakSnsrs[i].Val = 1;
	    
	    IF (IsLeak == false)
	    {
		IsLeak = true;
		
		SEND_COMMAND TpLeak, 'PPON-Mask';
		SEND_COMMAND TpLeak, 'PPON-LeakWarnMsg';
		
		CALL 'SetIcpOutDiChnVal' (LeakVlv.RelayIcpOutChnIndx, 1);
	    }
	}
	
	[TpLeak, i] = LeakVlv.LeakSnsrs[i].Val;
    }
}


DEFINE_START

LeakVlv.RelayIcpOutChnIndx = 29;
LeakVlv.LeakSnsrs[1].IcpInChnIndx = 162;


DEFINE_EVENT

BUTTON_EVENT[TpLeakChns]
{
    RELEASE:
    {
	IF ([Button.Input.Device, Button.Input.Channel] != 0)
	{
	    SEND_COMMAND Button.Input.Device, 'PPON-Mask';
	    SEND_COMMAND Button.Input.Device, 'PPON-LeakSolvedQstnMsg';
	}
    }
}


BUTTON_EVENT[TpLeak, 11]
{
    RELEASE:
    {
	SEND_COMMAND TpLeak, 'PPOF-LeakWarnMsg';
	SEND_COMMAND TpLeak, 'PPOF-Mask';
    }
}


BUTTON_EVENT[TpLeak, 12]
{
    RELEASE:
    {
	INTEGER i;
	INTEGER IsLeakTmp;
	IsLeakTmp = false;
	FOR (i = 1; i <= LeakSnsrsCnt && IsLeakTmp == false; i++)
	    IF (IcpInDiChnVals[LeakVlv.LeakSnsrs[i].IcpInChnIndx] == 1)
		IsLeakTmp = true;

	IF (IsLeakTmp == false)
	{
	    IsLeak = false;
	    
	    FOR (i = 1; i <= LeakSnsrsCnt; i++)
		LeakVlv.LeakSnsrs[i].Val = 0;
	    
	    CALL 'SetIcpOutDiChnVal' (LeakVlv.RelayIcpOutChnIndx, 0);
	}

	SEND_COMMAND Button.Input.Device, 'PPOF-LeakSolvedQstnMsg';
	SEND_COMMAND Button.Input.Device, 'PPOF-Mask';
    }
}


BUTTON_EVENT[TpLeak, 13]
{
    RELEASE:
    {
	SEND_COMMAND Button.Input.Device, 'PPOF-LeakSolvedQstnMsg';
	SEND_COMMAND Button.Input.Device, 'PPOF-Mask';
    }
}