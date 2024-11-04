PROGRAM_NAME = 'relayctrl'

DEFINE_CONSTANT

INTEGER RelayBlcksCnt = 21;

DEFINE_TYPE

STRUCTURE SRelayBlck
{
    INTEGER BtnIcpInChnIndx;
    INTEGER BtnLstStat;
    INTEGER RelayIcpOutChnIndx;
}

DEFINE_VARIABLE

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

