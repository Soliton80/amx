PROGRAM_NAME = 'xbmcwndctrl'


DEFINE_CONSTANT

INTEGER TpXbmcCtrlBtnUp = 2;
INTEGER TpXbmcCtrlBtnDown = 4;
INTEGER TpXbmcCtrlBtnLeft = 1;
INTEGER TpXbmcCtrlBtnRight = 3;
INTEGER TpXbmcCtrlBtnSelect = 5;
INTEGER TpXbmcCtrlBtnBack = 6;
INTEGER TpXbmcCtrlBtnHome = 7;


DEFINE_VARIABLE

DEVCHAN TpXbmcCtrlBtnChns[] = {{Tp1XbmcWnd, 1}, {Tp1XbmcWnd, 2}, {Tp1XbmcWnd, 3}, {Tp1XbmcWnd, 4}, {Tp1XbmcWnd, 5}, {Tp1XbmcWnd, 6}, {Tp1XbmcWnd, 7},
			       {Tp2XbmcWnd, 1}, {Tp2XbmcWnd, 2}, {Tp2XbmcWnd, 3}, {Tp2XbmcWnd, 4}, {Tp2XbmcWnd, 5}, {Tp2XbmcWnd, 6}, {Tp2XbmcWnd, 7},
			       {Tp3XbmcWnd, 1}, {Tp3XbmcWnd, 2}, {Tp3XbmcWnd, 3}, {Tp3XbmcWnd, 4}, {Tp3XbmcWnd, 5}, {Tp3XbmcWnd, 6}, {Tp3XbmcWnd, 7}};


DEFINE_CALL 'XbmcWndShow' (DEV Tp)
{
    SEND_COMMAND Tp, 'PPON-XbmcWnd';
}


DEFINE_CALL 'XbmcWndCls' (DEV Tp)
{
    SEND_COMMAND Tp, 'PPOF-XbmcWnd';
}


DEFINE_EVENT

BUTTON_EVENT[TpXbmcCtrlBtnChns]
{
    RELEASE:
    {
	SWITCH (Button.Input.Channel)
	{
	    CASE TpXbmcCtrlBtnUp: { CALL 'XbmcInputUp'; }
	    CASE TpXbmcCtrlBtnDown: { CALL 'XbmcInputDown'; }
	    CASE TpXbmcCtrlBtnLeft: { CALL 'XbmcInputLeft'; }
	    CASE TpXbmcCtrlBtnRight: { CALL 'XbmcInputRight'; }
	    CASE TpXbmcCtrlBtnSelect: { CALL 'XbmcInputSelect'; }
	    CASE TpXbmcCtrlBtnBack: { CALL 'XbmcInputBack'; }
	    CASE TpXbmcCtrlBtnHome: { CALL 'XbmcInputHome'; }
	}
    }
}