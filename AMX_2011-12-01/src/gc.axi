//Global Cache (GC) device.
PROGRAM_NAME = 'gc'


DEFINE_CONSTANT

LONG TimeLineArr_GcConn[1] = {200};

LONG TimeLineArr_GcDisconn[1] = {180000};


DEFINE_VARIABLE

VOLATILE INTEGER GcOnline;


DEFINE_CALL 'SendGcIrCmd' (INTEGER Conn, INTEGER Hndl, INTEGER Freq, INTEGER Rpt, INTEGER Ofst, CHAR Cmd[])
{
    SEND_STRING Gc, "'sendir,4:', ITOA(Conn), ',', ITOA(Hndl), ',', ITOA(Freq), ',', ITOA(Rpt), ',', ITOA(Ofst), ',', Cmd, $0D";
}


DEFINE_START

TIMELINE_CREATE (TimeLineId_GcConn, TimeLineArr_GcConn, 1, TIMELINE_ABSOLUTE, TIMELINE_REPEAT);

TIMELINE_CREATE (TimeLineId_GcDisconn, TimeLineArr_GcDisconn, 1, TIMELINE_ABSOLUTE, TIMELINE_REPEAT);


DEFINE_EVENT

TIMELINE_EVENT[TimeLineId_GcConn]
{
    IF (GcOnline == false) IP_CLIENT_OPEN (Gc.Port, GcIp, GcPort, IP_TCP);
}


TIMELINE_EVENT[TimeLineId_GcDisconn]
{
    IP_CLIENT_CLOSE (Gc.Port);
    GcOnline = false;
}


DATA_EVENT[Intcom]
{
    ONLINE:
    {
	GcOnline = true;
    }
    
    OFFLINE:
    {
	GcOnline = false;
    }
}
