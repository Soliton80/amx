PROGRAM_NAME = 'satwndctrl'


DEFINE_CONSTANT

CHAR SatChnGrpNames[][10] = {'Free', 'Movie', 'Cognit', 'Child', 'Entrtmnt', 'Music', 'Sport', 'Hd', 'Inf'};


DEFINE_VARIABLE

DEVCHAN TpSatChnGrps[] = {{Tp1SatWnd, 201}, {Tp1SatWnd, 202}, {Tp1SatWnd, 203}, {Tp1SatWnd, 204}, {Tp1SatWnd, 205}, {Tp1SatWnd, 206}, {Tp1SatWnd, 207}, {Tp1SatWnd, 208}, {Tp1SatWnd, 209},
			  {Tp2SatWnd, 201}, {Tp2SatWnd, 202}, {Tp2SatWnd, 203}, {Tp2SatWnd, 204}, {Tp2SatWnd, 205}, {Tp2SatWnd, 206}, {Tp2SatWnd, 207}, {Tp2SatWnd, 208}, {Tp2SatWnd, 209},
			  {Tp3SatWnd, 201}, {Tp3SatWnd, 202}, {Tp3SatWnd, 203}, {Tp3SatWnd, 204}, {Tp3SatWnd, 205}, {Tp3SatWnd, 206}, {Tp3SatWnd, 207}, {Tp3SatWnd, 208}, {Tp3SatWnd, 209}};

DEVCHAN TpSatChns[] = {{Tp1SatWnd, 1}, {Tp1SatWnd, 2}, {Tp1SatWnd, 3}, {Tp1SatWnd, 4}, {Tp1SatWnd, 5}, {Tp1SatWnd, 6}, {Tp1SatWnd, 7}, {Tp1SatWnd, 8}, {Tp1SatWnd, 9},  {Tp1SatWnd, 10},
		       {Tp1SatWnd, 11}, {Tp1SatWnd, 12}, {Tp1SatWnd, 13}, {Tp1SatWnd, 14}, {Tp1SatWnd, 15}, {Tp1SatWnd, 16}, {Tp1SatWnd, 17}, {Tp1SatWnd, 18}, {Tp1SatWnd, 19},  {Tp1SatWnd, 20},
		       {Tp1SatWnd, 21}, {Tp1SatWnd, 22}, {Tp1SatWnd, 23}, {Tp1SatWnd, 24}, {Tp1SatWnd, 25}, {Tp1SatWnd, 26}, {Tp1SatWnd, 27}, {Tp1SatWnd, 28}, {Tp1SatWnd, 29},  {Tp1SatWnd, 30},
		       {Tp1SatWnd, 31}, {Tp1SatWnd, 32}, {Tp1SatWnd, 33}, {Tp1SatWnd, 34}, {Tp1SatWnd, 35}, {Tp1SatWnd, 36}, {Tp1SatWnd, 37}, {Tp1SatWnd, 38}, {Tp1SatWnd, 39},  {Tp1SatWnd, 40},
		       {Tp1SatWnd, 41}, {Tp1SatWnd, 42}, {Tp1SatWnd, 43}, {Tp1SatWnd, 44}, {Tp1SatWnd, 45}, {Tp1SatWnd, 46}, {Tp1SatWnd, 47}, {Tp1SatWnd, 48}, {Tp1SatWnd, 49},  {Tp1SatWnd, 50},
		       {Tp1SatWnd, 51}, {Tp1SatWnd, 52}, {Tp1SatWnd, 53}, {Tp1SatWnd, 54}, {Tp1SatWnd, 55}, {Tp1SatWnd, 56}, {Tp1SatWnd, 57}, {Tp1SatWnd, 58}, {Tp1SatWnd, 59},  {Tp1SatWnd, 60},
		       {Tp1SatWnd, 61}, {Tp1SatWnd, 62}, {Tp1SatWnd, 63}, {Tp1SatWnd, 64}, {Tp1SatWnd, 65}, {Tp1SatWnd, 66}, {Tp1SatWnd, 67}, {Tp1SatWnd, 68}, {Tp1SatWnd, 69},  {Tp1SatWnd, 70},
		       {Tp1SatWnd, 71}, {Tp1SatWnd, 72}, {Tp1SatWnd, 73}, {Tp1SatWnd, 74}, {Tp1SatWnd, 75}, {Tp1SatWnd, 76}, {Tp1SatWnd, 77}, {Tp1SatWnd, 78}, {Tp1SatWnd, 79},  {Tp1SatWnd, 80},
		       {Tp1SatWnd, 81}, {Tp1SatWnd, 82}, {Tp1SatWnd, 83}, {Tp1SatWnd, 84}, {Tp1SatWnd, 85}, {Tp1SatWnd, 86}, {Tp1SatWnd, 87}, {Tp1SatWnd, 88}, {Tp1SatWnd, 89},  {Tp1SatWnd, 90},
		       {Tp1SatWnd, 91}, {Tp1SatWnd, 92}, {Tp1SatWnd, 93}, {Tp1SatWnd, 94}, {Tp1SatWnd, 95}, {Tp1SatWnd, 96}, {Tp1SatWnd, 97}, {Tp1SatWnd, 98}, {Tp1SatWnd, 99},  {Tp1SatWnd, 100},
		       {Tp1SatWnd, 101}, {Tp1SatWnd, 102}, {Tp1SatWnd, 103}, {Tp1SatWnd, 104}, {Tp1SatWnd, 105}, {Tp1SatWnd, 106}, {Tp1SatWnd, 107}, {Tp1SatWnd, 108}, {Tp1SatWnd, 109},  {Tp1SatWnd, 110},
		       {Tp1SatWnd, 111}, {Tp1SatWnd, 112}, {Tp1SatWnd, 113}, {Tp1SatWnd, 114}, {Tp1SatWnd, 115}, {Tp1SatWnd, 116}, {Tp1SatWnd, 117}, {Tp1SatWnd, 118}, {Tp1SatWnd, 119},  {Tp1SatWnd, 120},
		       {Tp1SatWnd, 121}, {Tp1SatWnd, 122}, {Tp1SatWnd, 123}, {Tp1SatWnd, 124}, {Tp1SatWnd, 125}, {Tp1SatWnd, 126}, {Tp1SatWnd, 127}, {Tp1SatWnd, 128}, {Tp1SatWnd, 129},  {Tp1SatWnd, 130},
		       {Tp1SatWnd, 131}, {Tp1SatWnd, 132}, {Tp1SatWnd, 133}, {Tp1SatWnd, 134}, {Tp1SatWnd, 135}, {Tp1SatWnd, 136}, {Tp1SatWnd, 137}, {Tp1SatWnd, 138}, {Tp1SatWnd, 139},  {Tp1SatWnd, 140},
		       {Tp1SatWnd, 141}, {Tp1SatWnd, 142}, {Tp1SatWnd, 143}, {Tp1SatWnd, 144}, {Tp1SatWnd, 145}, {Tp1SatWnd, 146}, {Tp1SatWnd, 147}, {Tp1SatWnd, 148}, {Tp1SatWnd, 149},  {Tp1SatWnd, 150},
		       {Tp2SatWnd, 1}, {Tp2SatWnd, 2}, {Tp2SatWnd, 3}, {Tp2SatWnd, 4}, {Tp2SatWnd, 5}, {Tp2SatWnd, 6}, {Tp2SatWnd, 7}, {Tp2SatWnd, 8}, {Tp2SatWnd, 9},  {Tp2SatWnd, 10},
		       {Tp2SatWnd, 11}, {Tp2SatWnd, 12}, {Tp2SatWnd, 13}, {Tp2SatWnd, 14}, {Tp2SatWnd, 15}, {Tp2SatWnd, 16}, {Tp2SatWnd, 17}, {Tp2SatWnd, 18}, {Tp2SatWnd, 19},  {Tp2SatWnd, 20},
		       {Tp2SatWnd, 21}, {Tp2SatWnd, 22}, {Tp2SatWnd, 23}, {Tp2SatWnd, 24}, {Tp2SatWnd, 25}, {Tp2SatWnd, 26}, {Tp2SatWnd, 27}, {Tp2SatWnd, 28}, {Tp2SatWnd, 29},  {Tp2SatWnd, 30},
		       {Tp2SatWnd, 31}, {Tp2SatWnd, 32}, {Tp2SatWnd, 33}, {Tp2SatWnd, 34}, {Tp2SatWnd, 35}, {Tp2SatWnd, 36}, {Tp2SatWnd, 37}, {Tp2SatWnd, 38}, {Tp2SatWnd, 39},  {Tp2SatWnd, 40},
		       {Tp2SatWnd, 41}, {Tp2SatWnd, 42}, {Tp2SatWnd, 43}, {Tp2SatWnd, 44}, {Tp2SatWnd, 45}, {Tp2SatWnd, 46}, {Tp2SatWnd, 47}, {Tp2SatWnd, 48}, {Tp2SatWnd, 49},  {Tp2SatWnd, 50},
		       {Tp2SatWnd, 51}, {Tp2SatWnd, 52}, {Tp2SatWnd, 53}, {Tp2SatWnd, 54}, {Tp2SatWnd, 55}, {Tp2SatWnd, 56}, {Tp2SatWnd, 57}, {Tp2SatWnd, 58}, {Tp2SatWnd, 59},  {Tp2SatWnd, 60},
		       {Tp2SatWnd, 61}, {Tp2SatWnd, 62}, {Tp2SatWnd, 63}, {Tp2SatWnd, 64}, {Tp2SatWnd, 65}, {Tp2SatWnd, 66}, {Tp2SatWnd, 67}, {Tp2SatWnd, 68}, {Tp2SatWnd, 69},  {Tp2SatWnd, 70},
		       {Tp2SatWnd, 71}, {Tp2SatWnd, 72}, {Tp2SatWnd, 73}, {Tp2SatWnd, 74}, {Tp2SatWnd, 75}, {Tp2SatWnd, 76}, {Tp2SatWnd, 77}, {Tp2SatWnd, 78}, {Tp2SatWnd, 79},  {Tp2SatWnd, 80},
		       {Tp2SatWnd, 81}, {Tp2SatWnd, 82}, {Tp2SatWnd, 83}, {Tp2SatWnd, 84}, {Tp2SatWnd, 85}, {Tp2SatWnd, 86}, {Tp2SatWnd, 87}, {Tp2SatWnd, 88}, {Tp2SatWnd, 89},  {Tp2SatWnd, 90},
		       {Tp2SatWnd, 91}, {Tp2SatWnd, 92}, {Tp2SatWnd, 93}, {Tp2SatWnd, 94}, {Tp2SatWnd, 95}, {Tp2SatWnd, 96}, {Tp2SatWnd, 97}, {Tp2SatWnd, 98}, {Tp2SatWnd, 99},  {Tp2SatWnd, 100},
		       {Tp2SatWnd, 101}, {Tp2SatWnd, 102}, {Tp2SatWnd, 103}, {Tp2SatWnd, 104}, {Tp2SatWnd, 105}, {Tp2SatWnd, 106}, {Tp2SatWnd, 107}, {Tp2SatWnd, 108}, {Tp2SatWnd, 109},  {Tp2SatWnd, 110},
		       {Tp2SatWnd, 111}, {Tp2SatWnd, 112}, {Tp2SatWnd, 113}, {Tp2SatWnd, 114}, {Tp2SatWnd, 115}, {Tp2SatWnd, 116}, {Tp2SatWnd, 117}, {Tp2SatWnd, 118}, {Tp2SatWnd, 119},  {Tp2SatWnd, 120},
		       {Tp2SatWnd, 121}, {Tp2SatWnd, 122}, {Tp2SatWnd, 123}, {Tp2SatWnd, 124}, {Tp2SatWnd, 125}, {Tp2SatWnd, 126}, {Tp2SatWnd, 127}, {Tp2SatWnd, 128}, {Tp2SatWnd, 129},  {Tp2SatWnd, 130},
		       {Tp2SatWnd, 131}, {Tp2SatWnd, 132}, {Tp2SatWnd, 133}, {Tp2SatWnd, 134}, {Tp2SatWnd, 135}, {Tp2SatWnd, 136}, {Tp2SatWnd, 137}, {Tp2SatWnd, 138}, {Tp2SatWnd, 139},  {Tp2SatWnd, 140},
		       {Tp2SatWnd, 141}, {Tp2SatWnd, 142}, {Tp2SatWnd, 143}, {Tp2SatWnd, 144}, {Tp2SatWnd, 145}, {Tp2SatWnd, 146}, {Tp2SatWnd, 147}, {Tp2SatWnd, 148}, {Tp2SatWnd, 149},  {Tp2SatWnd, 150},
		       {Tp3SatWnd, 1}, {Tp3SatWnd, 2}, {Tp3SatWnd, 3}, {Tp3SatWnd, 4}, {Tp3SatWnd, 5}, {Tp3SatWnd, 6}, {Tp3SatWnd, 7}, {Tp3SatWnd, 8}, {Tp3SatWnd, 9},  {Tp3SatWnd, 10},
		       {Tp3SatWnd, 11}, {Tp3SatWnd, 12}, {Tp3SatWnd, 13}, {Tp3SatWnd, 14}, {Tp3SatWnd, 15}, {Tp3SatWnd, 16}, {Tp3SatWnd, 17}, {Tp3SatWnd, 18}, {Tp3SatWnd, 19},  {Tp3SatWnd, 20},
		       {Tp3SatWnd, 21}, {Tp3SatWnd, 22}, {Tp3SatWnd, 23}, {Tp3SatWnd, 24}, {Tp3SatWnd, 25}, {Tp3SatWnd, 26}, {Tp3SatWnd, 27}, {Tp3SatWnd, 28}, {Tp3SatWnd, 29},  {Tp3SatWnd, 30},
		       {Tp3SatWnd, 31}, {Tp3SatWnd, 32}, {Tp3SatWnd, 33}, {Tp3SatWnd, 34}, {Tp3SatWnd, 35}, {Tp3SatWnd, 36}, {Tp3SatWnd, 37}, {Tp3SatWnd, 38}, {Tp3SatWnd, 39},  {Tp3SatWnd, 40},
		       {Tp3SatWnd, 41}, {Tp3SatWnd, 42}, {Tp3SatWnd, 43}, {Tp3SatWnd, 44}, {Tp3SatWnd, 45}, {Tp3SatWnd, 46}, {Tp3SatWnd, 47}, {Tp3SatWnd, 48}, {Tp3SatWnd, 49},  {Tp3SatWnd, 50},
		       {Tp3SatWnd, 51}, {Tp3SatWnd, 52}, {Tp3SatWnd, 53}, {Tp3SatWnd, 54}, {Tp3SatWnd, 55}, {Tp3SatWnd, 56}, {Tp3SatWnd, 57}, {Tp3SatWnd, 58}, {Tp3SatWnd, 59},  {Tp3SatWnd, 60},
		       {Tp3SatWnd, 61}, {Tp3SatWnd, 62}, {Tp3SatWnd, 63}, {Tp3SatWnd, 64}, {Tp3SatWnd, 65}, {Tp3SatWnd, 66}, {Tp3SatWnd, 67}, {Tp3SatWnd, 68}, {Tp3SatWnd, 69},  {Tp3SatWnd, 70},
		       {Tp3SatWnd, 71}, {Tp3SatWnd, 72}, {Tp3SatWnd, 73}, {Tp3SatWnd, 74}, {Tp3SatWnd, 75}, {Tp3SatWnd, 76}, {Tp3SatWnd, 77}, {Tp3SatWnd, 78}, {Tp3SatWnd, 79},  {Tp3SatWnd, 80},
		       {Tp3SatWnd, 81}, {Tp3SatWnd, 82}, {Tp3SatWnd, 83}, {Tp3SatWnd, 84}, {Tp3SatWnd, 85}, {Tp3SatWnd, 86}, {Tp3SatWnd, 87}, {Tp3SatWnd, 88}, {Tp3SatWnd, 89},  {Tp3SatWnd, 90},
		       {Tp3SatWnd, 91}, {Tp3SatWnd, 92}, {Tp3SatWnd, 93}, {Tp3SatWnd, 94}, {Tp3SatWnd, 95}, {Tp3SatWnd, 96}, {Tp3SatWnd, 97}, {Tp3SatWnd, 98}, {Tp3SatWnd, 99},  {Tp3SatWnd, 100},
		       {Tp3SatWnd, 101}, {Tp3SatWnd, 102}, {Tp3SatWnd, 103}, {Tp3SatWnd, 104}, {Tp3SatWnd, 105}, {Tp3SatWnd, 106}, {Tp3SatWnd, 107}, {Tp3SatWnd, 108}, {Tp3SatWnd, 109},  {Tp3SatWnd, 110},
		       {Tp3SatWnd, 111}, {Tp3SatWnd, 112}, {Tp3SatWnd, 113}, {Tp3SatWnd, 114}, {Tp3SatWnd, 115}, {Tp3SatWnd, 116}, {Tp3SatWnd, 117}, {Tp3SatWnd, 118}, {Tp3SatWnd, 119},  {Tp3SatWnd, 120},
		       {Tp3SatWnd, 121}, {Tp3SatWnd, 122}, {Tp3SatWnd, 123}, {Tp3SatWnd, 124}, {Tp3SatWnd, 125}, {Tp3SatWnd, 126}, {Tp3SatWnd, 127}, {Tp3SatWnd, 128}, {Tp3SatWnd, 129},  {Tp3SatWnd, 130},
		       {Tp3SatWnd, 131}, {Tp3SatWnd, 132}, {Tp3SatWnd, 133}, {Tp3SatWnd, 134}, {Tp3SatWnd, 135}, {Tp3SatWnd, 136}, {Tp3SatWnd, 137}, {Tp3SatWnd, 138}, {Tp3SatWnd, 139},  {Tp3SatWnd, 140},
		       {Tp3SatWnd, 141}, {Tp3SatWnd, 142}, {Tp3SatWnd, 143}, {Tp3SatWnd, 144}, {Tp3SatWnd, 145}, {Tp3SatWnd, 146}, {Tp3SatWnd, 147}, {Tp3SatWnd, 148}, {Tp3SatWnd, 149},  {Tp3SatWnd, 150}};

VOLATILE INTEGER TpSatChnGrpWndAssocs[TpsCnt];

VOLATILE INTEGER CurrSatChnGrp;
VOLATILE INTEGER CurrSatChn;


DEFINE_CALL 'SatWndShow' (DEV Tp)
{
    INTEGER CurrSatChnGrpWnd;
    CurrSatChnGrpWnd = TpSatChnGrpWndAssocs[Tp.Number - 10000];
    IF (CurrSatChnGrpWnd == 0) SEND_COMMAND Tp, 'PPON-SatWnd';
    ELSE SEND_COMMAND Tp, "'PPON-Sat', SatChnGrpNames[CurrSatChnGrpWnd], 'ChnsWnd'";
}


DEFINE_CALL 'SatWndCls' (DEV Tp)
{
    INTEGER CurrSatChnGrpWnd;
    CurrSatChnGrpWnd = TpSatChnGrpWndAssocs[Tp.Number - 10000];
    IF (CurrSatChnGrpWnd == 0) SEND_COMMAND Tp, 'PPOF-SatWnd';
    ELSE SEND_COMMAND Tp, "'PPOF-Sat', SatChnGrpNames[CurrSatChnGrpWnd], 'ChnsWnd'";
}


DEFINE_MUTUALLY_EXCLUSIVE

([Tp1SatWnd, 201], [Tp1SatWnd, 202], [Tp1SatWnd, 203], [Tp1SatWnd, 204], [Tp1SatWnd, 205], [Tp1SatWnd, 206], [Tp1SatWnd, 207], [Tp1SatWnd, 208], [Tp1SatWnd, 209])
([Tp2SatWnd, 201], [Tp2SatWnd, 202], [Tp2SatWnd, 203], [Tp2SatWnd, 204], [Tp2SatWnd, 205], [Tp2SatWnd, 206], [Tp2SatWnd, 207], [Tp2SatWnd, 208], [Tp2SatWnd, 209])
([Tp3SatWnd, 201], [Tp3SatWnd, 202], [Tp3SatWnd, 203], [Tp3SatWnd, 204], [Tp3SatWnd, 205], [Tp3SatWnd, 206], [Tp3SatWnd, 207], [Tp3SatWnd, 208], [Tp3SatWnd, 209])

([Tp1SatWnd, 1], [Tp1SatWnd, 2], [Tp1SatWnd, 3], [Tp1SatWnd, 4], [Tp1SatWnd, 5], [Tp1SatWnd, 6], [Tp1SatWnd, 7], [Tp1SatWnd, 8], [Tp1SatWnd, 9],  [Tp1SatWnd, 10],
 [Tp1SatWnd, 11], [Tp1SatWnd, 12], [Tp1SatWnd, 13], [Tp1SatWnd, 14], [Tp1SatWnd, 15], [Tp1SatWnd, 16], [Tp1SatWnd, 17], [Tp1SatWnd, 18], [Tp1SatWnd, 19],  [Tp1SatWnd, 20],
 [Tp1SatWnd, 21], [Tp1SatWnd, 22], [Tp1SatWnd, 23], [Tp1SatWnd, 24], [Tp1SatWnd, 25], [Tp1SatWnd, 26], [Tp1SatWnd, 27], [Tp1SatWnd, 28], [Tp1SatWnd, 29],  [Tp1SatWnd, 30],
 [Tp1SatWnd, 31], [Tp1SatWnd, 32], [Tp1SatWnd, 33], [Tp1SatWnd, 34], [Tp1SatWnd, 35], [Tp1SatWnd, 36], [Tp1SatWnd, 37], [Tp1SatWnd, 38], [Tp1SatWnd, 39],  [Tp1SatWnd, 40],
 [Tp1SatWnd, 41], [Tp1SatWnd, 42], [Tp1SatWnd, 43], [Tp1SatWnd, 44], [Tp1SatWnd, 45], [Tp1SatWnd, 46], [Tp1SatWnd, 47], [Tp1SatWnd, 48], [Tp1SatWnd, 49],  [Tp1SatWnd, 50],
 [Tp1SatWnd, 51], [Tp1SatWnd, 52], [Tp1SatWnd, 53], [Tp1SatWnd, 54], [Tp1SatWnd, 55], [Tp1SatWnd, 56], [Tp1SatWnd, 57], [Tp1SatWnd, 58], [Tp1SatWnd, 59],  [Tp1SatWnd, 60],
 [Tp1SatWnd, 61], [Tp1SatWnd, 62], [Tp1SatWnd, 63], [Tp1SatWnd, 64], [Tp1SatWnd, 65], [Tp1SatWnd, 66], [Tp1SatWnd, 67], [Tp1SatWnd, 68], [Tp1SatWnd, 69],  [Tp1SatWnd, 70],
 [Tp1SatWnd, 71], [Tp1SatWnd, 72], [Tp1SatWnd, 73], [Tp1SatWnd, 74], [Tp1SatWnd, 75], [Tp1SatWnd, 76], [Tp1SatWnd, 77], [Tp1SatWnd, 78], [Tp1SatWnd, 79],  [Tp1SatWnd, 80],
 [Tp1SatWnd, 81], [Tp1SatWnd, 82], [Tp1SatWnd, 83], [Tp1SatWnd, 84], [Tp1SatWnd, 85], [Tp1SatWnd, 86], [Tp1SatWnd, 87], [Tp1SatWnd, 88], [Tp1SatWnd, 89],  [Tp1SatWnd, 90],
 [Tp1SatWnd, 91], [Tp1SatWnd, 92], [Tp1SatWnd, 93], [Tp1SatWnd, 94], [Tp1SatWnd, 95], [Tp1SatWnd, 96], [Tp1SatWnd, 97], [Tp1SatWnd, 98], [Tp1SatWnd, 99],  [Tp1SatWnd, 100],
 [Tp1SatWnd, 101], [Tp1SatWnd, 102], [Tp1SatWnd, 103], [Tp1SatWnd, 104], [Tp1SatWnd, 105], [Tp1SatWnd, 106], [Tp1SatWnd, 107], [Tp1SatWnd, 108], [Tp1SatWnd, 109],  [Tp1SatWnd, 110],
 [Tp1SatWnd, 111], [Tp1SatWnd, 112], [Tp1SatWnd, 113], [Tp1SatWnd, 114], [Tp1SatWnd, 115], [Tp1SatWnd, 116], [Tp1SatWnd, 117], [Tp1SatWnd, 118], [Tp1SatWnd, 119],  [Tp1SatWnd, 120],
 [Tp1SatWnd, 121], [Tp1SatWnd, 122], [Tp1SatWnd, 123], [Tp1SatWnd, 124], [Tp1SatWnd, 125], [Tp1SatWnd, 126], [Tp1SatWnd, 127], [Tp1SatWnd, 128], [Tp1SatWnd, 129],  [Tp1SatWnd, 130],
 [Tp1SatWnd, 131], [Tp1SatWnd, 132], [Tp1SatWnd, 133], [Tp1SatWnd, 134], [Tp1SatWnd, 135], [Tp1SatWnd, 136], [Tp1SatWnd, 137], [Tp1SatWnd, 138], [Tp1SatWnd, 139],  [Tp1SatWnd, 140],
 [Tp1SatWnd, 141], [Tp1SatWnd, 142], [Tp1SatWnd, 143], [Tp1SatWnd, 144], [Tp1SatWnd, 145], [Tp1SatWnd, 146], [Tp1SatWnd, 147], [Tp1SatWnd, 148], [Tp1SatWnd, 149],  [Tp1SatWnd, 150])

([Tp2SatWnd, 1], [Tp2SatWnd, 2], [Tp2SatWnd, 3], [Tp2SatWnd, 4], [Tp2SatWnd, 5], [Tp2SatWnd, 6], [Tp2SatWnd, 7], [Tp2SatWnd, 8], [Tp2SatWnd, 9],  [Tp2SatWnd, 10],
 [Tp2SatWnd, 11], [Tp2SatWnd, 12], [Tp2SatWnd, 13], [Tp2SatWnd, 14], [Tp2SatWnd, 15], [Tp2SatWnd, 16], [Tp2SatWnd, 17], [Tp2SatWnd, 18], [Tp2SatWnd, 19],  [Tp2SatWnd, 20],
 [Tp2SatWnd, 21], [Tp2SatWnd, 22], [Tp2SatWnd, 23], [Tp2SatWnd, 24], [Tp2SatWnd, 25], [Tp2SatWnd, 26], [Tp2SatWnd, 27], [Tp2SatWnd, 28], [Tp2SatWnd, 29],  [Tp2SatWnd, 30],
 [Tp2SatWnd, 31], [Tp2SatWnd, 32], [Tp2SatWnd, 33], [Tp2SatWnd, 34], [Tp2SatWnd, 35], [Tp2SatWnd, 36], [Tp2SatWnd, 37], [Tp2SatWnd, 38], [Tp2SatWnd, 39],  [Tp2SatWnd, 40],
 [Tp2SatWnd, 41], [Tp2SatWnd, 42], [Tp2SatWnd, 43], [Tp2SatWnd, 44], [Tp2SatWnd, 45], [Tp2SatWnd, 46], [Tp2SatWnd, 47], [Tp2SatWnd, 48], [Tp2SatWnd, 49],  [Tp2SatWnd, 50],
 [Tp2SatWnd, 51], [Tp2SatWnd, 52], [Tp2SatWnd, 53], [Tp2SatWnd, 54], [Tp2SatWnd, 55], [Tp2SatWnd, 56], [Tp2SatWnd, 57], [Tp2SatWnd, 58], [Tp2SatWnd, 59],  [Tp2SatWnd, 60],
 [Tp2SatWnd, 61], [Tp2SatWnd, 62], [Tp2SatWnd, 63], [Tp2SatWnd, 64], [Tp2SatWnd, 65], [Tp2SatWnd, 66], [Tp2SatWnd, 67], [Tp2SatWnd, 68], [Tp2SatWnd, 69],  [Tp2SatWnd, 70],
 [Tp2SatWnd, 71], [Tp2SatWnd, 72], [Tp2SatWnd, 73], [Tp2SatWnd, 74], [Tp2SatWnd, 75], [Tp2SatWnd, 76], [Tp2SatWnd, 77], [Tp2SatWnd, 78], [Tp2SatWnd, 79],  [Tp2SatWnd, 80],
 [Tp2SatWnd, 81], [Tp2SatWnd, 82], [Tp2SatWnd, 83], [Tp2SatWnd, 84], [Tp2SatWnd, 85], [Tp2SatWnd, 86], [Tp2SatWnd, 87], [Tp2SatWnd, 88], [Tp2SatWnd, 89],  [Tp2SatWnd, 90],
 [Tp2SatWnd, 91], [Tp2SatWnd, 92], [Tp2SatWnd, 93], [Tp2SatWnd, 94], [Tp2SatWnd, 95], [Tp2SatWnd, 96], [Tp2SatWnd, 97], [Tp2SatWnd, 98], [Tp2SatWnd, 99],  [Tp2SatWnd, 100],
 [Tp2SatWnd, 101], [Tp2SatWnd, 102], [Tp2SatWnd, 103], [Tp2SatWnd, 104], [Tp2SatWnd, 105], [Tp2SatWnd, 106], [Tp2SatWnd, 107], [Tp2SatWnd, 108], [Tp2SatWnd, 109],  [Tp2SatWnd, 110],
 [Tp2SatWnd, 111], [Tp2SatWnd, 112], [Tp2SatWnd, 113], [Tp2SatWnd, 114], [Tp2SatWnd, 115], [Tp2SatWnd, 116], [Tp2SatWnd, 117], [Tp2SatWnd, 118], [Tp2SatWnd, 119],  [Tp2SatWnd, 120],
 [Tp2SatWnd, 121], [Tp2SatWnd, 122], [Tp2SatWnd, 123], [Tp2SatWnd, 124], [Tp2SatWnd, 125], [Tp2SatWnd, 126], [Tp2SatWnd, 127], [Tp2SatWnd, 128], [Tp2SatWnd, 129],  [Tp2SatWnd, 130],
 [Tp2SatWnd, 131], [Tp2SatWnd, 132], [Tp2SatWnd, 133], [Tp2SatWnd, 134], [Tp2SatWnd, 135], [Tp2SatWnd, 136], [Tp2SatWnd, 137], [Tp2SatWnd, 138], [Tp2SatWnd, 139],  [Tp2SatWnd, 140],
 [Tp2SatWnd, 141], [Tp2SatWnd, 142], [Tp2SatWnd, 143], [Tp2SatWnd, 144], [Tp2SatWnd, 145], [Tp2SatWnd, 146], [Tp2SatWnd, 147], [Tp2SatWnd, 148], [Tp2SatWnd, 149],  [Tp2SatWnd, 150])

([Tp3SatWnd, 1], [Tp3SatWnd, 2], [Tp3SatWnd, 3], [Tp3SatWnd, 4], [Tp3SatWnd, 5], [Tp3SatWnd, 6], [Tp3SatWnd, 7], [Tp3SatWnd, 8], [Tp3SatWnd, 9],  [Tp3SatWnd, 10],
 [Tp3SatWnd, 11], [Tp3SatWnd, 12], [Tp3SatWnd, 13], [Tp3SatWnd, 14], [Tp3SatWnd, 15], [Tp3SatWnd, 16], [Tp3SatWnd, 17], [Tp3SatWnd, 18], [Tp3SatWnd, 19],  [Tp3SatWnd, 20],
 [Tp3SatWnd, 21], [Tp3SatWnd, 22], [Tp3SatWnd, 23], [Tp3SatWnd, 24], [Tp3SatWnd, 25], [Tp3SatWnd, 26], [Tp3SatWnd, 27], [Tp3SatWnd, 28], [Tp3SatWnd, 29],  [Tp3SatWnd, 30],
 [Tp3SatWnd, 31], [Tp3SatWnd, 32], [Tp3SatWnd, 33], [Tp3SatWnd, 34], [Tp3SatWnd, 35], [Tp3SatWnd, 36], [Tp3SatWnd, 37], [Tp3SatWnd, 38], [Tp3SatWnd, 39],  [Tp3SatWnd, 40],
 [Tp3SatWnd, 41], [Tp3SatWnd, 42], [Tp3SatWnd, 43], [Tp3SatWnd, 44], [Tp3SatWnd, 45], [Tp3SatWnd, 46], [Tp3SatWnd, 47], [Tp3SatWnd, 48], [Tp3SatWnd, 49],  [Tp3SatWnd, 50],
 [Tp3SatWnd, 51], [Tp3SatWnd, 52], [Tp3SatWnd, 53], [Tp3SatWnd, 54], [Tp3SatWnd, 55], [Tp3SatWnd, 56], [Tp3SatWnd, 57], [Tp3SatWnd, 58], [Tp3SatWnd, 59],  [Tp3SatWnd, 60],
 [Tp3SatWnd, 61], [Tp3SatWnd, 62], [Tp3SatWnd, 63], [Tp3SatWnd, 64], [Tp3SatWnd, 65], [Tp3SatWnd, 66], [Tp3SatWnd, 67], [Tp3SatWnd, 68], [Tp3SatWnd, 69],  [Tp3SatWnd, 70],
 [Tp3SatWnd, 71], [Tp3SatWnd, 72], [Tp3SatWnd, 73], [Tp3SatWnd, 74], [Tp3SatWnd, 75], [Tp3SatWnd, 76], [Tp3SatWnd, 77], [Tp3SatWnd, 78], [Tp3SatWnd, 79],  [Tp3SatWnd, 80],
 [Tp3SatWnd, 81], [Tp3SatWnd, 82], [Tp3SatWnd, 83], [Tp3SatWnd, 84], [Tp3SatWnd, 85], [Tp3SatWnd, 86], [Tp3SatWnd, 87], [Tp3SatWnd, 88], [Tp3SatWnd, 89],  [Tp3SatWnd, 90],
 [Tp3SatWnd, 91], [Tp3SatWnd, 92], [Tp3SatWnd, 93], [Tp3SatWnd, 94], [Tp3SatWnd, 95], [Tp3SatWnd, 96], [Tp3SatWnd, 97], [Tp3SatWnd, 98], [Tp3SatWnd, 99],  [Tp3SatWnd, 100],
 [Tp3SatWnd, 101], [Tp3SatWnd, 102], [Tp3SatWnd, 103], [Tp3SatWnd, 104], [Tp3SatWnd, 105], [Tp3SatWnd, 106], [Tp3SatWnd, 107], [Tp3SatWnd, 108], [Tp3SatWnd, 109],  [Tp3SatWnd, 110],
 [Tp3SatWnd, 111], [Tp3SatWnd, 112], [Tp3SatWnd, 113], [Tp3SatWnd, 114], [Tp3SatWnd, 115], [Tp3SatWnd, 116], [Tp3SatWnd, 117], [Tp3SatWnd, 118], [Tp3SatWnd, 119],  [Tp3SatWnd, 120],
 [Tp3SatWnd, 121], [Tp3SatWnd, 122], [Tp3SatWnd, 123], [Tp3SatWnd, 124], [Tp3SatWnd, 125], [Tp3SatWnd, 126], [Tp3SatWnd, 127], [Tp3SatWnd, 128], [Tp3SatWnd, 129],  [Tp3SatWnd, 130],
 [Tp3SatWnd, 131], [Tp3SatWnd, 132], [Tp3SatWnd, 133], [Tp3SatWnd, 134], [Tp3SatWnd, 135], [Tp3SatWnd, 136], [Tp3SatWnd, 137], [Tp3SatWnd, 138], [Tp3SatWnd, 139],  [Tp3SatWnd, 140],
 [Tp3SatWnd, 141], [Tp3SatWnd, 142], [Tp3SatWnd, 143], [Tp3SatWnd, 144], [Tp3SatWnd, 145], [Tp3SatWnd, 146], [Tp3SatWnd, 147], [Tp3SatWnd, 148], [Tp3SatWnd, 149],  [Tp3SatWnd, 150])


DEFINE_EVENT

DATA_EVENT[TpPgs]
{
    ONLINE:
    {
	ON [TpSatWnd, CurrSatChnGrp + 200];
	ON [TpSatWnd, CurrSatChn];
    }
}


BUTTON_EVENT[TpSatChnGrps]
{
    RELEASE:
    {
	INTEGER TpNum;
	TpNum = Button.Input.Device.Number - 10000;
	TpSatChnGrpWndAssocs[TpNum] = Button.Input.Channel - 200;
	SEND_COMMAND Button.Input.Device, 'PPOF-SatWnd';
	SEND_COMMAND Button.Input.Device, "'PPON-Sat', SatChnGrpNames[TpSatChnGrpWndAssocs[TpNum]], 'ChnsWnd'";
    }
}


BUTTON_EVENT[TpSatWnd, 220]
{
    RELEASE:
    {
	INTEGER TpNum;
	TpNum = Button.Input.Device.Number - 10000;
	SEND_COMMAND Button.Input.Device, "'PPOF-Sat', SatChnGrpNames[TpSatChnGrpWndAssocs[TpNum]], 'ChnsWnd'";
	TpSatChnGrpWndAssocs[TpNum] = 0;
	SEND_COMMAND Button.Input.Device, 'PPON-SatWnd';
    }
}


BUTTON_EVENT[TpSatChns]
{
    RELEASE:
    {
	CurrSatChnGrp = TpSatChnGrpWndAssocs[Button.Input.Device.Number - 10000];
	CurrSatChn = Button.Input.Channel;
	
	ON [TpSatWnd, CurrSatChnGrp + 200];
	ON [TpSatWnd, CurrSatChn];
	
	CALL 'SetSatChn' (CurrSatChn);
    }
}