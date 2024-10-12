PROGRAM_NAME = 'dim'


DEFINE_CONSTANT

INTEGER DimChnsCnt = 10;

INTEGER DimSpd_Pr = 9;
INTEGER DimSpd_Swtch = 12;
INTEGER DimSpd_Tp = 15;


DEFINE_TYPE

STRUCTURE SDimChnStat
{
	INTEGER CurrPwr;
	INTEGER ProgPwr;
}


DEFINE_VARIABLE

VOLATILE SDimChnStat DimChnStats[DimChnsCnt];

//Опрос состояния каналов диммера
DEFINE_CALL 'GetDimChnPwrs'
{
	SEND_STRING Dim, "$A4, $71, $00";
}


DEFINE_CALL 'ParseDimRespon' (CHAR Respon[])
{
	INTEGER i;
	FOR (i = 1; i <= DimChnsCnt; i++)
	DimChnStats[i].CurrPwr = Respon[i + 3];
}

//Задание мощности для канала
DEFINE_CALL 'SetDimChnPwr' (INTEGER ChnIndx, INTEGER ChnPwr, INTEGER Spd)
{
	SEND_STRING Dim, "$A4, $03, ChnIndx - 1, ChnPwr, Spd";
	
	WAIT (1) { CALL 'GetDimChnPwrs'; }
}

//Остановить изменения мощности для канала
DEFINE_CALL 'StopDimChnPwrChng' (INTEGER ChnIndx)
{
	SEND_STRING Dim, "$A4, $11, ChnIndx - 1";
	
	WAIT (1) { CALL 'GetDimChnPwrs'; }
}

//Задание мощности для канала(из памяти)
DEFINE_CALL 'TurnOnDimChn' (INTEGER ChnIndx)
{
	DimChnStats[ChnIndx].CurrPwr = DimChnStats[ChnIndx].ProgPwr;
	CALL 'TpDimsRefresh';
	
	SEND_STRING Dim, "$A4, $03, ChnIndx - 1, DimChnStats[ChnIndx].ProgPwr, DimSpd_Swtch";
}

//Установка мощности для канала в 0
DEFINE_CALL 'TurnOffDimChn' (INTEGER ChnIndx)
{
	SEND_STRING 0, "'TurnOffDimChn', ChnIndx"
	DimChnStats[ChnIndx].ProgPwr = DimChnStats[ChnIndx].CurrPwr;
	DimChnStats[ChnIndx].CurrPwr = 0;
	CALL 'TpDimsRefresh';
	
	SEND_STRING Dim, "$A4, $03, ChnIndx - 1, $00, DimSpd_Swtch";
}

//Выключить весь свет
DEFINE_CALL 'TurnOffAllDimChn' ()
{
	INTEGER i;
	for (i=1; i<=DimChnsCnt; i++)
	{
		CALL 'TurnOffDimChn'(i)
	}
}

DEFINE_START

SEND_COMMAND Dim, 'SET BAUD 9600, N, 8, 1';

WAIT (3)
{
	CALL 'GetDimChnPwrs';
}


DEFINE_EVENT

DATA_EVENT[Dim]
{
	STRING:
	{
		CALL 'ParseDimRespon' (Data.Text);
		
		CALL 'TpDimsRefresh';
	}
}

