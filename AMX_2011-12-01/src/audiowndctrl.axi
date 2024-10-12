PROGRAM_NAME = 'audiowndctrl'


DEFINE_CONSTANT

INTEGER TpAudioCtrlBtnPlayPause = 1;
INTEGER TpAudioCtrlBtnSkipPrevious = 2;
INTEGER TpAudioCtrlBtnSkipNext = 3;


DEFINE_VARIABLE

DEVCHAN TpAudioCtrlBtnChns[] = {{Tp1AudioWnd, 1}, {Tp1AudioWnd, 2}, {Tp1AudioWnd, 3},
				{Tp2AudioWnd, 1}, {Tp2AudioWnd, 2}, {Tp2AudioWnd, 3},
				{Tp3AudioWnd, 1}, {Tp3AudioWnd, 2}, {Tp3AudioWnd, 3}};


DEFINE_CALL 'AudioWndShow' (DEV Tp)
{
    SEND_COMMAND Tp, 'PPON-AudioWnd';
    CALL 'AudioWndPlayPauseBtnRefresh';
}


DEFINE_CALL 'AudioWndCls' (DEV Tp)
{
    SEND_COMMAND Tp, 'PPOF-AudioWnd';
}


DEFINE_CALL 'AudioWndPlayPauseBtnRefresh'
{
    IF (XbmcStat.AudioPlay == true) ON [TpAudioWnd, TpAudioCtrlBtnPlayPause];
    ELSE  OFF [TpAudioWnd, TpAudioCtrlBtnPlayPause];
}


DEFINE_EVENT

BUTTON_EVENT[TpAudioCtrlBtnChns]
{
    RELEASE:
    {
	SWITCH (Button.Input.Channel)
	{
	    CASE TpAudioCtrlBtnPlayPause: { CALL 'XbmcAudioPlayerPlayPause'; }
	    CASE TpAudioCtrlBtnSkipPrevious: { CALL 'XbmcAudioPlayerSkipPrevious'; }
	    CASE TpAudioCtrlBtnSkipNext: { CALL 'XbmcAudioPlayerSkipNext'; }
	}
    }
}