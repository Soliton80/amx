PROGRAM_NAME = 'main'


DEFINE_DEVICE

//device:port:system_number 

Tp1Pgs = 10001:10:1;
Tp2Pgs = 10002:10:1;
Tp3Pgs = 10003:10:1;

Tp1Dims = 10001:20:1;
Tp2Dims = 10002:20:1;
Tp3Dims = 10003:20:1;

Tp1Relays = 10001:30:1;
Tp2Relays = 10002:30:1;
Tp3Relays = 10003:30:1;

Tp1Blinds = 10001:40:1;
Tp2Blinds = 10002:40:1;
Tp3Blinds = 10003:40:1;

Tp1Leak = 10001:50:1;
Tp2Leak = 10002:50:1;
Tp3Leak = 10003:50:1;

Tp1Media = 10001:60:1;
Tp2Media = 10002:60:1;
Tp3Media = 10003:60:1;

Tp1MediaWnd = 10001:61:1;
Tp2MediaWnd = 10002:61:1;
Tp3MediaWnd = 10003:61:1;

Tp1TvWnd = 10001:62:1;
Tp2TvWnd = 10002:62:1;
Tp3TvWnd = 10003:62:1;

Tp1SatWnd = 10001:63:1;
Tp2SatWnd = 10002:63:1;
Tp3SatWnd = 10003:63:1;

Tp1XbmcWnd = 10001:64:1;
Tp2XbmcWnd = 10002:64:1;
Tp3XbmcWnd = 10003:64:1;

Tp1AudioWnd = 10001:65:1;
Tp2AudioWnd = 10002:65:1;
Tp3AudioWnd = 10003:65:1;

Tp1FmWnd = 10001:66:1;
Tp2FmWnd = 10002:66:1;
Tp3FmWnd = 10003:66:1;

Tp1Climt = 10001:70:1;
Tp2Climt = 10002:70:1;
Tp3Climt = 10003:70:1;

Tp1Scn	= 10001:80:1;
Tp2Scn	= 10002:80:1;
Tp3Scn	= 10003:80:1;

Tp1Gsm = 10001:90:1;
Tp2Gsm = 10002:90:1;
Tp3Gsm = 10003:90:1;


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

INTEGER TpsCnt = 3;

CHAR RoomNames[][20] = {'Index', 'LivingRoom', 'Kitchen', 'Bedroom', 'ChildRoom', 'Cabinet', 'Bathroom', 'Hall'};

CHAR IcpOutIp[] = '192.168.1.102';
CHAR IcpInIp[] = '192.168.1.101';
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


DEFINE_TYPE

STRUCTURE STpStat
{
    INTEGER TpOnline;
    INTEGER CurrPg;
}


DEFINE_VARIABLE

DEVCHAN TpPgChns[] = {{Tp1Pgs, 1}, {Tp1Pgs, 2}, {Tp1Pgs, 3}, {Tp1Pgs, 4}, {Tp1Pgs, 5}, {Tp1Pgs, 6}, {Tp1Pgs, 7}, {Tp1Pgs, 8},
		      {Tp2Pgs, 1}, {Tp2Pgs, 2}, {Tp2Pgs, 3}, {Tp2Pgs, 4}, {Tp2Pgs, 5}, {Tp2Pgs, 6}, {Tp2Pgs, 7}, {Tp2Pgs, 8},
		      {Tp3Pgs, 1}, {Tp3Pgs, 2}, {Tp3Pgs, 3}, {Tp3Pgs, 4}, {Tp3Pgs, 5}, {Tp3Pgs, 6}, {Tp3Pgs, 7}, {Tp3Pgs, 8}};

DEV TpPgs[] = {Tp1Pgs, Tp2Pgs, Tp3Pgs};
DEV TpDims[] = {Tp1Dims, Tp2Dims, Tp3Dims};
DEV TpRelays[] = {Tp1Relays, Tp2Relays, Tp3Relays};
DEV TpBlinds[] = {Tp1Blinds, Tp2Blinds, Tp3Blinds};
DEV TpLeak[] = {Tp1Leak, Tp2Leak, Tp3Leak};
DEV TpMedia[] = {Tp1Media, Tp2Media, Tp3Media};
DEV TpMediaWnd[] = {Tp1MediaWnd, Tp2MediaWnd, Tp3MediaWnd};
DEV TpTvWnd[] = {Tp1TvWnd, Tp2TvWnd, Tp3TvWnd};
DEV TpSatWnd[] = {Tp1SatWnd, Tp2SatWnd, Tp3SatWnd};
DEV TpXbmcWnd[] = {Tp1XbmcWnd, Tp2XbmcWnd, Tp3XbmcWnd};
DEV TpAudioWnd[] = {Tp1AudioWnd, Tp2AudioWnd, Tp3AudioWnd};
DEV TpFmWnd[] = {Tp1FmWnd, Tp2FmWnd, Tp3FmWnd};
DEV TpClimt[] = {Tp1Climt, Tp2Climt, Tp3Climt};
DEV TpScn[] = {Tp1Scn, Tp2Scn, Tp3Scn};
DEV TpGsm[] = {Tp1Gsm, Tp2Gsm, Tp3Gsm};

VOLATILE STpStat TpStats[TpsCnt];


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
//#INCLUDE 'Gsm'


DEFINE_MUTUALLY_EXCLUSIVE

([Tp1Pgs, 1], [Tp1Pgs, 2], [Tp1Pgs, 3], [Tp1Pgs, 4], [Tp1Pgs, 5], [Tp1Pgs, 6], [Tp1Pgs, 7], [Tp1Pgs, 8])
([Tp2Pgs, 1], [Tp2Pgs, 2], [Tp2Pgs, 3], [Tp2Pgs, 4], [Tp2Pgs, 5], [Tp2Pgs, 6], [Tp2Pgs, 7], [Tp2Pgs, 8])
([Tp3Pgs, 1], [Tp3Pgs, 2], [Tp3Pgs, 3], [Tp3Pgs, 4], [Tp3Pgs, 5], [Tp3Pgs, 6], [Tp3Pgs, 7], [Tp3Pgs, 8])


DEFINE_START

TpStats[1].CurrPg = 1;
TpStats[2].CurrPg = 1;
TpStats[3].CurrPg = 1;


