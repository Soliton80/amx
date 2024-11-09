PROGRAM_NAME = 'switch'

DEFINE_CONSTANT

INTEGER SwitchBlcksCnt = 7;

DEFINE_TYPE
STRUCTURE SSwitchBlck
{
	INTEGER BtnIcpInChnIndx;
	INTEGER BtnLstStat;
	CHAR BtnFunction[32];
}

DEFINE_VARIABLE
VOLATILE SSwitchBlck SwitchBlcks[SwitchBlcksCnt];

DEFINE_CALL 'CheckSwitchWallBtns'
{
	INTEGER i;
	FOR (i = 1; i <= SwitchBlcksCnt; i++)
	{
		IF (SwitchBlcks[i].BtnLstStat == 1 && IcpInDiChnVals[SwitchBlcks[i].BtnIcpInChnIndx] == 0)
		CALL 'PressSwitchBtn' (i);
		
		SwitchBlcks[i].BtnLstStat = IcpInDiChnVals[SwitchBlcks[i].BtnIcpInChnIndx];
	}
}

DEFINE_START

SwitchBlcks[1].BtnIcpInChnIndx = 16;  SwitchBlcks[1].BtnFunction = 'TurnOffAllLights';
SwitchBlcks[2].BtnIcpInChnIndx = 15;  SwitchBlcks[2].BtnFunction = 'TurnOffAllLights';
SwitchBlcks[3].BtnIcpInChnIndx = 104;  SwitchBlcks[3].BtnFunction = 'TurnOffAllLights';
SwitchBlcks[4].BtnIcpInChnIndx = 12;  SwitchBlcks[4].BtnFunction = 'TurnOnAllLights';
SwitchBlcks[5].BtnIcpInChnIndx = 11;  SwitchBlcks[5].BtnFunction = 'TurnOnAllLights';
SwitchBlcks[6].BtnIcpInChnIndx = 103;  SwitchBlcks[6].BtnFunction = 'TurnOnAllLights';
SwitchBlcks[7].BtnIcpInChnIndx = 34;  SwitchBlcks[7].BtnFunction = 'BedroomLightOff';



DEFINE_CALL 'PressSwitchBtn' (INTEGER SwitchBlckIndx)
{
	CALL 'ExecuteSwitchFunction' (SwitchBlcks[SwitchBlckIndx].BtnFunction);
}

DEFINE_CALL 'ExecuteSwitchFunction' (CHAR functionName[])
{   
	SEND_STRING AmxConsole, "'ExecuteSwitchFunction - ', functionName";
	IF (functionName == 'TurnOffAllLights')
	{
		CALL 'TurnOffAllLights'();
	}
	ELSE IF (functionName == 'TurnOnAllLights')
	{
		CALL 'TurnOnAllLights'();
	}
	ELSE IF (functionName == 'BedroomLightOff')
	{
		CALL 'BedroomLightOff'();
	}
}

DEFINE_CALL 'TurnOffAllRelayChn' ()
{
	INTEGER i;
	FOR (i = 1; i <= RelayBlcksCnt; i++)
	{
		CALL 'SetIcpOutDiChnVal' (RelayBlcks[i].RelayIcpOutChnIndx, 0);
	}
}

DEFINE_CALL 'TurnOnAllRelayChn' ()
{
	INTEGER i;
	FOR (i = 1; i <= RelayBlcksCnt; i++)
	{
		CALL 'SetIcpOutDiChnVal' (RelayBlcks[i].RelayIcpOutChnIndx, 1);
	}
}

DEFINE_CALL 'BedroomLightOff' ()
{
	CALL 'SetIcpOutDiChnVal' (4, 0);
	CAlL 'TurnOffDimChn' (6);
	CAlL 'TurnOffDimChn' (7);
	CAlL 'TurnOffDimChn' (8);
	CAlL 'TurnOffDimChn' (9);
}
DEFINE_CALL 'BedroomLightOn' ()
{
	CALL 'SetIcpOutDiChnVal' (4, 1);
	CAlL 'TurnOnFullDimChn' (6);
	CAlL 'TurnOnFullDimChn' (7);
	CAlL 'TurnOnFullDimChn' (8);
	CAlL 'TurnOnFullDimChn' (9);
}

DEFINE_CALL 'KitchenLightOff' ()
{
	CAlL 'TurnOffDimChn' (1);
}
DEFINE_CALL 'KitchenLightOn' ()
{
	CAlL 'TurnOnFullDimChn' (1);
}

DEFINE_CALL 'LivingRoomLightOff' ()
{
	CAlL 'TurnOffDimChn' (4);
}
DEFINE_CALL 'LivingRoomLightOn' ()
{
	CAlL 'TurnOnFullDimChn' (4);
}

DEFINE_CALL 'KabinetLightOff' ()
{
	CALL 'SetIcpOutDiChnVal' (5, 0);
}
DEFINE_CALL 'KabinetLightOn' ()
{
	CALL 'SetIcpOutDiChnVal' (5, 1);
}

DEFINE_CALL 'ChildRoomLightOff' ()
{
	CAlL 'TurnOffDimChn' (2);
	CAlL 'TurnOffDimChn' (3);
	CALL 'SetIcpOutDiChnVal' (7, 0);
	
}
DEFINE_CALL 'ChildRoomLightOn' ()
{
	CAlL 'TurnOnFullDimChn' (2);
	CAlL 'TurnOnFullDimChn' (3);
	CALL 'SetIcpOutDiChnVal' (7, 1);
	
}

DEFINE_CALL 'HallLightOff' ()
{
	CALL 'SetIcpOutDiChnVal' (6, 0);
	CALL 'SetIcpOutDiChnVal' (1, 0);
	CALL 'SetIcpOutDiChnVal' (2, 0);
}
DEFINE_CALL 'HallLightOn' ()
{
	CALL 'SetIcpOutDiChnVal' (6, 1);
	CALL 'SetIcpOutDiChnVal' (1, 1);
	CALL 'SetIcpOutDiChnVal' (2, 1);
}

DEFINE_CALL 'BathLightOff' ()
{
	CAlL 'TurnOffDimChn' (5);
	CALL 'SetIcpOutDiChnVal' (8, 0);
}
DEFINE_CALL 'BathLightOn' ()
{
	CAlL 'TurnOnFullDimChn' (5);
	CALL 'SetIcpOutDiChnVal' (8, 1);
}


DEFINE_CALL 'LivingRoomKitchenLightOff' ()
{
	CAlL 'KitchenLightOff' ();
	CAlL 'LivingRoomLightOff' ();
}
DEFINE_CALL 'LivingRoomKitchenLightOn' ()
{
	CAlL 'KitchenLightOn' ();
	CAlL 'LivingRoomLightOn' ();
}


DEFINE_CALL 'TurnOffAllLights' ()
{
	CALL 'TurnOffAllRelayChn'();
	CALL 'TurnOffAllDimChn'();
}

DEFINE_CALL 'TurnOnAllLights' ()
{
	CALL 'TurnOnAllRelayChn'();
	CALL 'TurnOnAllDimChn'();
}




