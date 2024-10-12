//integration module for Integra DTR-50.2
PROGRAM_NAME = 'integ'


DEFINE_CONSTANT

INTEGER IntegPwrOn = 1;
INTEGER IntegPwrOff = 0;

INTEGER IntegVolUp = 1;
INTEGER IntegVolDown = 0;

INTEGER IntegTunFreqUp = 1;
INTEGER IntegTunFreqDown = 0;

INTEGER IntegFmIn = 24;
INTEGER IntegMusicServerIn = 2;
INTEGER IntegSatIn = 1;

INTEGER IntegTunPrstsCnt = 50;

CHAR IntegTunPrsts[][5] = {
'08750',
'08790',
'08830',
'08870',
'08910',
'08950',
'08990',
'09030',
'09080',
'09120',
'09160',
'09200',
'09240',
'09280',
'09320',
'09360',
'09400',
'09440',
'09480',
'09520',
'09560',
'09600',
'09640',
'09680',
'09720',
'09760',
'09800',
'09840',
'09880',
'09920',
'09960',
'10010',
'10050',
'10090',
'10120',
'10170',
'10210',
'10250',
'10300',
'10340',
'10370',
'10420',
'10470',
'10520',
'10570',
'10620',
'10660',
'10700',
'10740',
'10780' };

LONG TimeLineArr_IntegConn[1] = {200};


DEFINE_TYPE

STRUCTURE SIntegZnStat
{
    INTEGER Pwr;
    INTEGER Vol;
    INTEGER In;
}


STRUCTURE SIntegStat
{
    SIntegZnStat ZnStats[3];
    INTEGER IntegOnline;
    CHAR TunFreq[5];
    SINTEGER TunPrst;
}


DEFINE_VARIABLE

VOLATILE SIntegStat IntegStat;


DEFINE_CALL 'GetIntegPwr' (INTEGER ZnIndx)
{
    SWITCH (ZnIndx)
    {
	CASE 1:
	{
	    SEND_STRING Integ, "'ISCP', $00, $00, $00, $10, $00, $00, $00, $0A, $01, $00, $00, $00, '!1', 'PWR', 'QSTN', $0D";
	}
	CASE 2:
	{
	    SEND_STRING Integ, "'ISCP', $00, $00, $00, $10, $00, $00, $00, $0A, $01, $00, $00, $00, '!1', 'ZPW', 'QSTN', $0D";
	}
	CASE 3:
	{
	    SEND_STRING Integ, "'ISCP', $00, $00, $00, $10, $00, $00, $00, $0A, $01, $00, $00, $00, '!1', 'PW3', 'QSTN', $0D";
	}
    }
}


DEFINE_CALL 'GetIntegVol' (INTEGER ZnIndx)
{
    SWITCH (ZnIndx)
    {
	CASE 1:
	{
	    SEND_STRING Integ, "'ISCP', $00, $00, $00, $10, $00, $00, $00, $0A, $01, $00, $00, $00, '!1', 'MVL', 'QSTN', $0D";
	}
	CASE 2:
	{
	    SEND_STRING Integ, "'ISCP', $00, $00, $00, $10, $00, $00, $00, $0A, $01, $00, $00, $00, '!1', 'ZVL', 'QSTN', $0D";
	}
	CASE 3:
	{
	    SEND_STRING Integ, "'ISCP', $00, $00, $00, $10, $00, $00, $00, $0A, $01, $00, $00, $00, '!1', 'VL3', 'QSTN', $0D";
	}
    }
}


DEFINE_CALL 'GetIntegIn' (INTEGER ZnIndx)
{
    SWITCH (ZnIndx)
    {
	CASE 1:
	{
	    SEND_STRING Integ, "'ISCP', $00, $00, $00, $10, $00, $00, $00, $0A, $01, $00, $00, $00, '!1', 'SLI', 'QSTN', $0D";
	}
	CASE 2:
	{
	    SEND_STRING Integ, "'ISCP', $00, $00, $00, $10, $00, $00, $00, $0A, $01, $00, $00, $00, '!1', 'SLZ', 'QSTN', $0D";
	}
	CASE 3:
	{
	    SEND_STRING Integ, "'ISCP', $00, $00, $00, $10, $00, $00, $00, $0A, $01, $00, $00, $00, '!1', 'SL3', 'QSTN', $0D";
	}
    }
}


DEFINE_CALL 'GetIntegTunFreq' (INTEGER ZnIndx)
{
    SWITCH (ZnIndx)
    {
	CASE 1:
	{
	    SEND_STRING Integ, "'ISCP', $00, $00, $00, $10, $00, $00, $00, $0A, $01, $00, $00, $00, '!1', 'TUN', 'QSTN', $0D";
	}
	CASE 2:
	{
	    SEND_STRING Integ, "'ISCP', $00, $00, $00, $10, $00, $00, $00, $0A, $01, $00, $00, $00, '!1', 'TUZ', 'QSTN', $0D";
	}
	CASE 3:
	{
	    SEND_STRING Integ, "'ISCP', $00, $00, $00, $10, $00, $00, $00, $0A, $01, $00, $00, $00, '!1', 'TU3', 'QSTN', $0D";
	}
    }
}


DEFINE_CALL 'ParseIntegRespon' (CHAR Respon[])
{
    IF (FIND_STRING(Respon, 'PWR', 1) > 0)
	IntegStat.ZnStats[1].Pwr = ATOI(MID_STRING(Respon, LENGTH_ARRAY(Respon) - 4, 2));
    ELSE IF (FIND_STRING(Respon, 'ZPW', 1) > 0)
	IntegStat.ZnStats[2].Pwr = ATOI(MID_STRING(Respon, LENGTH_ARRAY(Respon) - 4, 2));
    ELSE IF (FIND_STRING(Respon, 'PW3', 1) > 0)
	IntegStat.ZnStats[3].Pwr = ATOI(MID_STRING(Respon, LENGTH_ARRAY(Respon) - 4, 2));
    
    ELSE IF (FIND_STRING(Respon, 'MVL', 1) > 0)
    {
	IntegStat.ZnStats[1].Vol = HEXTOI(MID_STRING(Respon, LENGTH_ARRAY(Respon) - 4, 2));
	CALL 'MediaVolLvlRefresh' (1);
    }
    ELSE IF (FIND_STRING(Respon, 'ZVL', 1) > 0)
    {
	IntegStat.ZnStats[2].Vol = HEXTOI(MID_STRING(Respon, LENGTH_ARRAY(Respon) - 4, 2));
	CALL 'MediaVolLvlRefresh' (2);
    }
    ELSE IF (FIND_STRING(Respon, 'VL3', 1) > 0)
    {
	IntegStat.ZnStats[3].Vol = HEXTOI(MID_STRING(Respon, LENGTH_ARRAY(Respon) - 4, 2));
	CALL 'MediaVolLvlRefresh' (3);
    }

    ELSE IF (FIND_STRING(Respon, 'SLI', 1) > 0)
	IntegStat.ZnStats[1].In = ATOI(MID_STRING(Respon, LENGTH_ARRAY(Respon) - 4, 2));
    ELSE IF (FIND_STRING(Respon, 'SLZ', 1) > 0)
	IntegStat.ZnStats[2].In = ATOI(MID_STRING(Respon, LENGTH_ARRAY(Respon) - 4, 2));
    ELSE IF (FIND_STRING(Respon, 'SL3', 1) > 0)
	IntegStat.ZnStats[3].In = ATOI(MID_STRING(Respon, LENGTH_ARRAY(Respon) - 4, 2));

    ELSE IF (FIND_STRING(Respon, 'TUN', 1) > 0 ||
	     FIND_STRING(Respon, 'TUZ', 1) > 0 ||
	     FIND_STRING(Respon, 'TU3', 1) > 0)
    {
	IntegStat.TunFreq = MID_STRING(Respon, LENGTH_ARRAY(Respon) - 7, 5);
	CALL 'FmWndTunFreqRefresh';
    }
}


DEFINE_CALL 'SetIntegPwr' (INTEGER ZnIndx, INTEGER Pwr)
{
    SWITCH (ZnIndx)
    {
	CASE 1:
	{
	    SEND_STRING Integ, "'ISCP', $00, $00, $00, $10, $00, $00, $00, $08, $01, $00, $00, $00, '!1', 'PWR', FORMAT('%02d', Pwr), $0D";
	}
	CASE 2:
	{
	    SEND_STRING Integ, "'ISCP', $00, $00, $00, $10, $00, $00, $00, $08, $01, $00, $00, $00, '!1', 'ZPW', FORMAT('%02d', Pwr), $0D";
	}
	CASE 3:
	{
	    SEND_STRING Integ, "'ISCP', $00, $00, $00, $10, $00, $00, $00, $08, $01, $00, $00, $00, '!1', 'PW3', FORMAT('%02d', Pwr), $0D";
	}
    }
}


DEFINE_CALL 'SetIntegVol' (INTEGER ZnIndx, INTEGER Vol)
{
    SWITCH (ZnIndx)
    {
	CASE 1:
	{
	    SEND_STRING Integ, "'ISCP', $00, $00, $00, $10, $00, $00, $00, $08, $01, $00, $00, $00, '!1', 'MVL', FORMAT('%02X', Vol), $0D";
	}
	CASE 2:
	{
	    SEND_STRING Integ, "'ISCP', $00, $00, $00, $10, $00, $00, $00, $08, $01, $00, $00, $00, '!1', 'ZVL', FORMAT('%02X', Vol), $0D";
	}
	CASE 3:
	{
	    SEND_STRING Integ, "'ISCP', $00, $00, $00, $10, $00, $00, $00, $08, $01, $00, $00, $00, '!1', 'VL3', FORMAT('%02X', Vol), $0D";
	}
    }
}


DEFINE_CALL 'ChangeIntegVol' (INTEGER ZnIndx, INTEGER Direction)
{
    SWITCH (ZnIndx)
    {
	CASE 1:
	{
	    IF (Direction == IntegVolUp)
		SEND_STRING Integ, "'ISCP', $00, $00, $00, $10, $00, $00, $00, $08, $01, $00, $00, $00, '!1', 'MVL', 'UP', $0D";
	    ELSE IF (Direction == IntegVolDown)
		SEND_STRING Integ, "'ISCP', $00, $00, $00, $10, $00, $00, $00, $0A, $01, $00, $00, $00, '!1', 'MVL', 'DOWN', $0D";
	}
	CASE 2:
	{
	    IF (Direction == IntegVolUp)
		SEND_STRING Integ, "'ISCP', $00, $00, $00, $10, $00, $00, $00, $08, $01, $00, $00, $00, '!1', 'ZVL', 'UP', $0D";
	    ELSE IF (Direction == IntegVolDown)
		SEND_STRING Integ, "'ISCP', $00, $00, $00, $10, $00, $00, $00, $0A, $01, $00, $00, $00, '!1', 'ZVL', 'DOWN', $0D";
	}
	CASE 3:
	{
	    IF (Direction == IntegVolUp)
		SEND_STRING Integ, "'ISCP', $00, $00, $00, $10, $00, $00, $00, $08, $01, $00, $00, $00, '!1', 'VL3', 'UP', $0D";
	    ELSE IF (Direction == IntegVolDown)
		SEND_STRING Integ, "'ISCP', $00, $00, $00, $10, $00, $00, $00, $0A, $01, $00, $00, $00, '!1', 'VL3', 'DOWN', $0D";
	}
    }
}


DEFINE_CALL 'SetIntegIn' (INTEGER ZnIndx, INTEGER In)
{
    SWITCH (ZnIndx)
    {
	CASE 1:
	{
	    SEND_STRING Integ, "'ISCP', $00, $00, $00, $10, $00, $00, $00, $08, $01, $00, $00, $00, '!1', 'SLI', FORMAT('%02d', In), $0D";
	}
	CASE 2:
	{
	    SEND_STRING Integ, "'ISCP', $00, $00, $00, $10, $00, $00, $00, $08, $01, $00, $00, $00, '!1', 'SLZ', FORMAT('%02d', In), $0D";
	}
	CASE 3:
	{
	    SEND_STRING Integ, "'ISCP', $00, $00, $00, $10, $00, $00, $00, $08, $01, $00, $00, $00, '!1', 'SL3', FORMAT('%02d', In), $0D";
	}
    }
}


DEFINE_CALL 'ChangeIntegTunFreq' (INTEGER ZnIndx, INTEGER Direction)
{
    IntegStat.TunPrst = 0;
    
    CALL 'FmWndTunPrstRefresh';

    SWITCH (ZnIndx)
    {
	CASE 1:
	{
	    IF (Direction == IntegTunFreqUp)
		SEND_STRING Integ, "'ISCP', $00, $00, $00, $10, $00, $00, $00, $08, $01, $00, $00, $00, '!1', 'TUN', 'UP', $0D";
	    ELSE IF (Direction == IntegTunFreqDown)
		SEND_STRING Integ, "'ISCP', $00, $00, $00, $10, $00, $00, $00, $0A, $01, $00, $00, $00, '!1', 'TUN', 'DOWN', $0D";
	}
	CASE 2:
	{
	    IF (Direction == IntegTunFreqUp)
		SEND_STRING Integ, "'ISCP', $00, $00, $00, $10, $00, $00, $00, $08, $01, $00, $00, $00, '!1', 'TUZ', 'UP', $0D";
	    ELSE IF (Direction == IntegTunFreqDown)
		SEND_STRING Integ, "'ISCP', $00, $00, $00, $10, $00, $00, $00, $0A, $01, $00, $00, $00, '!1', 'TUZ', 'DOWN', $0D";
	}
	CASE 3:
	{
	    IF (Direction == IntegTunFreqUp)
		SEND_STRING Integ, "'ISCP', $00, $00, $00, $10, $00, $00, $00, $08, $01, $00, $00, $00, '!1', 'TU3', 'UP', $0D";
	    ELSE IF (Direction == IntegTunFreqDown)
		SEND_STRING Integ, "'ISCP', $00, $00, $00, $10, $00, $00, $00, $0A, $01, $00, $00, $00, '!1', 'TU3', 'DOWN', $0D";
	}
    }
}


DEFINE_CALL 'SetIntegTunPrst' (INTEGER ZnIndx, INTEGER TunPrst)
{
    IntegStat.TunPrst = TunPrst;
    
    CALL 'FmWndTunPrstRefresh';

    SWITCH (ZnIndx)
    {
	CASE 1:
	{
	    SEND_STRING Integ, "'ISCP', $00, $00, $00, $10, $00, $00, $00, $0B, $01, $00, $00, $00, '!1', 'TUN', IntegTunPrsts[TunPrst], $0D";
	}
	CASE 2:
	{
	    SEND_STRING Integ, "'ISCP', $00, $00, $00, $10, $00, $00, $00, $0B, $01, $00, $00, $00, '!1', 'TUZ', IntegTunPrsts[TunPrst], $0D";
	}
	CASE 3:
	{
	    SEND_STRING Integ, "'ISCP', $00, $00, $00, $10, $00, $00, $00, $0B, $01, $00, $00, $00, '!1', 'TU3', IntegTunPrsts[TunPrst], $0D";
	}
    }
}


DEFINE_START

TIMELINE_CREATE (TimeLineId_IntegConn, TimeLineArr_IntegConn, 1, TIMELINE_ABSOLUTE, TIMELINE_REPEAT);


DEFINE_EVENT

TIMELINE_EVENT[TimeLineId_IntegConn]
{
    IF (IntegStat.IntegOnline == false) IP_CLIENT_OPEN (Integ.Port, IntegIp, IntegPort, IP_TCP);
}


DATA_EVENT[Integ]
{
    ONLINE:
    {
	IntegStat.IntegOnline = true;
	
	WAIT (5) { CALL 'GetIntegPwr' (1);
	WAIT (5) { CALL 'GetIntegPwr' (2);
	WAIT (5) { CALL 'GetIntegPwr' (3);
	WAIT (5) { CALL 'GetIntegVol' (1);
	WAIT (5) { CALL 'GetIntegVol' (2);
	WAIT (5) { CALL 'GetIntegVol' (3);
	WAIT (5) { CALL 'GetIntegIn' (1);
	WAIT (5) { CALL 'GetIntegIn' (2);
	WAIT (5) { CALL 'GetIntegIn' (3);
	WAIT (5) { CALL 'GetIntegTunFreq' (1);
	WAIT (5) { CALL 'GetIntegTunFreq' (2);
	WAIT (5) { CALL 'GetIntegTunFreq' (3); } } } } } } } } } } } }
    }
    
    OFFLINE:
    {
	IntegStat.IntegOnline = false;
    }

    STRING:
    {
	CALL 'ParseIntegRespon' (Data.Text);
    }
}
