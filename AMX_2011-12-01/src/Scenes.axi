PROGRAM_NAME='Scenes'

DEFINE_TYPE

STRUCTURE LightStruct
{
    INTEGER channelIndex
    INTEGER value
}

DEFINE_CONSTANT

DEFINE_VARIABLE

DEVCHAN TpScnChns[] = {{Tp1Scn ,1},  {Tp1Scn ,2},
		       {Tp2Scn, 1},  {Tp2Scn, 2},
		       {Tp3Scn, 1},  {Tp3Scn, 2}};
		       
DEFINE_FUNCTION turnAllLightsOff()
{
    INTEGER dimChnsPower[24]
    INTEGER relayChnsPower[24]
    INTEGER i;
    INTEGER ChnVal[2];
    for(i=1; i<=2; i++){
	ChnVal[i] = 0
    }
    
    for(i = 1; i <= DimChnsCnt; i++) {
	dimChnsPower[i] = 0
	[TpDims, i] = 0
    }
    for(i = 1; i <= RelayBlcksCnt; i++) {
	relayChnsPower[i] = 0
	[TpRelays, i] = 0
    }
    SEND_STRING 0, "'CALL SetIcpOutMultDiChnVal', RelayBlcksCnt, ChnVal";
    CALL 'SetIcpOutMultDiChnVal' (RelayBlcksCnt, ChnVal);
    CALL 'TurnOffAllDimChn' ();
    //setRelayMaltipleChannels(relayChannelsPower)
    //setDimmerMultipleChannels(1, dimmerChannelsPower, 20)
    //setDimmerMultipleChannels(2, dimmerChannelsPower, 20)
}

DEFINE_EVENT
BUTTON_EVENT[TpScn, 1]
{
    RELEASE:
    {
	turnAllLightsOff();
    }
}
