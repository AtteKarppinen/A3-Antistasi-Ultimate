#include "..\..\script_component.hpp"
FIX_LINE_NUMBERS()

params ["_suppData", "_launcher", "_group", "_delay", "_reveal"];
_suppData params ["_supportName", "_side", "_suppType", "_center", "_radius", "_suppTarget"];

sleep _delay;

_launcher addEventHandler ["Fired", {
    params ["_launcher", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
    _launcher setVariable ["A3A_currentMissile", _projectile];
}];

private _targetObj = objNull;
private _laser = objNull;
private _attachObj = objNull;
private _timeout = time + 900;
private _targTimeout = 0;
private _acquisition = 0;
private _missiles = 1; ///maybe 2
sleep 10;
while {true} do
{
    // check if launcher/crew are intact
    if !(canFire _launcher and gunner _launcher call A3A_fnc_canFight) exitWith {
        Info_1("%1 has been destroyed or disabled, aborting routine", _supportName);
    };

    // check if we're past the active time/missiles
    if (time > _timeout or _missiles <= 0) exitWith {
        Info_1("%1 has timed out or run out of missiles, aborting", _supportName);
    };

    if (isNull _targetObj) then
    {
        if (_suppTarget isEqualTo []) then { sleep 5; continue };
            
        // New target sent
        _targetObj = _suppTarget select 0;
        if !(alive _targetObj) exitWith {
            _suppTarget resize 0;
            Debug_1("%1 skips target, as it is already dead", _supportName);
            continue;
        };
        Debug_2("Next target for %2 is %1", _suppTarget, _supportName);

        
        _targTimeout = (time + 120);
        _acquisition = 0;
    };

    //Target no longer valid
    if (!canMove _targetObj or time > _targTimeout) then {
        Debug_1("%1 target lost or destroyed, returning to idle", _supportName);
        _suppTarget resize 0;
        _targetObj = objNull;
        _launcher doWatch objNull;
        continue;
    };

    /* // Update acquisition depending on whether path to target is blocked
    private _dir = _launcher getDir _targetObj;
    private _intercept = (getPosASL _launcher) getPos [250, _dir] vectorAdd [0,0,300];
    private _isBlocked = terrainIntersectASL [_intercept, getPosASL _targetObj];
    _acquisition = _acquisition + ([0.1, -0.1] select _isBlocked);
    _acquisition = 1 min _acquisition max 0;
    _launcher doWatch _intercept;
    if (_acquisition < 1) then { sleep 1; continue }; */

    // wait for previous missile to have effect (or not)
    if (alive (_launcher getVariable ["A3A_currentMissile", objNull])) then { sleep 1; continue };

    // Actually fire
    Debug("Firing at target");
    //Creates the laser target to mark the target
    
    _attachObj = createVehicle ["Land_Battery_F", (getPos _targetObj), [], 0, "CAN_COLLIDE"];
    _laser = createVehicle ["LaserTargetE", (getPos _targetObj), [], 0, "CAN_COLLIDE"];
    Info_1("Trying to attack laser to %1", _targetObj);
    _attachObj attachTo [_targetObj, [0,0,0]];
    _laser attachTo [_attachObj, [0,0,0]];

    //Send the laser target to the launcher
    _side reportRemoteTarget [_laser, 300];
    _laser confirmSensorTarget [_side, true];
    _launcher fireAtTarget [_laser, "weapon_vls_01"];
    diag_log (currentMagazine _launcher);
    [_reveal, getPosATL _targetObj, _side, "CRUISEMISSILE", _targetObj, 60] spawn A3A_fnc_showInterceptedSupportCall;

    _launcher setWeaponReloadingTime [gunner _launcher, currentMuzzle gunner _launcher, 0.001];
    _launcher removeMagazinesTurret ["magazine_Missiles_Cruise_01_x18",[0]]; 
    _launcher removeWeaponTurret ["weapon_VLS_01",[0]]; 
    _launcher addMagazineTurret ["magazine_Missiles_Cruise_01_Cluster_x18",[0]]; 
    _launcher addWeaponTurret ["weapon_VLS_01",[0]];
    _launcher setWeaponReloadingTime [gunner _launcher, currentMuzzle gunner _launcher, 0.001];
    sleep 10;
    _side reportRemoteTarget [_laser, 300];
    _laser confirmSensorTarget [_side, true];
    _launcher fireAtTarget [_laser, "weapon_vls_01"];

    sleep 10;
    detach _attachObj;

    _missiles = _missiles - 1;
    _targTimeout = (time + 120);
    sleep 1; //_targTimeout ?
};

_suppData set [4, 0];       // zero radius to signal termination

sleep 180; ///missile just won't fly for longer, though some better way would be nice
[_launcher] spawn A3A_fnc_vehDespawner;
[_group] spawn A3A_fnc_groupDespawner;
deleteVehicle _laser;
deleteVehicle _attachObj;