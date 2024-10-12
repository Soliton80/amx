//control an XBMC (now known as Kodi) media player
PROGRAM_NAME = 'xbmc'


DEFINE_CONSTANT

LONG TimeLineArr_XbmcConn[1] = {200};


DEFINE_TYPE

STRUCTURE SXbmcStat
{
    INTEGER AudioPlay;
    INTEGER XbmcOnline;
}


DEFINE_VARIABLE

VOLATILE SXbmcStat XbmcStat;


DEFINE_CALL 'XbmcAudioPlayerPlayPause'
{
    SEND_STRING Xbmc, '{ "jsonrpc" : "2.0", "method" : "AudioPlayer.PlayPause",  "id" : 1}';
}


DEFINE_CALL 'XbmcAudioPlayerSkipPrevious'
{
    SEND_STRING Xbmc, '{ "jsonrpc" : "2.0", "method" : "AudioPlayer.SkipPrevious",  "id" : 1}';
}


DEFINE_CALL 'XbmcAudioPlayerSkipNext'
{
    SEND_STRING Xbmc, '{ "jsonrpc" : "2.0", "method" : "AudioPlayer.SkipNext",  "id" : 1}';
}


DEFINE_CALL 'XbmcAudioPlayerStop'
{
    SEND_STRING Xbmc, '{ "jsonrpc" : "2.0", "method" : "AudioPlayer.Stop",  "id" : 1}';
}


DEFINE_CALL 'XbmcAudioPlaylistPlay'
{
    SEND_STRING Xbmc, '{ "jsonrpc" : "2.0", "method" : "AudioPlaylist.Play",  "id" : 1}';
}


DEFINE_CALL 'XbmcInputUp'
{
    SEND_STRING Xbmc, '{ "jsonrpc" : "2.0", "method" : "Input.Up",  "id" : 1}';
}


DEFINE_CALL 'XbmcInputDown'
{
    SEND_STRING Xbmc, '{ "jsonrpc" : "2.0", "method" : "Input.Down",  "id" : 1}';
}


DEFINE_CALL 'XbmcInputLeft'
{
    SEND_STRING Xbmc, '{ "jsonrpc" : "2.0", "method" : "Input.Left",  "id" : 1}';
}


DEFINE_CALL 'XbmcInputRight'
{
    SEND_STRING Xbmc, '{ "jsonrpc" : "2.0", "method" : "Input.Right",  "id" : 1}';
}


DEFINE_CALL 'XbmcInputSelect'
{
    SEND_STRING Xbmc, '{ "jsonrpc" : "2.0", "method" : "Input.Select",  "id" : 1}';
}


DEFINE_CALL 'XbmcInputBack'
{
    SEND_STRING Xbmc, '{ "jsonrpc" : "2.0", "method" : "Input.Back",  "id" : 1}';
}


DEFINE_CALL 'XbmcInputHome'
{
    SEND_STRING Xbmc, '{ "jsonrpc" : "2.0", "method" : "Input.Home",  "id" : 1}';
}


DEFINE_CALL 'ParseXbmcRespon' (CHAR Respon[])
{
    IF (FIND_STRING(UPPER_STRING(Respon), UPPER_STRING('Player.OnPlay'), 1) > 0)
    {
	XbmcStat.AudioPlay = true;
	CALL 'AudioWndPlayPauseBtnRefresh';
    }
    ELSE IF (FIND_STRING(UPPER_STRING(Respon), UPPER_STRING('Player.OnPause'), 1) > 0 ||
	     FIND_STRING(UPPER_STRING(Respon), UPPER_STRING('Player.OnStop'), 1) > 0)
    {
	XbmcStat.AudioPlay = false;
	CALL 'AudioWndPlayPauseBtnRefresh';
    }
}


DEFINE_START

TIMELINE_CREATE (TimeLineId_XbmcConn, TimeLineArr_XbmcConn, 1, TIMELINE_ABSOLUTE, TIMELINE_REPEAT);


DEFINE_EVENT

TIMELINE_EVENT[TimeLineId_XbmcConn]
{
    IF (XbmcStat.XbmcOnline == false) IP_CLIENT_OPEN (Xbmc.Port, XbmcIp, XbmcPort, IP_TCP);
}


DATA_EVENT[Xbmc]
{
    ONLINE:
    {
	XbmcStat.XbmcOnline = true;
    }
    
    OFFLINE:
    {
	XbmcStat.XbmcOnline = false;
    }
    
    STRING:
    {
	CALL 'ParseXbmcRespon' (Data.Text);
    }
}
