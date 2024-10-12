PROGRAM_NAME = 'fmwndctrl'


DEFINE_VARIABLE

DEVCHAN TpFmPrstChns[] = {{Tp1FmWnd, 1}, {Tp1FmWnd, 2}, {Tp1FmWnd, 3}, {Tp1FmWnd, 4}, {Tp1FmWnd, 5}, {Tp1FmWnd, 6}, {Tp1FmWnd, 7}, {Tp1FmWnd, 8}, {Tp1FmWnd, 9},  {Tp1FmWnd, 10},
			  {Tp1FmWnd, 11}, {Tp1FmWnd, 12}, {Tp1FmWnd, 13}, {Tp1FmWnd, 14}, {Tp1FmWnd, 15}, {Tp1FmWnd, 16}, {Tp1FmWnd, 17}, {Tp1FmWnd, 18}, {Tp1FmWnd, 19},  {Tp1FmWnd, 20},
			  {Tp1FmWnd, 21}, {Tp1FmWnd, 22}, {Tp1FmWnd, 23}, {Tp1FmWnd, 24}, {Tp1FmWnd, 25}, {Tp1FmWnd, 26}, {Tp1FmWnd, 27}, {Tp1FmWnd, 28}, {Tp1FmWnd, 29},  {Tp1FmWnd, 30},
			  {Tp1FmWnd, 31}, {Tp1FmWnd, 32}, {Tp1FmWnd, 33}, {Tp1FmWnd, 34}, {Tp1FmWnd, 35}, {Tp1FmWnd, 36}, {Tp1FmWnd, 37}, {Tp1FmWnd, 38}, {Tp1FmWnd, 39},  {Tp1FmWnd, 40},
			  {Tp1FmWnd, 41}, {Tp1FmWnd, 42}, {Tp1FmWnd, 43}, {Tp1FmWnd, 44}, {Tp1FmWnd, 45}, {Tp1FmWnd, 46}, {Tp1FmWnd, 47}, {Tp1FmWnd, 48}, {Tp1FmWnd, 49},  {Tp1FmWnd, 50},
			  {Tp2FmWnd, 1}, {Tp2FmWnd, 2}, {Tp2FmWnd, 3}, {Tp2FmWnd, 4}, {Tp2FmWnd, 5}, {Tp2FmWnd, 6}, {Tp2FmWnd, 7}, {Tp2FmWnd, 8}, {Tp2FmWnd, 9},  {Tp2FmWnd, 10},
			  {Tp2FmWnd, 11}, {Tp2FmWnd, 12}, {Tp2FmWnd, 13}, {Tp2FmWnd, 14}, {Tp2FmWnd, 15}, {Tp2FmWnd, 16}, {Tp2FmWnd, 17}, {Tp2FmWnd, 18}, {Tp2FmWnd, 19},  {Tp2FmWnd, 20},
			  {Tp2FmWnd, 21}, {Tp2FmWnd, 22}, {Tp2FmWnd, 23}, {Tp2FmWnd, 24}, {Tp2FmWnd, 25}, {Tp2FmWnd, 26}, {Tp2FmWnd, 27}, {Tp2FmWnd, 28}, {Tp2FmWnd, 29},  {Tp2FmWnd, 30},
			  {Tp2FmWnd, 31}, {Tp2FmWnd, 32}, {Tp2FmWnd, 33}, {Tp2FmWnd, 34}, {Tp2FmWnd, 35}, {Tp2FmWnd, 36}, {Tp2FmWnd, 37}, {Tp2FmWnd, 38}, {Tp2FmWnd, 39},  {Tp2FmWnd, 40},
			  {Tp2FmWnd, 41}, {Tp2FmWnd, 42}, {Tp2FmWnd, 43}, {Tp2FmWnd, 44}, {Tp2FmWnd, 45}, {Tp2FmWnd, 46}, {Tp2FmWnd, 47}, {Tp2FmWnd, 48}, {Tp2FmWnd, 49},  {Tp2FmWnd, 50},
			  {Tp3FmWnd, 1}, {Tp3FmWnd, 2}, {Tp3FmWnd, 3}, {Tp3FmWnd, 4}, {Tp3FmWnd, 5}, {Tp3FmWnd, 6}, {Tp3FmWnd, 7}, {Tp3FmWnd, 8}, {Tp3FmWnd, 9},  {Tp3FmWnd, 10},
			  {Tp3FmWnd, 11}, {Tp3FmWnd, 12}, {Tp3FmWnd, 13}, {Tp3FmWnd, 14}, {Tp3FmWnd, 15}, {Tp3FmWnd, 16}, {Tp3FmWnd, 17}, {Tp3FmWnd, 18}, {Tp3FmWnd, 19},  {Tp3FmWnd, 20},
			  {Tp3FmWnd, 21}, {Tp3FmWnd, 22}, {Tp3FmWnd, 23}, {Tp3FmWnd, 24}, {Tp3FmWnd, 25}, {Tp3FmWnd, 26}, {Tp3FmWnd, 27}, {Tp3FmWnd, 28}, {Tp3FmWnd, 29},  {Tp3FmWnd, 30},
			  {Tp3FmWnd, 31}, {Tp3FmWnd, 32}, {Tp3FmWnd, 33}, {Tp3FmWnd, 34}, {Tp3FmWnd, 35}, {Tp3FmWnd, 36}, {Tp3FmWnd, 37}, {Tp3FmWnd, 38}, {Tp3FmWnd, 39},  {Tp3FmWnd, 40},
			  {Tp3FmWnd, 41}, {Tp3FmWnd, 42}, {Tp3FmWnd, 43}, {Tp3FmWnd, 44}, {Tp3FmWnd, 45}, {Tp3FmWnd, 46}, {Tp3FmWnd, 47}, {Tp3FmWnd, 48}, {Tp3FmWnd, 49},  {Tp3FmWnd, 50}};


DEFINE_CALL 'FmWndShow' (DEV Tp)
{
    SEND_COMMAND Tp, 'PPON-FmWnd';
    CALL 'FmWndCntntShow' (Tp);
}


DEFINE_CALL 'FmWndCls' (DEV Tp)
{
    SEND_COMMAND Tp, 'PPOF-FmWnd';
}


DEFINE_CALL 'FmWndCntntShow' (DEV Tp)
{
    IF (IntegStat.TunPrst != 0) ON [TpFmWnd[Tp.Number - 10000], IntegStat.TunPrst];
    ELSE ON [TpFmWnd[Tp.Number - 10000], 50];
    
    SEND_COMMAND TpFmWnd[Tp.Number - 10000], "'^TXT-110,0,',
	IntegStat.TunFreq[1], IntegStat.TunFreq[2], IntegStat.TunFreq[3], ',',
	IntegStat.TunFreq[4], IntegStat.TunFreq[5]";
}


DEFINE_CALL 'FmWndTunPrstRefresh'
{
    IF (IntegStat.TunPrst != 0) ON [TpFmWnd, IntegStat.TunPrst];
    ELSE ON [TpFmWnd, 50];
}


DEFINE_CALL 'FmWndTunFreqRefresh'
{
    SEND_COMMAND TpFmWnd, "'^TXT-110,0,',
	IntegStat.TunFreq[1], IntegStat.TunFreq[2], IntegStat.TunFreq[3], ',',
	IntegStat.TunFreq[4], IntegStat.TunFreq[5]";
}


DEFINE_MUTUALLY_EXCLUSIVE

([Tp1FmWnd, 1], [Tp1FmWnd, 2], [Tp1FmWnd, 3], [Tp1FmWnd, 4], [Tp1FmWnd, 5], [Tp1FmWnd, 6], [Tp1FmWnd, 7], [Tp1FmWnd, 8], [Tp1FmWnd, 9],  [Tp1FmWnd, 10],
 [Tp1FmWnd, 11], [Tp1FmWnd, 12], [Tp1FmWnd, 13], [Tp1FmWnd, 14], [Tp1FmWnd, 15], [Tp1FmWnd, 16], [Tp1FmWnd, 17], [Tp1FmWnd, 18], [Tp1FmWnd, 19], [Tp1FmWnd, 20],
 [Tp1FmWnd, 21], [Tp1FmWnd, 22], [Tp1FmWnd, 23], [Tp1FmWnd, 24], [Tp1FmWnd, 25], [Tp1FmWnd, 26], [Tp1FmWnd, 27], [Tp1FmWnd, 28], [Tp1FmWnd, 29], [Tp1FmWnd, 30],
 [Tp1FmWnd, 31], [Tp1FmWnd, 32], [Tp1FmWnd, 33], [Tp1FmWnd, 34], [Tp1FmWnd, 35], [Tp1FmWnd, 36], [Tp1FmWnd, 37], [Tp1FmWnd, 38], [Tp1FmWnd, 39], [Tp1FmWnd, 40],
 [Tp1FmWnd, 41], [Tp1FmWnd, 42], [Tp1FmWnd, 43], [Tp1FmWnd, 44], [Tp1FmWnd, 45], [Tp1FmWnd, 46], [Tp1FmWnd, 47], [Tp1FmWnd, 48], [Tp1FmWnd, 49], [Tp1FmWnd, 50])

([Tp2FmWnd, 1], [Tp2FmWnd, 2], [Tp2FmWnd, 3], [Tp2FmWnd, 4], [Tp2FmWnd, 5], [Tp2FmWnd, 6], [Tp2FmWnd, 7], [Tp2FmWnd, 8], [Tp2FmWnd, 9],  [Tp2FmWnd, 10],
 [Tp2FmWnd, 11], [Tp2FmWnd, 12], [Tp2FmWnd, 13], [Tp2FmWnd, 14], [Tp2FmWnd, 15], [Tp2FmWnd, 16], [Tp2FmWnd, 17], [Tp2FmWnd, 18], [Tp2FmWnd, 19], [Tp2FmWnd, 20],
 [Tp2FmWnd, 21], [Tp2FmWnd, 22], [Tp2FmWnd, 23], [Tp2FmWnd, 24], [Tp2FmWnd, 25], [Tp2FmWnd, 26], [Tp2FmWnd, 27], [Tp2FmWnd, 28], [Tp2FmWnd, 29], [Tp2FmWnd, 30],
 [Tp2FmWnd, 31], [Tp2FmWnd, 32], [Tp2FmWnd, 33], [Tp2FmWnd, 34], [Tp2FmWnd, 35], [Tp2FmWnd, 36], [Tp2FmWnd, 37], [Tp2FmWnd, 38], [Tp2FmWnd, 39], [Tp2FmWnd, 40],
 [Tp2FmWnd, 41], [Tp2FmWnd, 42], [Tp2FmWnd, 43], [Tp2FmWnd, 44], [Tp2FmWnd, 45], [Tp2FmWnd, 46], [Tp2FmWnd, 47], [Tp2FmWnd, 48], [Tp2FmWnd, 49], [Tp2FmWnd, 50])

([Tp3FmWnd, 1], [Tp3FmWnd, 2], [Tp3FmWnd, 3], [Tp3FmWnd, 4], [Tp3FmWnd, 5], [Tp3FmWnd, 6], [Tp3FmWnd, 7], [Tp3FmWnd, 8], [Tp3FmWnd, 9],  [Tp3FmWnd, 10],
 [Tp3FmWnd, 11], [Tp3FmWnd, 12], [Tp3FmWnd, 13], [Tp3FmWnd, 14], [Tp3FmWnd, 15], [Tp3FmWnd, 16], [Tp3FmWnd, 17], [Tp3FmWnd, 18], [Tp3FmWnd, 19], [Tp3FmWnd, 20],
 [Tp3FmWnd, 21], [Tp3FmWnd, 22], [Tp3FmWnd, 23], [Tp3FmWnd, 24], [Tp3FmWnd, 25], [Tp3FmWnd, 26], [Tp3FmWnd, 27], [Tp3FmWnd, 28], [Tp3FmWnd, 29], [Tp3FmWnd, 30],
 [Tp3FmWnd, 31], [Tp3FmWnd, 32], [Tp3FmWnd, 33], [Tp3FmWnd, 34], [Tp3FmWnd, 35], [Tp3FmWnd, 36], [Tp3FmWnd, 37], [Tp3FmWnd, 38], [Tp3FmWnd, 39], [Tp3FmWnd, 40],
 [Tp3FmWnd, 41], [Tp3FmWnd, 42], [Tp3FmWnd, 43], [Tp3FmWnd, 44], [Tp3FmWnd, 45], [Tp3FmWnd, 46], [Tp3FmWnd, 47], [Tp3FmWnd, 48], [Tp3FmWnd, 49], [Tp3FmWnd, 50])


DEFINE_EVENT

BUTTON_EVENT[TpFmPrstChns]
{
    RELEASE:
    {
	CALL 'SetIntegTunPrst' (TpMediaZnAssocs[Button.Input.Device.Number - 10000], Button.Input.Channel);
    }
}


BUTTON_EVENT[TpFmWnd, 100]
{
    RELEASE:
    {
	CALL 'ChangeIntegTunFreq' (TpMediaZnAssocs[Button.Input.Device.Number - 10000], IntegTunFreqDown);
    }
}


BUTTON_EVENT[TpFmWnd, 101]
{
    RELEASE:
    {
	CALL 'ChangeIntegTunFreq' (TpMediaZnAssocs[Button.Input.Device.Number - 10000], IntegTunFreqUp);
    }
}