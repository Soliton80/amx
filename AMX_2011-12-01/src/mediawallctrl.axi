PROGRAM_NAME = 'mediawallctrl'


DEFINE_CONSTANT

INTEGER MediaWallBlcksCnt = 3;


DEFINE_TYPE

STRUCTURE SMediaWallBlck
{
    INTEGER PwrBtn1IcpInChnIndx;
    INTEGER PwrBtn1LstStat;
    INTEGER PwrBtn2IcpInChnIndx;
    INTEGER PwrBtn2LstStat;
    INTEGER VolUpBtnIcpInChnIndx;
    INTEGER VolDownBtnIcpInChnIndx;
    INTEGER SetZnStatBtn1IcpInChnIndx;
    INTEGER SetZnStatBtn1LstStat;
    INTEGER SetZnStatBtn2IcpInChnIndx;
    INTEGER SetZnStatBtn2LstStat;
    INTEGER NextBtnIcpInChnIndx;
    INTEGER NextBtnLstStat;
    INTEGER PrevBtnIcpInChnIndx;
    INTEGER PrevBtnLstStat;
    INTEGER ZnIndx;
}


DEFINE_VARIABLE

VOLATILE SMediaWallBlck MediaWallBlcks[MediaWallBlcksCnt];


DEFINE_CALL 'CheckMediaWallBtns'
{
    INTEGER i;
    FOR (i = 1; i <= MediaWallBlcksCnt; i++)
    {
	IF (MediaWallBlcks[i].PwrBtn1LstStat == 1 && IcpInDiChnVals[MediaWallBlcks[i].PwrBtn1IcpInChnIndx] == 0 ||
	    MediaWallBlcks[i].PwrBtn2LstStat == 1 && IcpInDiChnVals[MediaWallBlcks[i].PwrBtn2IcpInChnIndx] == 0)
	    CALL 'PressPwrMediaWallBtn' (MediaWallBlcks[i].ZnIndx);
    
	IF (IcpInDiChnVals[MediaWallBlcks[i].VolUpBtnIcpInChnIndx] == 1)
	    CALL 'PressVolUpMediaWallBtn' (MediaWallBlcks[i].ZnIndx);
	
	IF (IcpInDiChnVals[MediaWallBlcks[i].VolDownBtnIcpInChnIndx] == 1)
	    CALL 'PressVolDownMediaWallBtn' (MediaWallBlcks[i].ZnIndx);
    
	IF (MediaWallBlcks[i].SetZnStatBtn1LstStat == 1 && IcpInDiChnVals[MediaWallBlcks[i].SetZnStatBtn1IcpInChnIndx] == 0 ||
	    MediaWallBlcks[i].SetZnStatBtn2LstStat == 1 && IcpInDiChnVals[MediaWallBlcks[i].SetZnStatBtn2IcpInChnIndx] == 0)
	    CALL 'PressSetZnStatMediaWallBtn' (MediaWallBlcks[i].ZnIndx);
	
	IF (MediaWallBlcks[i].NextBtnLstStat == 1 && IcpInDiChnVals[MediaWallBlcks[i].NextBtnIcpInChnIndx] == 0)
	    CALL 'PressNextMediaWallBtn' (MediaWallBlcks[i].ZnIndx);
	
	IF (MediaWallBlcks[i].PrevBtnLstStat == 1 && IcpInDiChnVals[MediaWallBlcks[i].PrevBtnIcpInChnIndx] == 0)
	    CALL 'PressPrevMediaWallBtn' (MediaWallBlcks[i].ZnIndx);

	MediaWallBlcks[i].PwrBtn1LstStat = IcpInDiChnVals[MediaWallBlcks[i].PwrBtn1IcpInChnIndx];
	MediaWallBlcks[i].PwrBtn2LstStat = IcpInDiChnVals[MediaWallBlcks[i].PwrBtn2IcpInChnIndx];
	MediaWallBlcks[i].SetZnStatBtn1LstStat = IcpInDiChnVals[MediaWallBlcks[i].SetZnStatBtn1IcpInChnIndx];
	MediaWallBlcks[i].SetZnStatBtn2LstStat = IcpInDiChnVals[MediaWallBlcks[i].SetZnStatBtn2IcpInChnIndx];
	MediaWallBlcks[i].NextBtnLstStat = IcpInDiChnVals[MediaWallBlcks[i].NextBtnIcpInChnIndx];
	MediaWallBlcks[i].PrevBtnLstStat = IcpInDiChnVals[MediaWallBlcks[i].PrevBtnIcpInChnIndx];
    }
}


DEFINE_CALL 'PressPwrMediaWallBtn' (INTEGER ZnIndx)
{
    IF (MediaZnStats[ZnIndx] == FmZnStat || MediaZnStats[ZnIndx] == AudioZnStat)
    {
	CALL 'SetMediaZnStat' (NullZnStat, ZnIndx);
    }
    ELSE IF (MediaZnStats[ZnIndx] == NullZnStat)
    {
	CALL 'SetMediaZnStat' (FmZnStat, ZnIndx);
    }
}


DEFINE_CALL 'PressVolUpMediaWallBtn' (INTEGER ZnIndx)
{
    IF (MediaZnStats[ZnIndx] != NullZnStat)
	CALL 'ChangeIntegVol' (ZnIndx, IntegVolUp);
}


DEFINE_CALL 'PressVolDownMediaWallBtn' (INTEGER ZnIndx)
{
    IF (MediaZnStats[ZnIndx] != NullZnStat)
	CALL 'ChangeIntegVol' (ZnIndx, IntegVolDown);
}


DEFINE_CALL 'PressSetZnStatMediaWallBtn' (INTEGER ZnIndx)
{
    IF (MediaZnStats[ZnIndx] == FmZnStat)
    {
	CALL 'SetMediaZnStat' (AudioZnStat, ZnIndx);
    }
    ELSE IF (MediaZnStats[ZnIndx] == AudioZnStat)
    {
	CALL 'SetMediaZnStat' (FmZnStat, ZnIndx);
    }
}


DEFINE_CALL 'PressNextMediaWallBtn' (INTEGER ZnIndx)
{
    IF (MediaZnStats[ZnIndx] == FmZnStat)
    {
	SINTEGER TunPrst;
	TunPrst = IntegStat.TunPrst + 1;
	IF (TunPrst > IntegTunPrstsCnt) TunPrst = 1;
	
	CALL 'SetIntegTunPrst' (ZnIndx, TunPrst);
    }
    ELSE IF (MediaZnStats[ZnIndx] == AudioZnStat)
    {
	CALL 'XbmcAudioPlayerSkipNext';
    }
}


DEFINE_CALL 'PressPrevMediaWallBtn' (INTEGER ZnIndx)
{
    IF (MediaZnStats[ZnIndx] == FmZnStat)
    {
	SINTEGER TunPrst;
	TunPrst = IntegStat.TunPrst - 1;
	IF (TunPrst < 1) TunPrst = IntegTunPrstsCnt;
	
	CALL 'SetIntegTunPrst' (ZnIndx, TunPrst);
    }
    ELSE IF (MediaZnStats[ZnIndx] == AudioZnStat)
    {
	CALL 'XbmcAudioPlayerSkipPrevious';
    }
}


DEFINE_START

// Зал
MediaWallBlcks[1].PwrBtn1IcpInChnIndx = 49; MediaWallBlcks[1].PwrBtn2IcpInChnIndx = 50;
MediaWallBlcks[1].VolUpBtnIcpInChnIndx = 51; MediaWallBlcks[1].VolDownBtnIcpInChnIndx = 52;
MediaWallBlcks[1].SetZnStatBtn1IcpInChnIndx = 53; MediaWallBlcks[1].SetZnStatBtn2IcpInChnIndx = 54;
MediaWallBlcks[1].NextBtnIcpInChnIndx = 56; MediaWallBlcks[1].PrevBtnIcpInChnIndx = 55;
MediaWallBlcks[1].ZnIndx = 1;

// Спальня
MediaWallBlcks[2].PwrBtn1IcpInChnIndx = 33; MediaWallBlcks[2].PwrBtn2IcpInChnIndx = 34;
MediaWallBlcks[2].VolUpBtnIcpInChnIndx = 35; MediaWallBlcks[2].VolDownBtnIcpInChnIndx = 36;
MediaWallBlcks[2].SetZnStatBtn1IcpInChnIndx = 37; MediaWallBlcks[2].SetZnStatBtn2IcpInChnIndx = 37;
MediaWallBlcks[2].NextBtnIcpInChnIndx = 40; MediaWallBlcks[2].PrevBtnIcpInChnIndx = 39;
MediaWallBlcks[2].ZnIndx = 2;

// Ванная
MediaWallBlcks[3].PwrBtn1IcpInChnIndx = 25; MediaWallBlcks[3].PwrBtn2IcpInChnIndx = 26;
MediaWallBlcks[3].VolUpBtnIcpInChnIndx = 27; MediaWallBlcks[3].VolDownBtnIcpInChnIndx = 28;
MediaWallBlcks[3].SetZnStatBtn1IcpInChnIndx = 29; MediaWallBlcks[3].SetZnStatBtn2IcpInChnIndx = 30;
MediaWallBlcks[3].NextBtnIcpInChnIndx = 32; MediaWallBlcks[3].PrevBtnIcpInChnIndx = 31;
MediaWallBlcks[3].ZnIndx = 3;