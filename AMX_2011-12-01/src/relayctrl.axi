PROGRAM_NAME = 'relayctrl'


DEFINE_CONSTANT

//INTEGER RelayBlcksCnt = 17;
INTEGER RelayBlcksCnt = 21;


DEFINE_TYPE

STRUCTURE SRelayBlck
{
    INTEGER BtnIcpInChnIndx;
    INTEGER BtnLstStat;
    INTEGER RelayIcpOutChnIndx;
}


DEFINE_VARIABLE

DEVCHAN TpRelayChns[] = {{Tp1Relays, 1}, {Tp1Relays, 2}, {Tp1Relays, 3}, {Tp1Relays, 4}, {Tp1Relays, 5}, {Tp1Relays, 6}, {Tp1Relays, 7}, {Tp1Relays, 8}, {Tp1Relays, 9}, {Tp1Relays, 10}, {Tp1Relays, 11}, {Tp1Relays, 12}, {Tp1Relays, 13}, {Tp1Relays, 14}, {Tp1Relays, 15}, {Tp1Relays, 16}, {Tp1Relays, 17},
			 {Tp2Relays, 1}, {Tp2Relays, 2}, {Tp2Relays, 3}, {Tp2Relays, 4}, {Tp2Relays, 5}, {Tp2Relays, 6}, {Tp2Relays, 7}, {Tp2Relays, 8}, {Tp2Relays, 9}, {Tp2Relays, 10}, {Tp2Relays, 11}, {Tp2Relays, 12}, {Tp2Relays, 13}, {Tp2Relays, 14}, {Tp2Relays, 15}, {Tp2Relays, 16}, {Tp2Relays, 17},
			 {Tp3Relays, 1}, {Tp3Relays, 2}, {Tp3Relays, 3}, {Tp3Relays, 4}, {Tp3Relays, 5}, {Tp3Relays, 6}, {Tp3Relays, 7}, {Tp3Relays, 8}, {Tp3Relays, 9}, {Tp3Relays, 10}, {Tp3Relays, 11}, {Tp3Relays, 12}, {Tp3Relays, 13}, {Tp3Relays, 14}, {Tp3Relays, 15}, {Tp3Relays, 16}, {Tp3Relays, 17}};

VOLATILE SRelayBlck RelayBlcks[RelayBlcksCnt];


DEFINE_CALL 'CheckRelayWallBtns'
{
    INTEGER i;
    FOR (i = 1; i <= RelayBlcksCnt; i++)
    {
	IF (RelayBlcks[i].BtnLstStat == 1 && IcpInDiChnVals[RelayBlcks[i].BtnIcpInChnIndx] == 0)
	    CALL 'PressRelayBtn' (i);
	    
	RelayBlcks[i].BtnLstStat = IcpInDiChnVals[RelayBlcks[i].BtnIcpInChnIndx];
    }
}


DEFINE_CALL 'TpRelaysRefresh'
{
    INTEGER i;
    FOR (i = 1; i <= RelayBlcksCnt; i++)
	[TpRelays, i] = IcpOutDiChnVals[RelayBlcks[i].RelayIcpOutChnIndx];
}


DEFINE_CALL 'PressRelayBtn' (INTEGER RelayBlckIndx)
{
    IF (IcpOutDiChnVals[RelayBlcks[RelayBlckIndx].RelayIcpOutChnIndx] == 0)
	CALL 'SetIcpOutDiChnVal' (RelayBlcks[RelayBlckIndx].RelayIcpOutChnIndx, 1);
    ELSE
	CALL 'SetIcpOutDiChnVal' (RelayBlcks[RelayBlckIndx].RelayIcpOutChnIndx, 0);
}


DEFINE_START

RelayBlcks[ 1].BtnIcpInChnIndx =   1; RelayBlcks[ 1].RelayIcpOutChnIndx = 6; // Прихожая (бра)
RelayBlcks[ 2].BtnIcpInChnIndx =   2; RelayBlcks[ 2].RelayIcpOutChnIndx = 6; // Прихожая (бра)
RelayBlcks[ 3].BtnIcpInChnIndx =  72; RelayBlcks[ 3].RelayIcpOutChnIndx = 1; // Прихожая
RelayBlcks[ 4].BtnIcpInChnIndx = 122; RelayBlcks[ 4].RelayIcpOutChnIndx = 4; // Спальня гардеробная
RelayBlcks[ 5].BtnIcpInChnIndx = 121; RelayBlcks[ 5].RelayIcpOutChnIndx = 4; // Спальня гардеробная
RelayBlcks[ 6].BtnIcpInChnIndx =  79; RelayBlcks[ 6].RelayIcpOutChnIndx = 7; // Детская гардеробная
RelayBlcks[ 7].BtnIcpInChnIndx =  80; RelayBlcks[ 7].RelayIcpOutChnIndx = 7; // Детская гардеробная
RelayBlcks[ 8].BtnIcpInChnIndx =  24; RelayBlcks[ 8].RelayIcpOutChnIndx = 8; // Ванная (бра)
RelayBlcks[ 9].BtnIcpInChnIndx =  23; RelayBlcks[ 9].RelayIcpOutChnIndx = 8; // Ванная (бра)
RelayBlcks[10].BtnIcpInChnIndx =  22; RelayBlcks[10].RelayIcpOutChnIndx = 3; // Ванная (вентилятор)
RelayBlcks[11].BtnIcpInChnIndx =  21; RelayBlcks[11].RelayIcpOutChnIndx = 3; // Ванная (вентилятор)
RelayBlcks[12].BtnIcpInChnIndx = 125; RelayBlcks[12].RelayIcpOutChnIndx = 2; // Серверная
RelayBlcks[13].BtnIcpInChnIndx = 126; RelayBlcks[13].RelayIcpOutChnIndx = 2; // Серверная
RelayBlcks[14].BtnIcpInChnIndx = 127; RelayBlcks[14].RelayIcpOutChnIndx = 2; // Серверная
RelayBlcks[15].BtnIcpInChnIndx = 128; RelayBlcks[15].RelayIcpOutChnIndx = 2; // Серверная
RelayBlcks[16].BtnIcpInChnIndx =   5; RelayBlcks[16].RelayIcpOutChnIndx = 1; // Прихожая
RelayBlcks[17].BtnIcpInChnIndx =   6; RelayBlcks[17].RelayIcpOutChnIndx = 1; // Прихожая
RelayBlcks[18].BtnIcpInChnIndx = 109; RelayBlcks[18].RelayIcpOutChnIndx = 5; // Кабинет
RelayBlcks[19].BtnIcpInChnIndx = 110; RelayBlcks[19].RelayIcpOutChnIndx = 5; // Кабинет
RelayBlcks[20].BtnIcpInChnIndx = 136; RelayBlcks[20].RelayIcpOutChnIndx = 8; // Ванная (бра)
RelayBlcks[21].BtnIcpInChnIndx = 135; RelayBlcks[21].RelayIcpOutChnIndx = 8; // Ванная (бра)


DEFINE_EVENT

BUTTON_EVENT[TpRelayChns]
{
    RELEASE:
    {
	CALL 'PressRelayBtn' (Button.Input.Channel);
    }
}
