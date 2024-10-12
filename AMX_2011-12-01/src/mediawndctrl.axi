PROGRAM_NAME = 'mediawndctrl'


DEFINE_VARIABLE

DEVCHAN TpMediaWndZnStatChns[] = {{Tp1MediaWnd, 1}, {Tp1MediaWnd, 2}, {Tp1MediaWnd, 3}, {Tp1MediaWnd, 4}, {Tp1MediaWnd, 5}, {Tp1MediaWnd, 6},
				  {Tp2MediaWnd, 1}, {Tp2MediaWnd, 2}, {Tp2MediaWnd, 3}, {Tp2MediaWnd, 4}, {Tp2MediaWnd, 5}, {Tp2MediaWnd, 6},
				  {Tp3MediaWnd, 1}, {Tp3MediaWnd, 2}, {Tp3MediaWnd, 3}, {Tp3MediaWnd, 4}, {Tp3MediaWnd, 5}, {Tp3MediaWnd, 6}};

DEVCHAN TpMediaWndZnsChns[] = {{Tp1MediaWnd, 11}, {Tp1MediaWnd, 12}, {Tp1MediaWnd, 13},
			       {Tp2MediaWnd, 11}, {Tp2MediaWnd, 12}, {Tp2MediaWnd, 13},
			       {Tp3MediaWnd, 11}, {Tp3MediaWnd, 12}, {Tp3MediaWnd, 13}};

VOLATILE INTEGER TpMediaZnAssocs[TpsCnt];


DEFINE_CALL 'MediaWndShow' (DEV Tp, INTEGER ZnIndx)
{
    SEND_COMMAND Tp, 'PPON-MediaWnd';
    CALL 'MediaWndZnShow' (Tp, ZnIndx);    
}


DEFINE_CALL 'MediaWndZnShow' (DEV Tp, INTEGER ZnIndx)
{
    INTEGER TpNum;
    TpNum = Tp.Number - 10000;
    TpMediaZnAssocs[TpNum] = ZnIndx;
    ON [TpMediaWnd[TpNum], TpMediaZnAssocs[TpNum] + 10];
    CALL 'MediaWndZnStatShow' (Tp);
    CALL 'MediaVolLvlShow' (Tp);
}


DEFINE_CALL 'MediaWndZnStatShow' (DEV Tp)
{
    INTEGER TpNum;
    TpNum = Tp.Number - 10000;
    ON [TpMediaWnd[TpNum], MediaZnStats[TpMediaZnAssocs[TpNum]]];
    CALL 'MediaWndZnStatCntntCls' (Tp);
    CALL 'MediaWndZnStatCntntShow' (Tp);
}


DEFINE_CALL 'MediaWndZnStatCntntShow' (DEV Tp)
{
    SWITCH (MediaZnStats[TpMediaZnAssocs[Tp.Number - 10000]])
    {
	CASE TvZnStat: { CALL 'TvWndShow' (Tp); }
	CASE SatZnStat: { CALL 'SatWndShow' (Tp); }
	CASE XbmcZnStat: { CALL 'XbmcWndShow' (Tp); }
	CASE AudioZnStat: { CALL 'AudioWndShow' (Tp); }
	CASE FmZnStat: { CALL 'FmWndShow' (Tp); }
    }
}


DEFINE_CALL 'MediaWndZnStatCntntCls' (DEV Tp)
{
    CALL 'TvWndCls' (Tp);
    CALL 'SatWndCls' (Tp);
    CALL 'XbmcWndCls' (Tp);
    CALL 'AudioWndCls' (Tp);
    CALL 'FmWndCls' (Tp);
}


DEFINE_CALL 'MediaWndZnStatRefresh' (INTEGER ZnIndx)
{
    INTEGER i;
    FOR (i = 1; i <= TpsCnt; i++)
	IF (TpMediaZnAssocs[i] == ZnIndx)
	    CALL 'MediaWndZnStatShow' (TpMediaWnd[i]);
}


DEFINE_CALL 'MediaVolLvlShow' (DEV Tp)
{
    INTEGER TpNum;
    TpNum = Tp.Number - 10000;
    SEND_LEVEL TpMediaWnd[TpNum], 30, IntegStat.ZnStats[TpMediaZnAssocs[TpNum]].Vol;
}


DEFINE_CALL 'MediaVolLvlRefresh' (INTEGER ZnIndx)
{
    INTEGER i;
    FOR (i = 1; i <= TpsCnt; i++)
	IF (TpMediaZnAssocs[i] == ZnIndx)
	    CALL 'MediaVolLvlShow' (TpMediaWnd[i]);
}


DEFINE_MUTUALLY_EXCLUSIVE

([Tp1MediaWnd, 1], [Tp1MediaWnd, 2], [Tp1MediaWnd, 3], [Tp1MediaWnd, 4], [Tp1MediaWnd, 5], [Tp1MediaWnd, 6])
([Tp2MediaWnd, 1], [Tp2MediaWnd, 2], [Tp2MediaWnd, 3], [Tp2MediaWnd, 4], [Tp2MediaWnd, 5], [Tp2MediaWnd, 6])
([Tp3MediaWnd, 1], [Tp3MediaWnd, 2], [Tp3MediaWnd, 3], [Tp3MediaWnd, 4], [Tp3MediaWnd, 5], [Tp3MediaWnd, 6])

([Tp1MediaWnd, 11], [Tp1MediaWnd, 12], [Tp1MediaWnd, 13])
([Tp2MediaWnd, 11], [Tp2MediaWnd, 12], [Tp2MediaWnd, 13])
([Tp3MediaWnd, 11], [Tp3MediaWnd, 12], [Tp3MediaWnd, 13])


DEFINE_EVENT

DATA_EVENT[TpPgs]
{
    OFFLINE:
    {
	TpMediaZnAssocs[Data.Device.Number - 10000] = 0;
    }
}


BUTTON_EVENT[TpMediaWndZnStatChns]
{
    RELEASE:
    {
	CALL 'SetMediaZnStat' (Button.Input.Channel, TpMediaZnAssocs[Button.Input.Device.Number - 10000]);
    }
}


BUTTON_EVENT[TpMediaWndZnsChns]
{
    RELEASE:
    {
	CALL 'MediaWndZnShow' (Button.Input.Device, Button.Input.Channel - 10);
    }
}


BUTTON_EVENT[TpMediaWnd, 20]
{
    RELEASE:
    {
	CALL 'MediaWndZnStatCntntCls' (Button.Input.Device);
	SEND_COMMAND Button.Input.Device, 'PPOF-MediaWnd';
	TpMediaZnAssocs[Button.Input.Device.Number - 10000] = 0;
    }
}


BUTTON_EVENT[TpMediaWnd, 31]
{
    HOLD [2, REPEAT]:
    {
	INTEGER ZnIndx;
	ZnIndx = TpMediaZnAssocs[Button.Input.Device.Number - 10000];
	IF (MediaZnStats[ZnIndx] != NullZnStat)
	    CALL 'ChangeIntegVol' (ZnIndx, IntegVolDown);
    }
}


BUTTON_EVENT[TpMediaWnd, 32]
{
    HOLD [2, REPEAT]:
    {
	INTEGER ZnIndx;
	ZnIndx = TpMediaZnAssocs[Button.Input.Device.Number - 10000];
	IF (MediaZnStats[ZnIndx] != NullZnStat)
	    CALL 'ChangeIntegVol' (ZnIndx, IntegVolUp);
    }
}