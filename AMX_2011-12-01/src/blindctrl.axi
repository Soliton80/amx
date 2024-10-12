PROGRAM_NAME = 'blindctrl'


DEFINE_CONSTANT

INTEGER BlindsCnt = 9;

INTEGER BlindGrpsCnt = 7;

INTEGER BlindBtnHldTime = 2;


DEFINE_TYPE

STRUCTURE SBlindEngn
{
    INTEGER BtnIcpInChnIndx;
    INTEGER RelayIcpOutChnIndx;
    INTEGER BtnLstStat;
    INTEGER BtnHldTime;
    INTEGER TpBtnHldFls[TpsCnt];
    INTEGER WrkTime;
}


STRUCTURE SBlind
{
    SBlindEngn OpnEngn;
    SBlindEngn ClsEngn;
    INTEGER FullWrkTime;
}


STRUCTURE SBlindGrp
{
    INTEGER Blind1;
    INTEGER Blind2;
}


DEFINE_VARIABLE

DEVCHAN TpBlindChns[] = {{Tp1Blinds, 1}, {Tp1Blinds, 2}, {Tp1Blinds, 3}, {Tp1Blinds, 4}, {Tp1Blinds, 5}, {Tp1Blinds, 6}, {Tp1Blinds, 7},
			 {Tp2Blinds, 1}, {Tp2Blinds, 2}, {Tp2Blinds, 3}, {Tp2Blinds, 4}, {Tp2Blinds, 5}, {Tp2Blinds, 6}, {Tp2Blinds, 7},
			 {Tp3Blinds, 1}, {Tp3Blinds, 2}, {Tp3Blinds, 3}, {Tp3Blinds, 4}, {Tp3Blinds, 5}, {Tp3Blinds, 6}, {Tp3Blinds, 7}};

VOLATILE SBlind Blinds[BlindsCnt];

VOLATILE SBlindGrp BlindGrps[BlindGrpsCnt];

VOLATILE INTEGER TpBlindAssocs[TpsCnt];

VOLATILE INTEGER TpBlindGrpAssocs[TpsCnt];


DEFINE_CALL 'CheckBlindWallBtns'
{
    INTEGER i;
    FOR (i = 1; i <= BlindsCnt; i++)
    {
	IF (Blinds[i].OpnEngn.BtnLstStat == 1 && IcpInDiChnVals[Blinds[i].OpnEngn.BtnIcpInChnIndx] == 1)
	{
	    Blinds[i].OpnEngn.BtnHldTime++;
	    IF (Blinds[i].OpnEngn.BtnHldTime == BlindBtnHldTime)
		CALL 'PressOpnBlindBtn' (i);
	}
	
	IF (Blinds[i].ClsEngn.BtnLstStat == 1 && IcpInDiChnVals[Blinds[i].ClsEngn.BtnIcpInChnIndx] == 1)
	{
	    Blinds[i].ClsEngn.BtnHldTime++;
	    IF (Blinds[i].ClsEngn.BtnHldTime == BlindBtnHldTime)
		CALL 'PressClsBlindBtn' (i);
	}
	
	IF (Blinds[i].OpnEngn.BtnLstStat == 1 && IcpInDiChnVals[Blinds[i].OpnEngn.BtnIcpInChnIndx] == 0)
	{
	    IF (Blinds[i].OpnEngn.BtnHldTime < BlindBtnHldTime)
		CALL 'PressOpnBlindBtn' (i);
	    ELSE
		CALL 'ReleaseOpnBlindBtn' (i);
	
	    Blinds[i].OpnEngn.BtnHldTime = 0;
	}
	
	IF (Blinds[i].ClsEngn.BtnLstStat == 1 && IcpInDiChnVals[Blinds[i].ClsEngn.BtnIcpInChnIndx] == 0)
	{
	    IF (Blinds[i].ClsEngn.BtnHldTime < BlindBtnHldTime)
		CALL 'PressClsBlindBtn' (i);
	    ELSE
		CALL 'ReleaseClsBlindBtn' (i);
	
	    Blinds[i].ClsEngn.BtnHldTime = 0;
	}
	
	IF (Blinds[i].OpnEngn.WrkTime > 0) Blinds[i].OpnEngn.WrkTime++;
	IF (Blinds[i].ClsEngn.WrkTime > 0) Blinds[i].ClsEngn.WrkTime++;
	
	IF (Blinds[i].OpnEngn.WrkTime >= Blinds[i].FullWrkTime) CALL 'StopOpnBlindEngnWrk' (i);
	IF (Blinds[i].ClsEngn.WrkTime >= Blinds[i].FullWrkTime) CALL 'StopClsBlindEngnWrk' (i);
	
	Blinds[i].OpnEngn.BtnLstStat = IcpInDiChnVals[Blinds[i].OpnEngn.BtnIcpInChnIndx];
	Blinds[i].ClsEngn.BtnLstStat = IcpInDiChnVals[Blinds[i].ClsEngn.BtnIcpInChnIndx];
    }
}


DEFINE_CALL 'PressOpnBlindBtn' (INTEGER BlindIndx)
{
    IF (Blinds[BlindIndx].ClsEngn.WrkTime == 0 &&
	IcpOutDiChnVals[Blinds[BlindIndx].ClsEngn.RelayIcpOutChnIndx] == 0)
	CALL 'StartOpnBlindEngnWrk' (BlindIndx);
    ELSE
	CALL 'StopClsBlindEngnWrk' (BlindIndx);
}


DEFINE_CALL 'PressClsBlindBtn' (INTEGER BlindIndx)
{
    IF (Blinds[BlindIndx].OpnEngn.WrkTime == 0 &&
	IcpOutDiChnVals[Blinds[BlindIndx].OpnEngn.RelayIcpOutChnIndx] == 0)
	CALL 'StartClsBlindEngnWrk' (BlindIndx);
    ELSE
	CALL 'StopOpnBlindEngnWrk' (BlindIndx);
}


DEFINE_CALL 'ReleaseOpnBlindBtn' (INTEGER BlindIndx)
{
    CALL 'StopOpnBlindEngnWrk' (BlindIndx);
}


DEFINE_CALL 'ReleaseClsBlindBtn' (INTEGER BlindIndx)
{
    CALL 'StopClsBlindEngnWrk' (BlindIndx);
}


DEFINE_CALL 'StartOpnBlindEngnWrk' (INTEGER BlindIndx)
{
    Blinds[BlindIndx].OpnEngn.WrkTime = 1;
    CALL 'SetIcpOutDiChnVal' (Blinds[BlindIndx].OpnEngn.RelayIcpOutChnIndx, 1);
}


DEFINE_CALL 'StartClsBlindEngnWrk' (INTEGER BlindIndx)
{
    Blinds[BlindIndx].ClsEngn.WrkTime = 1;
    CALL 'SetIcpOutDiChnVal' (Blinds[BlindIndx].ClsEngn.RelayIcpOutChnIndx, 1);
}


DEFINE_CALL 'StopOpnBlindEngnWrk' (INTEGER BlindIndx)
{
    CALL 'SetIcpOutDiChnVal' (Blinds[BlindIndx].OpnEngn.RelayIcpOutChnIndx, 0);
    Blinds[BlindIndx].OpnEngn.WrkTime = 0;
}


DEFINE_CALL 'StopClsBlindEngnWrk' (INTEGER BlindIndx)
{
    CALL 'SetIcpOutDiChnVal' (Blinds[BlindIndx].ClsEngn.RelayIcpOutChnIndx, 0);
    Blinds[BlindIndx].ClsEngn.WrkTime = 0;
}


DEFINE_START

Blinds[1].OpnEngn.BtnIcpInChnIndx = 105; Blinds[1].OpnEngn.RelayIcpOutChnIndx = 17; // Кабинет
Blinds[1].ClsEngn.BtnIcpInChnIndx = 106; Blinds[1].ClsEngn.RelayIcpOutChnIndx = 18; // Кабинет
Blinds[1].FullWrkTime = 55; // Кабинет
Blinds[2].OpnEngn.BtnIcpInChnIndx = 137; Blinds[2].OpnEngn.RelayIcpOutChnIndx = 13; // Кухня левая
Blinds[2].ClsEngn.BtnIcpInChnIndx = 130; Blinds[2].ClsEngn.RelayIcpOutChnIndx = 14; // Кухня левая
Blinds[2].FullWrkTime = 150; // Кухня 1
Blinds[3].OpnEngn.BtnIcpInChnIndx = 131; Blinds[3].OpnEngn.RelayIcpOutChnIndx = 15; // Кухня правая
Blinds[3].ClsEngn.BtnIcpInChnIndx = 132; Blinds[3].ClsEngn.RelayIcpOutChnIndx = 16; // Кухня правая
Blinds[3].FullWrkTime = 220; // Кухня 2
Blinds[4].OpnEngn.BtnIcpInChnIndx = 103; Blinds[4].OpnEngn.RelayIcpOutChnIndx = 19; // Зал
Blinds[4].ClsEngn.BtnIcpInChnIndx = 104; Blinds[4].ClsEngn.RelayIcpOutChnIndx = 20; // Зал
Blinds[4].FullWrkTime = 55; // Зал
Blinds[5].OpnEngn.BtnIcpInChnIndx = 47; Blinds[5].OpnEngn.RelayIcpOutChnIndx = 10; // Спальня штора
Blinds[5].ClsEngn.BtnIcpInChnIndx = 48; Blinds[5].ClsEngn.RelayIcpOutChnIndx = 9; // Спальня штора
Blinds[5].FullWrkTime = 65; // Спальня 1
Blinds[6].OpnEngn.BtnIcpInChnIndx = 43; Blinds[6].OpnEngn.RelayIcpOutChnIndx = 11; // Спальня тюль
Blinds[6].ClsEngn.BtnIcpInChnIndx = 44; Blinds[6].ClsEngn.RelayIcpOutChnIndx = 12; // Спальня тюль
Blinds[6].FullWrkTime = 55; // Спальня 2
Blinds[7].OpnEngn.BtnIcpInChnIndx = 75; Blinds[7].OpnEngn.RelayIcpOutChnIndx = 21; // Детская
Blinds[7].ClsEngn.BtnIcpInChnIndx = 76; Blinds[7].ClsEngn.RelayIcpOutChnIndx = 22; // Детская
Blinds[7].FullWrkTime = 45; // Детская
Blinds[8].OpnEngn.BtnIcpInChnIndx = 83; Blinds[8].OpnEngn.RelayIcpOutChnIndx = 21; // Детская
Blinds[8].ClsEngn.BtnIcpInChnIndx = 84; Blinds[8].ClsEngn.RelayIcpOutChnIndx = 22; // Детская
Blinds[8].FullWrkTime = 45; // Детская
Blinds[9].OpnEngn.BtnIcpInChnIndx = 41; Blinds[9].OpnEngn.RelayIcpOutChnIndx = 24; // Роль ставня
Blinds[9].ClsEngn.BtnIcpInChnIndx = 42; Blinds[9].ClsEngn.RelayIcpOutChnIndx = 25; // Роль ставня
Blinds[9].FullWrkTime = 100; // Роль ставня

BlindGrps[1].Blind1 = 1; BlindGrps[1].Blind2 = 0; // Кабинет
BlindGrps[2].Blind1 = 4; BlindGrps[2].Blind2 = 0; // Зал
BlindGrps[3].Blind1 = 5; BlindGrps[3].Blind2 = 6; // Спальня
BlindGrps[4].Blind1 = 9; BlindGrps[4].Blind2 = 0; // Роль ставня
BlindGrps[5].Blind1 = 7; BlindGrps[5].Blind2 = 0; // Детская
BlindGrps[6].Blind1 = 2; BlindGrps[6].Blind2 = 0; // Кухня 1
BlindGrps[7].Blind1 = 3; BlindGrps[7].Blind2 = 0; // Кухня 2


DEFINE_EVENT

DATA_EVENT[TpPgs]
{
    OFFLINE:
    {
	TpBlindGrpAssocs[Data.Device.Number - 10000] = 0;
	TpBlindAssocs[Data.Device.Number - 10000] = 0;
    }
}


BUTTON_EVENT[TpBlindChns]
{
    RELEASE:
    {
	INTEGER DevNum;
	DevNum = Button.Input.Device.Number - 10000;

	IF (BlindGrps[Button.Input.Channel].Blind2 != 0)
	{
	    SEND_COMMAND Button.Input.Device, 'PPON-Mask';
	    SEND_COMMAND Button.Input.Device, 'PPON-BlindGrpPopup';
	    
	    TpBlindGrpAssocs[DevNum] = Button.Input.Channel;
	}
	ELSE
	{
	    SEND_COMMAND Button.Input.Device, 'PPON-Mask';
	    SEND_COMMAND Button.Input.Device, 'PPON-BlindPopup';
	    
	    TpBlindAssocs[DevNum] = BlindGrps[Button.Input.Channel].Blind1;
	}
    }
}


BUTTON_EVENT[TpBlinds, 101]
{
    RELEASE:
    {
	INTEGER DevNum;
	DevNum = Button.Input.Device.Number - 10000;
	
	TpBlindAssocs[DevNum] = BlindGrps[TpBlindGrpAssocs[DevNum]].Blind1;
	TpBlindGrpAssocs[DevNum] = 0;
	
	SEND_COMMAND Button.Input.Device, 'PPOF-BlindGrpPopup';
	SEND_COMMAND Button.Input.Device, 'PPON-BlindPopup';
    }
}


BUTTON_EVENT[TpBlinds, 102]
{
    RELEASE:
    {
	INTEGER DevNum;
	DevNum = Button.Input.Device.Number - 10000;
	
	TpBlindAssocs[DevNum] = BlindGrps[TpBlindGrpAssocs[DevNum]].Blind2;
	TpBlindGrpAssocs[DevNum] = 0;
	
	SEND_COMMAND Button.Input.Device, 'PPOF-BlindGrpPopup';
	SEND_COMMAND Button.Input.Device, 'PPON-BlindPopup';
    }
}


BUTTON_EVENT[TpBlinds, 103]
{
    RELEASE:
    {
	TpBlindGrpAssocs[Button.Input.Device.Number - 10000] = 0;

	SEND_COMMAND Button.Input.Device, 'PPOF-BlindGrpPopup';
	SEND_COMMAND Button.Input.Device, 'PPOF-Mask';
    }
}


BUTTON_EVENT[TpBlinds, 111]
{
    HOLD [6]:
    {
	INTEGER DevNum;
	INTEGER BlindIndx;
	DevNum = Button.Input.Device.Number - 10000;
	BlindIndx = TpBlindAssocs[DevNum];

	Blinds[BlindIndx].OpnEngn.TpBtnHldFls[DevNum] = true;
	
	CALL 'PressOpnBlindBtn' (BlindIndx);
    }

    RELEASE:
    {
	INTEGER DevNum;
	INTEGER BlindIndx;
	DevNum = Button.Input.Device.Number - 10000;
	BlindIndx = TpBlindAssocs[DevNum];

	IF (Blinds[BlindIndx].OpnEngn.TpBtnHldFls[DevNum] == true)
	{
	    CALL 'ReleaseOpnBlindBtn' (BlindIndx);
	    
	    Blinds[BlindIndx].OpnEngn.TpBtnHldFls[DevNum] = false;
	}
	ELSE
	{
	    CALL 'PressOpnBlindBtn' (BlindIndx);
	}
    }
}


BUTTON_EVENT[TpBlinds, 112]
{
    HOLD [6]:
    {
	INTEGER DevNum;
	INTEGER BlindIndx;
	DevNum = Button.Input.Device.Number - 10000;
	BlindIndx = TpBlindAssocs[DevNum];

	Blinds[BlindIndx].ClsEngn.TpBtnHldFls[DevNum] = true;
	
	CALL 'PressClsBlindBtn' (BlindIndx);
    }

    RELEASE:
    {
	INTEGER DevNum;
	INTEGER BlindIndx;
	DevNum = Button.Input.Device.Number - 10000;
	BlindIndx = TpBlindAssocs[DevNum];

	IF (Blinds[BlindIndx].ClsEngn.TpBtnHldFls[DevNum] == true)
	{
	    CALL 'ReleaseClsBlindBtn' (BlindIndx);
	    
	    Blinds[BlindIndx].ClsEngn.TpBtnHldFls[DevNum] = false;
	}
	ELSE
	{
	    CALL 'PressClsBlindBtn' (BlindIndx);
	}
    }
}


BUTTON_EVENT[TpBlinds, 113]
{
    RELEASE:
    {
	TpBlindAssocs[Button.Input.Device.Number - 10000] = 0;

	SEND_COMMAND Button.Input.Device, 'PPOF-BlindPopup';
	SEND_COMMAND Button.Input.Device, 'PPOF-Mask';
    }
}
