/****************************************************************
File: UPSMON_movetogunner.sqf
Author: MONSADA

Description:
	Funci�n que mueve al soldierX a la posici�n de conductor
Parameter(s):
	<--- unit
	<--- Vehicle to mount
Returns:

****************************************************************/
private["_vehicle","_npc"];		

_npc = _this ;
_vehicle = vehicle _npc;
	
sleep 0.05;
//Si est� victim
if (vehicle _npc == _npc || !alive _npc || !canmove _npc || !(_npc iskindof "CAManBase")) exitwith{};
	
if (isnull(gunner _vehicle) || !alive(gunner _vehicle) || !canmove(gunner _vehicle)) then 
{ 	
	_npc action ["getOut", _vehicle];
	doGetOut _npc;
	WaitUntil {vehicle _npc==_npc || !alive _npc || !canmove _npc};
	//Si est� victim
	if (!alive _npc || !canmove _npc) exitwith{};		
	unassignVehicle _npc;
	_npc assignasgunner _vehicle;
	_npc moveingunner _vehicle;
};