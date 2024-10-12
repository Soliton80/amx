PROGRAM_NAME='toshiba'

DEFINE_TYPE

STRUCTURE STshbStat
{
    INTEGER TshbON; //0 - off, 1 - ON
    INTEGER Mode;
    INTEGER FanSpeed;
    INTEGER Louver;  
    INTEGER Temperature;
}
DEFINE_VARIABLE

VOLATILE INTEGER TshbOnline;

DEFINE_CALL 'GetTshbDiIn'

DEFINE_START

TIMELINE_CREATE (TimeLineId_TshbConn, TimeLineArr_TshbConn, 1, TIMELINE_ABSOLUTE, TIMELINE_REPEAT);


DEFINE_EVENT

TIMELINE_EVENT[TimeLineId_TshbConn]
{
    IF (TshbOnline == false) IP_CLIENT_OPEN (Tshb.Port, TshbIp, TshbPort, IP_TCP);
}

DATA_EVENT[Tshb]
{
    ONLINE:
    {
	TshbOnline = true;
    }
    
    OFFLINE:
    {
	TshbOnline = false;
    }
}