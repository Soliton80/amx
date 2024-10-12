PROGRAM_NAME = 'climtctrl'


DEFINE_CONSTANT

INTEGER ClimtZnsCount = 8;

LONG TimeLineArr_TmprtrRefresh[1] = {60000};

FLOAT Pt100[] = {80.31, 82.29, 84.27, 86.25, 88.22, 90.19, 92.16, 94.12, 96.09, 98.04, 100, 101.95, 103.9,
		 105.85, 107.79, 109.73, 111.67, 113.61, 115.54, 117.47, 119.4, 121.32, 123.24, 125.16, 127.07,
		 128.98, 130.89, 132.8, 134.7, 136.6, 138.5, 140.39, 142.29, 157.31, 175.84, 195.84};


DEFINE_TYPE

STRUCTURE SClimtZn
{
    INTEGER TemprtrIcpInChnIndx;
    INTEGER DamperIcpOutChnIndx;
}


DEFINE_VARIABLE

VOLATILE SClimtZn ClimtZns[ClimtZnsCount];


DEFINE_CALL 'ClimtPopupShow' (DEV Tp)
{
    INTEGER TpNum;
    TpNum = Tp.Number - 10000;
    IF (ClimtZns[TpStats[TpNum].CurrPg].TemprtrIcpInChnIndx != 0 &&
	ClimtZns[TpStats[TpNum].CurrPg].DamperIcpOutChnIndx != 0)
    {
	SEND_COMMAND Tp, 'PPON-ClimtPopup';
	
	CALL 'ClimtPopupCntntShow' (Tp);
    }
}


DEFINE_CALL 'ClimtPopupCntntShow' (DEV Tp)
{
    INTEGER TpNum;
    TpNum = Tp.Number - 10000;
    [TpClimt[TpNum], 1] = KomfStat.IsWork;
    SEND_COMMAND TpClimt[TpNum], "'^TXT-10,0,', ITOA(KomfStat.VentLvl)";
    SEND_COMMAND TpClimt[TpNum], "'^TXT-20,0,', ITOA(KomfStat.SetpntTmprtr / 10), ',', ITOA(KomfStat.SetpntTmprtr - (KomfStat.SetpntTmprtr / 10) * 10), ' C'";
    SEND_COMMAND TpClimt[TpNum], "'^TXT-30,0,', FORMAT('%3.1f', CalcTemprtr(IcpInAnChnVals[ClimtZns[TpStats[TpNum].CurrPg].TemprtrIcpInChnIndx])),' C'";
    SEND_COMMAND TpClimt[TpNum], "'^TXT-40,0,', ITOA(IcpOutAnChnVals[ClimtZns[TpStats[TpNum].CurrPg].DamperIcpOutChnIndx] / 3276)";
}


DEFINE_CALL 'KomfPwrRefresh'
{
    [TpClimt, 1] = KomfStat.IsWork;
}


DEFINE_CALL 'KomfVentLvlRefresh'
{
    SEND_COMMAND TpClimt, "'^TXT-10,0,', ITOA(KomfStat.VentLvl)";
}


DEFINE_CALL 'KomfSetpntTemprtrRefresh'
{
    SEND_COMMAND TpClimt, "'^TXT-20,0,', ITOA(KomfStat.SetpntTmprtr / 10), ',', ITOA(KomfStat.SetpntTmprtr - (KomfStat.SetpntTmprtr / 10) * 10), ' C'";
}


DEFINE_CALL 'TemprtrRefresh'
{
    INTEGER i;
    FOR (i = 1; i <= TpsCnt; i++)
	IF (ClimtZns[TpStats[i].CurrPg].TemprtrIcpInChnIndx != 0)
	    SEND_COMMAND TpClimt[i], "'^TXT-30,0,', FORMAT('%3.1f', CalcTemprtr(IcpInAnChnVals[ClimtZns[TpStats[i].CurrPg].TemprtrIcpInChnIndx])),' C'";
}


DEFINE_CALL 'DamperRefresh'
{
    INTEGER i;
    FOR (i = 1; i <= TpsCnt; i++)
	IF (ClimtZns[TpStats[i].CurrPg].DamperIcpOutChnIndx != 0)
	    SEND_COMMAND TpClimt[i], "'^TXT-40,0,', ITOA(IcpOutAnChnVals[ClimtZns[TpStats[i].CurrPg].DamperIcpOutChnIndx] / 3276)";
}


DEFINE_FUNCTION FLOAT CalcTemprtr(INTEGER TemprtrSnsrVal)
{
    FLOAT R;
    FLOAT T;
    FLOAT DT;
    INTEGER i;
    INTEGER GoOn;

    R = TemprtrSnsrVal / 10.0;
    T = -50;
    DT = 0;
    GoOn = true;

    IF (R > Pt100[1])
	FOR (i = 2; T < 250 && GoOn; i++)
	{
	    IF (T < 110) DT = 5;
	    ELSE IF (T == 110) DT = 40;
	    ELSE DT = 50;
	    
	    IF (R < Pt100[i])
	    {
		T = T + (R - Pt100[i - 1]) * DT / (Pt100[i] - Pt100[i - 1]);
		GoOn = false;
	    }
	    ELSE T = T + DT;
	}
 
    RETURN T;
}


DEFINE_START

ClimtZns[1].TemprtrIcpInChnIndx = 0; ClimtZns[1].DamperIcpOutChnIndx = 0; // Index
ClimtZns[2].TemprtrIcpInChnIndx = 1; ClimtZns[2].DamperIcpOutChnIndx = 4; // Гостинная
ClimtZns[3].TemprtrIcpInChnIndx = 1; ClimtZns[3].DamperIcpOutChnIndx = 4; // Кухня
ClimtZns[4].TemprtrIcpInChnIndx = 2; ClimtZns[4].DamperIcpOutChnIndx = 2; // Спальня
ClimtZns[5].TemprtrIcpInChnIndx = 3; ClimtZns[5].DamperIcpOutChnIndx = 1; // Детская
ClimtZns[6].TemprtrIcpInChnIndx = 4; ClimtZns[6].DamperIcpOutChnIndx = 3; // Кабинет
ClimtZns[7].TemprtrIcpInChnIndx = 0; ClimtZns[7].DamperIcpOutChnIndx = 0; // Ванная
ClimtZns[8].TemprtrIcpInChnIndx = 0; ClimtZns[8].DamperIcpOutChnIndx = 0; // Прихожая

TIMELINE_CREATE (TimeLineId_TmprtrRefresh, TimeLineArr_TmprtrRefresh, 1, TIMELINE_ABSOLUTE, TIMELINE_REPEAT);


DEFINE_EVENT

TIMELINE_EVENT[TimeLineId_TmprtrRefresh]
{
    CALL 'TemprtrRefresh';
}


BUTTON_EVENT[TpClimt, 1]
{
    RELEASE:
    {
	IF (KomfStat.IsWork == true) CALL 'SetKomfPwr' (KomfPwrOff);
	ELSE CALL 'SetKomfPwr' (KomfPwrOn);
    }
}


BUTTON_EVENT[TpClimt, 12]
{
    RELEASE:
    {
	IF (KomfStat.IsWork == true)
	    CALL 'SetKomfVentLvl' (KomfStat.VentLvl - 1);
    }
}


BUTTON_EVENT[TpClimt, 11]
{
    RELEASE:
    {
	IF (KomfStat.IsWork == true)
	    CALL 'SetKomfVentLvl' (KomfStat.VentLvl + 1);
    }
}


BUTTON_EVENT[TpClimt, 22]
{
    RELEASE:
    {
	IF (KomfStat.IsWork == true)
	    CALL 'SetKomfSetpntTmprtr' (KomfStat.SetpntTmprtr - 1);
    }
}


BUTTON_EVENT[TpClimt, 21]
{
    RELEASE:
    {
	IF (KomfStat.IsWork == true)
	    CALL 'SetKomfSetpntTmprtr' (KomfStat.SetpntTmprtr + 1);
    }
}


BUTTON_EVENT[TpClimt, 42]
{
    RELEASE:
    {
	INTEGER DamperIcpOutChnIndx;
	SINTEGER DamperVal;
	DamperIcpOutChnIndx = ClimtZns[TpStats[Button.Input.Device.Number - 10000].CurrPg].DamperIcpOutChnIndx;
	IF (DamperIcpOutChnIndx != 0)
	{
	    DamperVal = IcpOutAnChnVals[DamperIcpOutChnIndx] / 3276;
	    DamperVal--;
	    IF (DamperVal < 0) DamperVal = 0;
	    
	    CALL 'SetIcpOutAnChnVal' (DamperIcpOutChnIndx, DamperVal * 3276);
	}
    }
}


BUTTON_EVENT[TpClimt, 41]
{
    RELEASE:
    {
	INTEGER DamperIcpOutChnIndx;
	SINTEGER DamperVal;
	DamperIcpOutChnIndx = ClimtZns[TpStats[Button.Input.Device.Number - 10000].CurrPg].DamperIcpOutChnIndx;
	IF (DamperIcpOutChnIndx != 0)
	{
	    DamperVal = IcpOutAnChnVals[DamperIcpOutChnIndx] / 3276;
	    DamperVal++;
	    IF (DamperVal > 10) DamperVal = 10;
	    
	    CALL 'SetIcpOutAnChnVal' (DamperIcpOutChnIndx, DamperVal * 3276);
	}
    }
}