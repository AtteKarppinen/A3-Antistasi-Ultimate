params ["_navPointName" , "_pos", "_connections", "_roadType"];

_check = missionNamespace getVariable [_navPointName, objNull];
if(_check isEqualType []) exitWith {hint "Navpoint already set!"};
missionNamespace setVariable [_navPointName, [_pos, _roadType, _connections]];
