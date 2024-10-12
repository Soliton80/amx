PROGRAM_NAME='Gsm'

DEFINE_CONSTANT
DEFINE_TYPE
DEFINE_VARIABLE

DEFINE_EVENT
BUTTON_EVENT[TpGsm, 1]
{
    RELEASE:
    {
	SEND_STRING Gsm, 'AT+CMGS="79109101234"',13 ;
	SEND_STRING 0, 'AT+CMGS="79109101234"',13 ;
    }
}

data_event [Gsm]
{
    STRING:
    {
	send_string 0, "'Reading Data', data.text" ;
    }
}
    