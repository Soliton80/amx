PROGRAM_NAME = 'dimctrl'


DEFINE_CONSTANT

INTEGER DimBlcksCnt = 15;

INTEGER DimBtnHldTime = 2;


DEFINE_TYPE

STRUCTURE SDimBtn
{
    INTEGER IcpInChnIndx;
    INTEGER LstStat;
    INTEGER HldTime;
}


STRUCTURE SDimBlck
{
    SDimBtn UpBtn;
    SDimBtn DownBtn;
    INTEGER DimChnIndx;
}


DEFINE_VARIABLE

DEVCHAN TpDimChns[] = {{Tp1Dims, 1}, {Tp1Dims, 2}, {Tp1Dims, 3}, {Tp1Dims, 4}, {Tp1Dims, 5}, {Tp1Dims, 6}, {Tp1Dims, 7}, {Tp1Dims, 8}, {Tp1Dims, 9}, {Tp1Dims, 10}, {Tp1Dims, 11}, {Tp1Dims, 12}, {Tp1Dims, 13}, {Tp1Dims, 14}, {Tp1Dims, 15},
		       {Tp2Dims, 1}, {Tp2Dims, 2}, {Tp2Dims, 3}, {Tp2Dims, 4}, {Tp2Dims, 5}, {Tp2Dims, 6}, {Tp2Dims, 7}, {Tp2Dims, 8}, {Tp2Dims, 9}, {Tp2Dims, 10}, {Tp2Dims, 11}, {Tp2Dims, 12}, {Tp2Dims, 13}, {Tp2Dims, 14}, {Tp2Dims, 15},
		       {Tp3Dims, 1}, {Tp3Dims, 2}, {Tp3Dims, 3}, {Tp3Dims, 4}, {Tp3Dims, 5}, {Tp3Dims, 6}, {Tp3Dims, 7}, {Tp3Dims, 8}, {Tp3Dims, 9}, {Tp3Dims, 10}, {Tp3Dims, 11}, {Tp3Dims, 12}, {Tp3Dims, 13}, {Tp3Dims, 14}, {Tp3Dims, 15}};

VOLATILE SDimBlck DimBlcks[DimBlcksCnt];

VOLATILE INTEGER TpDimBlckAssocs[TpsCnt];

VOLATILE INTEGER LightLvlSyncChngd;


DEFINE_CALL 'CheckDimWallBtns'
{
    INTEGER i;
    FOR (i = 1; i <= DimBlcksCnt; i++)
    {
        // Check and update hold time for up button
        IF (DimBlcks[i].UpBtn.LstStat == 1 && IcpInDiChnVals[DimBlcks[i].UpBtn.IcpInChnIndx] == 1)
            DimBlcks[i].UpBtn.HldTime++;
        
        // Check and update hold time for down button
        IF (DimBlcks[i].DownBtn.LstStat == 1 && IcpInDiChnVals[DimBlcks[i].DownBtn.IcpInChnIndx] == 1)
            DimBlcks[i].DownBtn.HldTime++;
        
        // Handle release of up button
        IF (DimBlcks[i].UpBtn.LstStat == 1 && IcpInDiChnVals[DimBlcks[i].UpBtn.IcpInChnIndx] == 0)
        {
            IF (DimBlcks[i].UpBtn.HldTime < DimBtnHldTime)
                CALL 'PressTurnOnDimBtn' (i);
            ELSE
                CALL 'ReleaseUpDimBtn' (i);
            
            DimBlcks[i].UpBtn.HldTime = 0;
        }
        
        // Handle release of down button
        IF (DimBlcks[i].DownBtn.LstStat == 1 && IcpInDiChnVals[DimBlcks[i].DownBtn.IcpInChnIndx] == 0)
        {
            IF (DimBlcks[i].DownBtn.HldTime < DimBtnHldTime)
                CALL 'PressTurnOffDimBtn' (i);
            ELSE
                CALL 'ReleaseDownDimBtn' (i);
            
            DimBlcks[i].DownBtn.HldTime = 0;
        }
        
        // Handle hold time reaching threshold for up button
        IF (DimBlcks[i].UpBtn.HldTime == DimBtnHldTime)
            CALL 'PressUpDimBtn' (i);
        
        // Handle hold time reaching threshold for down button
        IF (DimBlcks[i].DownBtn.HldTime == DimBtnHldTime)
            CALL 'PressDownDimBtn' (i);
        
        // Update last status
        DimBlcks[i].UpBtn.LstStat = IcpInDiChnVals[DimBlcks[i].UpBtn.IcpInChnIndx];
        DimBlcks[i].DownBtn.LstStat = IcpInDiChnVals[DimBlcks[i].DownBtn.IcpInChnIndx];
    }
}


// checks the status of wall buttons and updates their hold times, 
// calls other functions based on the button status and hold time

DEFINE_CALL 'TpDimsRefresh'
{
    INTEGER i;
    FOR (i = 1; i <= DimBlcksCnt; i++)
    {
        IF (DimChnStats[DimBlcks[i].DimChnIndx].CurrPwr > 0) ON [TpDims, i];
        ELSE OFF [TpDims, i];
    }
}


DEFINE_CALL 'PressTurnOnDimBtn' (INTEGER DimBlckIndx)
{
    IF (DimChnStats[DimBlcks[DimBlckIndx].DimChnIndx].CurrPwr == 0)
	CALL 'TurnOnDimChn' (DimBlcks[DimBlckIndx].DimChnIndx);
}


DEFINE_CALL 'PressTurnOffDimBtn' (INTEGER DimBlckIndx)
{
    IF (DimChnStats[DimBlcks[DimBlckIndx].DimChnIndx].CurrPwr > 0)
	CALL 'TurnOffDimChn' (DimBlcks[DimBlckIndx].DimChnIndx);
}


DEFINE_CALL 'PressUpDimBtn' (INTEGER DimBlckIndx)
{
    CALL 'SetDimChnPwr' (DimBlcks[DimBlckIndx].DimChnIndx, 127, DimSpd_Pr);
}


DEFINE_CALL 'PressDownDimBtn' (INTEGER DimBlckIndx)
{
    CALL 'SetDimChnPwr' (DimBlcks[DimBlckIndx].DimChnIndx, 0, DimSpd_Pr);
}


DEFINE_CALL 'ReleaseUpDimBtn' (INTEGER DimBlckIndx)
{
    CALL 'StopDimChnPwrChng' (DimBlcks[DimBlckIndx].DimChnIndx);
}


DEFINE_CALL 'ReleaseDownDimBtn' (INTEGER DimBlckIndx)
{
    CALL 'StopDimChnPwrChng' (DimBlcks[DimBlckIndx].DimChnIndx);
}


DEFINE_START

//This section initializes the DimBlcks array with specific channel indices and dimmer channel indices.

DimBlcks[ 1].UpBtn.IcpInChnIndx =  69; DimBlcks[ 1].DownBtn.IcpInChnIndx =  71; DimBlcks[ 1].DimChnIndx = 4; // Зал
DimBlcks[ 2].UpBtn.IcpInChnIndx =  65; DimBlcks[ 2].DownBtn.IcpInChnIndx =  66; DimBlcks[ 2].DimChnIndx = 1; // Кухня
DimBlcks[ 3].UpBtn.IcpInChnIndx =  97; DimBlcks[ 3].DownBtn.IcpInChnIndx =  98; DimBlcks[ 3].DimChnIndx = 4; // Зал
DimBlcks[ 4].UpBtn.IcpInChnIndx = 101; DimBlcks[ 4].DownBtn.IcpInChnIndx = 102; DimBlcks[ 4].DimChnIndx = 1; // Кухня
DimBlcks[ 5].UpBtn.IcpInChnIndx =  89; DimBlcks[ 5].DownBtn.IcpInChnIndx =  90; DimBlcks[ 5].DimChnIndx = 6; // Спальня
DimBlcks[ 6].UpBtn.IcpInChnIndx =  93; DimBlcks[ 6].DownBtn.IcpInChnIndx =  94; DimBlcks[ 6].DimChnIndx = 9; // Спальня (бра 1)
DimBlcks[ 7].UpBtn.IcpInChnIndx = 117; DimBlcks[ 7].DownBtn.IcpInChnIndx = 119; DimBlcks[ 7].DimChnIndx = 8; // Спальня (бра 2)
DimBlcks[ 8].UpBtn.IcpInChnIndx = 118; DimBlcks[ 8].DownBtn.IcpInChnIndx = 120; DimBlcks[ 8].DimChnIndx = 7; // Спальня (бра 3)
DimBlcks[ 9].UpBtn.IcpInChnIndx = 115; DimBlcks[ 9].DownBtn.IcpInChnIndx = 116; DimBlcks[ 9].DimChnIndx = 8; // Спальня (бра 2)
DimBlcks[10].UpBtn.IcpInChnIndx = 113; DimBlcks[10].DownBtn.IcpInChnIndx = 114; DimBlcks[10].DimChnIndx = 7; // Спальня (бра 3)
DimBlcks[11].UpBtn.IcpInChnIndx =  77; DimBlcks[11].DownBtn.IcpInChnIndx =  78; DimBlcks[11].DimChnIndx = 2; // Детская
DimBlcks[12].UpBtn.IcpInChnIndx =  73; DimBlcks[12].DownBtn.IcpInChnIndx =  74; DimBlcks[12].DimChnIndx = 3; // Детская (бра)
DimBlcks[13].UpBtn.IcpInChnIndx =  81; DimBlcks[13].DownBtn.IcpInChnIndx =  82; DimBlcks[13].DimChnIndx = 3; // Детская (бра)
DimBlcks[14].UpBtn.IcpInChnIndx = 133; DimBlcks[14].DownBtn.IcpInChnIndx = 134; DimBlcks[14].DimChnIndx = 5; // Ванная
DimBlcks[15].UpBtn.IcpInChnIndx =  20; DimBlcks[15].DownBtn.IcpInChnIndx =  19; DimBlcks[15].DimChnIndx = 5; // Ванная


DEFINE_EVENT


// This event handles the online and offline status of touch panels.
// When a touch panel goes online, it refreshes the dimmer channels.
// When a touch panel goes offline, it resets the association.

DATA_EVENT[TpPgs]
{
    ONLINE:
    {
	CALL 'TpDimsRefresh';
    }
    
    OFFLINE:
    {
	TpDimBlckAssocs[Data.Device.Number - 10000] = 0;
    }
}


// This event handles the release of buttons on the touch panel dimmer channels.
// It sends the current power level to the touch panel and updates the association.

BUTTON_EVENT[TpDimChns]
{
    RELEASE:
    {
	SEND_LEVEL Button.Input.Device, 100, DimChnStats[DimBlcks[Button.Input.Channel].DimChnIndx].CurrPwr;
	SEND_COMMAND Button.Input.Device, "'^TXT-110,0,', ITOA(DimChnStats[DimBlcks[Button.Input.Channel].DimChnIndx].CurrPwr * 100 / 127), '%'";
	SEND_COMMAND Button.Input.Device, 'PPON-Mask';
	SEND_COMMAND Button.Input.Device, 'PPON-LightLevelPopup';
	
	TpDimBlckAssocs[Button.Input.Device.Number - 10000] = Button.Input.Channel;
    }
}


LEVEL_EVENT[TpDims, 100]
{
    IF (TpStats[Level.Input.Device.Number - 10000].TpOnline == true)
	IF (LightLvlSyncChngd == false)
	{
	    SEND_COMMAND Level.Input.Device, "'^TXT-110,0,', ITOA(Level.Value * 100 / 127), '%'";
	    
	    CALL 'SetDimChnPwr' (DimBlcks[TpDimBlckAssocs[Level.Input.Device.Number - 10000]].DimChnIndx, Level.Value, DimSpd_Tp);
	}
	ELSE
	    LightLvlSyncChngd = false;
}


BUTTON_EVENT[TpDims, 101]
{
    RELEASE:
    {
	IF (DimChnStats[DimBlcks[TpDimBlckAssocs[Button.Input.Device.Number - 10000]].DimChnIndx].CurrPwr == 0)
	{
	    LightLvlSyncChngd = true;
	    SEND_LEVEL Button.Input.Device, 100, DimChnStats[DimBlcks[TpDimBlckAssocs[Button.Input.Device.Number - 10000]].DimChnIndx].ProgPwr;
	    SEND_COMMAND Button.Input.Device, "'^TXT-110,0,', ITOA(DimChnStats[DimBlcks[TpDimBlckAssocs[Button.Input.Device.Number - 10000]].DimChnIndx].ProgPwr * 100 / 127), '%'";
	}

	CALL 'PressTurnOnDimBtn' (TpDimBlckAssocs[Button.Input.Device.Number - 10000]);
    }
}


BUTTON_EVENT[TpDims, 102]
{
    RELEASE:
    {
	IF (DimChnStats[DimBlcks[TpDimBlckAssocs[Button.Input.Device.Number - 10000]].DimChnIndx].CurrPwr > 0)
	{
	    LightLvlSyncChngd = true;
	    SEND_LEVEL Button.Input.Device, 100, 0;
	    SEND_COMMAND Button.Input.Device, "'^TXT-110,0,0%'";
	}

	CALL 'PressTurnOffDimBtn' (TpDimBlckAssocs[Button.Input.Device.Number - 10000]);
    }
}


BUTTON_EVENT[TpDims, 103]
{
    RELEASE:
    {
	SEND_COMMAND Button.Input.Device, 'PPOF-LightLevelPopup';
	SEND_COMMAND Button.Input.Device, 'PPOF-Mask';
	
	TpDimBlckAssocs[Button.Input.Device.Number - 10000] = 0;
    }
}
