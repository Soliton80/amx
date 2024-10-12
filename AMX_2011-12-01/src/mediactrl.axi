PROGRAM_NAME = 'mediactrl'


DEFINE_CONSTANT

INTEGER NullZnStat = 1;
INTEGER TvZnStat = 2;
INTEGER SatZnStat = 3;
INTEGER XbmcZnStat = 4;
INTEGER AudioZnStat = 5;
INTEGER FmZnStat = 6;

INTEGER MediaZnsCnt = 3;


DEFINE_VARIABLE

DEVCHAN TpMediaChns[] = {{Tp1Media, 1}, {Tp1Media, 2}, {Tp1Media, 3},
			 {Tp2Media, 1}, {Tp2Media, 2}, {Tp2Media, 3},
			 {Tp3Media, 1}, {Tp3Media, 2}, {Tp3Media, 3}};

VOLATILE INTEGER MediaZnStats[MediaZnsCnt];


DEFINE_CALL 'SetMediaZnStat' (INTEGER ZnStat, INTEGER ZnIndx)
{
    IF (MediaZnStats[ZnIndx] == NullZnStat)
    {
	IF (ZnStat == TvZnStat)
	{
	    IF (ZnIndx == 1) CALL 'ExecTvCmd' (TvPwrCmd);
	}
	ELSE IF (ZnStat == SatZnStat)
	{
	    CALL 'SetIntegPwr' (ZnIndx, IntegPwrOn);
	    CALL 'SetIntegIn' (ZnIndx, IntegSatIn);
	    IF (ZnIndx == 1) CALL 'ExecTvCmd' (TvPwrCmd);
	}
	ELSE IF (ZnStat == XbmcZnStat)
	{
	    CALL 'SetIntegPwr' (ZnIndx, IntegPwrOn);
	    CALL 'SetIntegIn' (ZnIndx, IntegMusicServerIn);
	    IF (ZnIndx == 1) CALL 'ExecTvCmd' (TvPwrCmd);
	}
	ELSE IF (ZnStat == AudioZnStat)
	{
	    CALL 'SetIntegPwr' (ZnIndx, IntegPwrOn);
	    CALL 'SetIntegIn' (ZnIndx, IntegMusicServerIn);
	    IF (XbmcStat.AudioPlay == false) CALL 'XbmcAudioPlaylistPlay';
	}
	ELSE IF (ZnStat == FmZnStat)
	{
	    CALL 'SetIntegPwr' (ZnIndx, IntegPwrOn);
	    CALL 'SetIntegIn' (ZnIndx, IntegFmIn);
	}
    }
    ELSE IF (MediaZnStats[ZnIndx] == TvZnStat)
    {
	IF (ZnStat == NullZnStat)
	{
	    IF (ZnIndx == 1) CALL 'ExecTvCmd' (TvPwrCmd);
	}
	ELSE IF (ZnStat == SatZnStat)
	{
	    CALL 'SetIntegPwr' (ZnIndx, IntegPwrOn);
	    CALL 'SetIntegIn' (ZnIndx, IntegSatIn);
	}
	ELSE IF (ZnStat == XbmcZnStat)
	{
	    CALL 'SetIntegPwr' (ZnIndx, IntegPwrOn);
	    CALL 'SetIntegIn' (ZnIndx, IntegMusicServerIn);
	}
	ELSE IF (ZnStat == AudioZnStat)
	{
	    IF (ZnIndx == 1) CALL 'ExecTvCmd' (TvPwrCmd);
	    CALL 'SetIntegPwr' (ZnIndx, IntegPwrOn);
	    CALL 'SetIntegIn' (ZnIndx, IntegMusicServerIn);
	    IF (XbmcStat.AudioPlay == false) CALL 'XbmcAudioPlaylistPlay';
	}
	ELSE IF (ZnStat == FmZnStat)
	{
	    IF (ZnIndx == 1) CALL 'ExecTvCmd' (TvPwrCmd);
	    CALL 'SetIntegPwr' (ZnIndx, IntegPwrOn);
	    CALL 'SetIntegIn' (ZnIndx, IntegFmIn);
	}
    }
    ELSE IF (MediaZnStats[ZnIndx] == SatZnStat)
    {
	IF (ZnStat == NullZnStat)
	{
	    IF (ZnIndx == 1) CALL 'ExecTvCmd' (TvPwrCmd);
	    CALL 'SetIntegPwr' (ZnIndx, IntegPwrOff);
	}
	ELSE IF (ZnStat == TvZnStat)
	{
	    CALL 'SetIntegPwr' (ZnIndx, IntegPwrOff);
	}
	ELSE IF (ZnStat == XbmcZnStat)
	{
	    CALL 'SetIntegIn' (ZnIndx, IntegMusicServerIn);
	}
	ELSE IF (ZnStat == AudioZnStat)
	{
	    IF (ZnIndx == 1) CALL 'ExecTvCmd' (TvPwrCmd);
	    CALL 'SetIntegIn' (ZnIndx, IntegMusicServerIn);
	    IF (XbmcStat.AudioPlay == false) CALL 'XbmcAudioPlaylistPlay';
	}
	ELSE IF (ZnStat == FmZnStat)
	{
	    IF (ZnIndx == 1) CALL 'ExecTvCmd' (TvPwrCmd);
	    CALL 'SetIntegIn' (ZnIndx, IntegFmIn);
	}
    }
    ELSE IF (MediaZnStats[ZnIndx] == XbmcZnStat)
    {
	IF (ZnStat == NullZnStat)
	{
	    IF (ZnIndx == 1) CALL 'ExecTvCmd' (TvPwrCmd);
	    CALL 'SetIntegPwr' (ZnIndx, IntegPwrOff);
	}
	ELSE IF (ZnStat == TvZnStat)
	{
	    CALL 'SetIntegPwr' (ZnIndx, IntegPwrOff);
	}
	ELSE IF (ZnStat == SatZnStat)
	{
	    CALL 'SetIntegIn' (ZnIndx, IntegSatIn);
	}
	ELSE IF (ZnStat == AudioZnStat)
	{
	    IF (ZnIndx == 1) CALL 'ExecTvCmd' (TvPwrCmd);
	    IF (XbmcStat.AudioPlay == false) CALL 'XbmcAudioPlaylistPlay';
	}
	ELSE IF (ZnStat == FmZnStat)
	{
	    IF (ZnIndx == 1) CALL 'ExecTvCmd' (TvPwrCmd);
	    CALL 'SetIntegIn' (ZnIndx, IntegFmIn);
	}
    }
    ELSE IF (MediaZnStats[ZnIndx] == AudioZnStat)
    {
	IF (ZnStat == NullZnStat)
	{
	    CALL 'SetIntegPwr' (ZnIndx, IntegPwrOff);
	}
	ELSE IF (ZnStat == TvZnStat)
	{
	    CALL 'SetIntegPwr' (ZnIndx, IntegPwrOff);
	    IF (ZnIndx == 1) CALL 'ExecTvCmd' (TvPwrCmd);
	}
	ELSE IF (ZnStat == SatZnStat)
	{
	    CALL 'SetIntegIn' (ZnIndx, IntegSatIn);
	    IF (ZnIndx == 1) CALL 'ExecTvCmd' (TvPwrCmd);
	}
	ELSE IF (ZnStat == XbmcZnStat)
	{
	    IF (ZnIndx == 1) CALL 'ExecTvCmd' (TvPwrCmd);
	}
	ELSE IF (ZnStat == FmZnStat)
	{
	    CALL 'SetIntegIn' (ZnIndx, IntegFmIn);
	}
    }
    ELSE IF (MediaZnStats[ZnIndx] == FmZnStat)
    {
	IF (ZnStat == NullZnStat)
	{
	    CALL 'SetIntegPwr' (ZnIndx, IntegPwrOff);
	}
	ELSE IF (ZnStat == TvZnStat)
	{
	    CALL 'SetIntegPwr' (ZnIndx, IntegPwrOff);
	    IF (ZnIndx == 1) CALL 'ExecTvCmd' (TvPwrCmd);
	}
	ELSE IF (ZnStat == SatZnStat)
	{
	    CALL 'SetIntegIn' (ZnIndx, IntegSatIn);
	    IF (ZnIndx == 1) CALL 'ExecTvCmd' (TvPwrCmd);
	}
	ELSE IF (ZnStat == XbmcZnStat)
	{
	    CALL 'SetIntegIn' (ZnIndx, IntegMusicServerIn);
	    IF (ZnIndx == 1) CALL 'ExecTvCmd' (TvPwrCmd);
	}
	ELSE IF (ZnStat == AudioZnStat)
	{
	    CALL 'SetIntegIn' (ZnIndx, IntegMusicServerIn);
	    IF (XbmcStat.AudioPlay == false) CALL 'XbmcAudioPlaylistPlay';
	}
    }
    
    MediaZnStats[ZnIndx] = ZnStat;
    
    IF (ZnStat != NullZnStat) ON [TpMedia, ZnIndx];
    ELSE OFF [TpMedia, ZnIndx];
    
    CALL 'MediaWndZnStatRefresh' (ZnIndx);
}


DEFINE_START

MediaZnStats[1] = NullZnStat; MediaZnStats[2] = NullZnStat; MediaZnStats[3] = NullZnStat;


DEFINE_EVENT

DATA_EVENT[TpPgs]
{
    ONLINE:
    {
	INTEGER i;
	FOR (i = 1; i <= MediaZnsCnt; i++)
	    IF (MediaZnStats[i] != NullZnStat) ON [TpMedia, i];
	    ELSE OFF [TpMedia, i];
    }
}


BUTTON_EVENT[TpMediaChns]
{
    RELEASE:
    {
	CALL 'MediaWndShow' (Button.Input.Device, Button.Input.Channel);
    }
}