//ventilation or climate control system
PROGRAM_NAME = 'komf'


DEFINE_CONSTANT

INTEGER KomfPwrOn = 1;
INTEGER KomfPwrOff = 0;

INTEGER KomfPwrRegIndx = 10401;
INTEGER KomfVentLvlRegIndx = 10403;
INTEGER KomfSetpntTmprtrRegIndx = 10413;

LONG TimeLineArr_KomfConn[1] = {200};


DEFINE_TYPE

STRUCTURE SKomfStat
{
    INTEGER IsOnline;
    INTEGER IsWork;
    INTEGER VentLvl;
    INTEGER SetpntTmprtr;
}


DEFINE_VARIABLE

VOLATILE SKomfStat KomfStat;


DEFINE_CALL 'GetKomfRegVal' (INTEGER RegIndx)
{
    INTEGER TmpRegIndx;
    TmpRegIndx = RegIndx - 1;
    SEND_STRING Komf, "TmpRegIndx >> 8, TmpRegIndx, $00, $00, $00, $06, $FE, $03, TmpRegIndx >> 8, TmpRegIndx, $00, $01";
}


DEFINE_CALL 'ParseKomfRespon' (CHAR Respon[])
{
    INTEGER RegIndx;
    INTEGER RegVal;
    RegIndx = (Respon[1] << 8) + Respon[2] + 1;
    SWITCH (Respon[8])
    {
	CASE $03: { RegVal = (Respon[10] << 8) + Respon[11]; }
	CASE $06: { RegVal = (Respon[11] << 8) + Respon[12]; }
    }

    SWITCH (RegIndx)
    {
	CASE KomfPwrRegIndx:
	{
	    IF (RegVal == 0) KomfStat.IsWork = false;
	    ELSE KomfStat.IsWork = true;
	}
	CASE KomfVentLvlRegIndx: { KomfStat.VentLvl = RegVal; }
	CASE KomfSetpntTmprtrRegIndx: { KomfStat.SetpntTmprtr = RegVal; }
    }
}


DEFINE_CALL 'SetKomfRegVal' (INTEGER RegIndx, INTEGER RegVal)
{
    INTEGER TmpRegIndx;
    TmpRegIndx = RegIndx - 1;
    SEND_STRING Komf, "TmpRegIndx >> 8, TmpRegIndx, $00, $00, $00, $06, $FE, $06, TmpRegIndx >> 8, TmpRegIndx, RegVal >> 8, RegVal";
}


DEFINE_CALL 'SetKomfPwr' (INTEGER Pwr)
{
    CALL 'SetKomfRegVal' (KomfPwrRegIndx, Pwr);
}


DEFINE_CALL 'SetKomfVentLvl' (INTEGER VentLvl)
{
    IF (VentLvl < 1) VentLvl = 1;
    IF (VentLvl > 3) VentLvl = 3;
    CALL 'SetKomfRegVal' (KomfVentLvlRegIndx, VentLvl);
}


DEFINE_CALL 'SetKomfSetpntTmprtr' (INTEGER SetpntTmprtr)
{
    IF (SetpntTmprtr < 0) SetpntTmprtr = 0;
    IF (SetpntTmprtr > 300) SetpntTmprtr = 300;
    CALL 'SetKomfRegVal' (KomfSetpntTmprtrRegIndx, SetpntTmprtr);
}


DEFINE_START

TIMELINE_CREATE (TimeLineId_KomfConn, TimeLineArr_KomfConn, 1, TIMELINE_ABSOLUTE, TIMELINE_REPEAT);


DEFINE_EVENT

TIMELINE_EVENT[TimeLineId_KomfConn]
{
    IF (KomfStat.IsOnline == false) IP_CLIENT_OPEN (Komf.Port, KomfIp, KomfPort, IP_TCP);
}


DATA_EVENT[Komf]
{
    ONLINE:
    {
	KomfStat.IsOnline = true;

	WAIT (5) { CALL 'GetKomfRegVal' (KomfPwrRegIndx);
	WAIT (5) { CALL 'GetKomfRegVal' (KomfVentLvlRegIndx);
	WAIT (5) { CALL 'GetKomfRegVal' (KomfSetpntTmprtrRegIndx); } } }
    }
    
    OFFLINE:
    {
	KomfStat.IsOnline = false;
    }

    STRING:
    {
	CALL 'ParseKomfRespon' (Data.Text);

	CALL 'KomfPwrRefresh';
	CALL 'KomfVentLvlRefresh';
	CALL 'KomfSetpntTemprtrRefresh';
    }
}
