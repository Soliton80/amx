PROGRAM_NAME = 'tvwndctrl'


DEFINE_VARIABLE

DEVCHAN TpTvCtrlBtnChns[] = {{Tp1TvWnd, 1}, {Tp1TvWnd, 2}, {Tp1TvWnd, 3}, {Tp1TvWnd, 4}, {Tp1TvWnd, 5}, {Tp1TvWnd, 6}, {Tp1TvWnd, 7}, {Tp1TvWnd, 8}, {Tp1TvWnd, 9}, {Tp1TvWnd, 10},
			     {Tp1TvWnd, 11}, {Tp1TvWnd, 12}, {Tp1TvWnd, 13}, {Tp1TvWnd, 14}, {Tp1TvWnd, 15}, {Tp1TvWnd, 16}, {Tp1TvWnd, 17}, {Tp1TvWnd, 18}, {Tp1TvWnd, 19}, {Tp1TvWnd, 20},
			     {Tp1TvWnd, 21}, {Tp1TvWnd, 22}, {Tp1TvWnd, 23}, {Tp1TvWnd, 24}, {Tp1TvWnd, 25}, {Tp1TvWnd, 26}, {Tp1TvWnd, 27}, {Tp1TvWnd, 28}, {Tp1TvWnd, 29}, {Tp1TvWnd, 30},
			     {Tp1TvWnd, 31}, {Tp1TvWnd, 32}, {Tp1TvWnd, 33}, {Tp1TvWnd, 34}, {Tp1TvWnd, 35}, {Tp1TvWnd, 36}, {Tp1TvWnd, 37}, {Tp1TvWnd, 38}, {Tp1TvWnd, 39}, {Tp1TvWnd, 40},
			     {Tp1TvWnd, 41}, {Tp1TvWnd, 42}, {Tp1TvWnd, 43}, {Tp1TvWnd, 44}, {Tp1TvWnd, 45}, {Tp1TvWnd, 46}, {Tp1TvWnd, 47}, {Tp1TvWnd, 48},
			     {Tp2TvWnd, 1}, {Tp2TvWnd, 2}, {Tp2TvWnd, 3}, {Tp2TvWnd, 4}, {Tp2TvWnd, 5}, {Tp2TvWnd, 6}, {Tp2TvWnd, 7}, {Tp2TvWnd, 8}, {Tp2TvWnd, 9}, {Tp2TvWnd, 10},
			     {Tp2TvWnd, 11}, {Tp2TvWnd, 12}, {Tp2TvWnd, 13}, {Tp2TvWnd, 14}, {Tp2TvWnd, 15}, {Tp2TvWnd, 16}, {Tp2TvWnd, 17}, {Tp2TvWnd, 18}, {Tp2TvWnd, 19}, {Tp2TvWnd, 20},
			     {Tp2TvWnd, 21}, {Tp2TvWnd, 22}, {Tp2TvWnd, 23}, {Tp2TvWnd, 24}, {Tp2TvWnd, 25}, {Tp2TvWnd, 26}, {Tp2TvWnd, 27}, {Tp2TvWnd, 28}, {Tp2TvWnd, 29}, {Tp2TvWnd, 30},
			     {Tp2TvWnd, 31}, {Tp2TvWnd, 32}, {Tp2TvWnd, 33}, {Tp2TvWnd, 34}, {Tp2TvWnd, 35}, {Tp2TvWnd, 36}, {Tp2TvWnd, 37}, {Tp2TvWnd, 38}, {Tp2TvWnd, 39}, {Tp2TvWnd, 40},
			     {Tp2TvWnd, 41}, {Tp2TvWnd, 42}, {Tp2TvWnd, 43}, {Tp2TvWnd, 44}, {Tp2TvWnd, 45}, {Tp2TvWnd, 46}, {Tp2TvWnd, 47}, {Tp2TvWnd, 48},
			     {Tp3TvWnd, 1}, {Tp3TvWnd, 2}, {Tp3TvWnd, 3}, {Tp3TvWnd, 4}, {Tp3TvWnd, 5}, {Tp3TvWnd, 6}, {Tp3TvWnd, 7}, {Tp3TvWnd, 8}, {Tp3TvWnd, 9}, {Tp3TvWnd, 10},
			     {Tp3TvWnd, 11}, {Tp3TvWnd, 12}, {Tp3TvWnd, 13}, {Tp3TvWnd, 14}, {Tp3TvWnd, 15}, {Tp3TvWnd, 16}, {Tp3TvWnd, 17}, {Tp3TvWnd, 18}, {Tp3TvWnd, 19}, {Tp3TvWnd, 20},
			     {Tp3TvWnd, 21}, {Tp3TvWnd, 22}, {Tp3TvWnd, 23}, {Tp3TvWnd, 24}, {Tp3TvWnd, 25}, {Tp3TvWnd, 26}, {Tp3TvWnd, 27}, {Tp3TvWnd, 28}, {Tp3TvWnd, 29}, {Tp3TvWnd, 30},
			     {Tp3TvWnd, 31}, {Tp3TvWnd, 32}, {Tp3TvWnd, 33}, {Tp3TvWnd, 34}, {Tp3TvWnd, 35}, {Tp3TvWnd, 36}, {Tp3TvWnd, 37}, {Tp3TvWnd, 38}, {Tp3TvWnd, 39}, {Tp3TvWnd, 40},
			     {Tp3TvWnd, 41}, {Tp3TvWnd, 42}, {Tp3TvWnd, 43}, {Tp3TvWnd, 44}, {Tp3TvWnd, 45}, {Tp3TvWnd, 46}, {Tp3TvWnd, 47}, {Tp3TvWnd, 48}};


DEFINE_CALL 'TvWndShow' (DEV Tp)
{
    SEND_COMMAND Tp, 'PPON-TvWnd';
}


DEFINE_CALL 'TvWndCls' (DEV Tp)
{
    SEND_COMMAND Tp, 'PPOF-TvWnd';
}


DEFINE_EVENT

BUTTON_EVENT[TpTvCtrlBtnChns]
{
    RELEASE:
    {
	CALL 'ExecTvCmd' (Button.Input.Channel);
    }
}