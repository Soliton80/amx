PROGRAM_NAME = 'main'


DEFINE_DEVICE

//device:port:system_number 

AmxConsole = 0:1:0;

Dim = 5001:1:1;

IcpOut = 0:10:1;
IcpIn = 0:11:1;

// Integ = 0:20:1;

// Intcom = 0:30:1;

// Xbmc = 0:40:1;

// Gc = 0:50:1;

// Komf = 0:60:1;

// Tshb = 0:71:1;
// Humid  = 0:72:1;
// Gsm = 0:73:1;


DEFINE_CONSTANT

CHAR IcpOutIp[] = '192.168.1.152';
CHAR IcpInIp[] = '192.168.1.151';
INTEGER IcpOutPort = 502;
INTEGER IcpInPort = 502;

//integration module for Integra DTR-50.2
CHAR IntegIp[] = '192.168.1.111';
INTEGER IntegPort = 60128;

//intercom system
CHAR IntcomIp[] = '192.168.1.121';
INTEGER IntcomPort = 60000;

//https://kodi.tv/
CHAR XbmcIp[] = '192.168.1.131';
INTEGER XbmcPort = 9090;

//Global Cache
CHAR GcIp[] = '192.168.1.141';
INTEGER GcPort = 4998;

//ventilation or climate control system
CHAR KomfIp[] = '192.168.1.29';
INTEGER KomfPort = 502;

//
CHAR TshbIp[] = "192.168.";
INTEGER TshbPort = 4001;

CHAR GsmIp[] = "192.168.1.232";
//у Сухарева 4003
INTEGER GsmPort = 4001;

INTEGER TimeLineId_GcConn = 1;
INTEGER TimeLineId_GcDisconn = 2;
INTEGER TimeLineId_IcpConn = 3;
INTEGER TimeLineId_IcpOutRqst = 4;
INTEGER TimeLineId_IcpInRqst = 5;
INTEGER TimeLineId_IntcomConn = 6;
INTEGER TimeLineId_IntegConn = 7;
INTEGER TimeLineId_KomfConn = 8;
INTEGER TimeLineId_XbmcConn = 9;
INTEGER TimeLineId_TmprtrRefresh = 10;
INTEGER TimeLineId_TshbConn = 11;


#INCLUDE 'dim';
#INCLUDE 'icp';
// #INCLUDE 'intcom';
// #INCLUDE 'integ';
// #INCLUDE 'xbmc';
// #INCLUDE 'gc';
// #INCLUDE 'tv';
// #INCLUDE 'sat';
// #INCLUDE 'komf';
#INCLUDE 'dimctrl';
#INCLUDE 'relayctrl';
#INCLUDE 'switch';
// #INCLUDE 'http';
// #INCLUDE 'json';
#INCLUDE 'http';
// #INCLUDE 'blindctrl';
// #INCLUDE 'leakctrl';
// #INCLUDE 'mediactrl';
// #INCLUDE 'mediawallctrl';
// #INCLUDE 'mediawndctrl';
// #INCLUDE 'tvwndctrl';
// #INCLUDE 'satwndctrl';
// #INCLUDE 'xbmcwndctrl';
// #INCLUDE 'audiowndctrl';
// #INCLUDE 'fmwndctrl';
// #INCLUDE 'climtctrl';
// #INCLUDE 'Scenes';
// #INCLUDE 'Gsm'


