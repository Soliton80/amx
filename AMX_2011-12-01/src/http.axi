PROGRAM_NAME='http'
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE
dvIPServer  = 0:2:0
(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT
nIPPort     = 8080
(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START
(* Open The Server *)
IP_SERVER_OPEN(dvIPServer.Port,nIPPort,IP_TCP)
(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
(* Server Data Handler *)
DATA_EVENT[dvIPServer]
{
	ONERROR:
	{
		SEND_STRING 0,"'error: server=',ITOA(Data.Number)"
	}
	ONLINE:
	{
		SEND_STRING 0,"'online: server'" 
	}
	OFFLINE:
	{    
		SEND_STRING 0,"'offline: server'" 
		IP_SERVER_OPEN(dvIPServer.Port,nIPPort,IP_TCP)
		
	}
	string:
	{
		// Handle incoming data from the TCP client
		SEND_STRING 0, "'Received data from TCP client: ', data.text"
		
		IF (FIND_STRING(Data.Text, 'DimOn', 1)) {
			SEND_STRING 0, "'Turning on the lights', 13"
			CALL 'TurnOnAllDimChn'() 
		} 
		ELSE IF (FIND_STRING(Data.Text, 'DimOf', 1)) {
			SEND_STRING 0, "'Turning off the lights', 13"
			CALL 'TurnOffAllDimChn'() 
		}
		ELSE IF (FIND_STRING(Data.Text, 'ReleOff', 1)) {
			SEND_STRING 0, "'All rele off', 13"
			CALL 'TurnOffAllRelayChn'();
		}
		ELSE IF (FIND_STRING(Data.Text, 'ReleOn', 1)) {
			SEND_STRING 0, "'All rele on', 13"
			CALL 'TurnOnAllRelayChn'();
		}
		ELSE IF (FIND_STRING(Data.Text, 'TurnOffLights', 1)) {
			SEND_STRING 0, "'Turninig Off all light', 13"
			CALL 'TurnOffAllLights'();
		}
		ELSE IF (FIND_STRING(Data.Text, 'TurnOnLights', 1)) {
			SEND_STRING 0, "'Turninig on all light', 13"
			CALL 'TurnOnAllLights'();
		}
		ELSE IF (FIND_STRING(Data.Text, 'BedroomLightsTurnOff', 1)) {
			SEND_STRING 0, "'Turninig of Bedroom lights', 13"
			CALL 'BedroomLightOff'();
		}
		ELSE IF (FIND_STRING(Data.Text, 'BedroomLightsTurnOn', 1)) {
			SEND_STRING 0, "'Turninig of Bedroom lights', 13"
			CALL 'BedroomLightOn'();
		}
		ELSE IF (FIND_STRING(Data.Text, 'KitchenLightOff', 1)) {
			SEND_STRING 0, "'Turninig Off Kitchen lights', 13"
			CALL 'KitchenLightOff'();
		}
		ELSE IF (FIND_STRING(Data.Text, 'KitchenLightOn', 1)) {
			SEND_STRING 0, "'Turninig on Kitchen lihgts', 13"
			CALL 'KitchenLightOn'();
		}
		
		ELSE IF (FIND_STRING(Data.Text, 'LivingRoomLightOff', 1)) {
			SEND_STRING 0, "'Turninig of LivingRoom lights', 13"
			CALL 'LivingRoomLightOff'();
		}
		ELSE IF (FIND_STRING(Data.Text, 'LivingRoomLightOn', 1)) {
			SEND_STRING 0, "'Turninig of LivingRoom lights', 13"
			CALL 'LivingRoomLightOn'();
		}
		
		ELSE IF (FIND_STRING(Data.Text, 'KabinetLightOff', 1)) {
			SEND_STRING 0, "'Turninig of Kabinet lights', 13"
			CALL 'KabinetLightOff'();
		}
		ELSE IF (FIND_STRING(Data.Text, 'KabinetLightOn', 1)) {
			SEND_STRING 0, "'Turninig of Kabinet lights', 13"
			CALL 'KabinetLightOn'();
		}
		
		ELSE IF (FIND_STRING(Data.Text, 'ChildRoomLightOff', 1)) {
			SEND_STRING 0, "'Turninig of ChildRoom lights', 13"
			CALL 'ChildRoomLightOff'();
		}
		ELSE IF (FIND_STRING(Data.Text, 'ChildRoomightOn', 1)) {
			SEND_STRING 0, "'Turninig of ChildRoom lights', 13"
			CALL 'ChildRoomLightOn'();
		}
		
		ELSE IF (FIND_STRING(Data.Text, 'HallLightOff', 1)) {
			SEND_STRING 0, "'Turninig of Hall lights', 13"
			CALL 'HallLightOff'();
		}
		ELSE IF (FIND_STRING(Data.Text, 'HallLightOn', 1)) {
			SEND_STRING 0, "'Turninig of Hall lights', 13"
			CALL 'HallLightOn'();
		}
		
		ELSE IF (FIND_STRING(Data.Text, 'BathLightOff', 1)) {
			SEND_STRING 0, "'Turninig of Bath lights', 13"
			CALL 'BathLightOff'();
		}
		ELSE IF (FIND_STRING(Data.Text, 'BathLightOn', 1)) {
			SEND_STRING 0, "'Turninig of Bath lights', 13"
			CALL 'BathLightOn'();
		}
		
		ELSE {
			SEND_STRING 0, "'Unknown command', 13"
		}
	}
}









