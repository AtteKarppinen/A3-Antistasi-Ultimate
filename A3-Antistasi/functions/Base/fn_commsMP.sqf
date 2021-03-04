if (!hasInterface) exitWith {};
if (isNil "initVar") exitWith {};
if ((side player != teamPlayer) and (side player != civilian)) exitWith {};
private ["_unit","_typeX","_textX","_display","_setText"];

params [["_unit", objNull], ["_typeX", ""], ["_textX", ""], ["_titleX", ""]];

if (_typeX == "sideChat") then {
	_unit sideChat format ["%1", _textX];
};
if (_typeX == "hint") then {[_titleX, format ["%1",_textX]] call A3A_fnc_customHint;};
if (_typeX == "hintCS") then {hintC format ["%1",_textX]};
if (_typeX == "hintS") then {[_titleX, format ["%1",_textX], true] call A3A_fnc_customHint;};
if (_typeX == "intelError") then {[_titleX, format ["Download error:<br/>%1",_textX]] call A3A_fnc_customHint;};
if (_typeX == "globalChat") then {
	_unit globalChat format ["%1", _textX];
};

if (_typeX == "income") then {
	waitUntil {sleep 0.2; !incomeRep};
	incomeRep = true;
	playSound "3DEN_notificationDefault";
	[_textX, [safeZoneX + (0.8 * safeZoneW), (0.2 * safeZoneW)], 0.5, 5, 0, 0, 2] spawn bis_fnc_dynamicText;
	incomeRep = false;

	[] spawn A3A_fnc_statistics;
};

if (_typeX == "countdown") then {
	_textX = format ["Time Remaining: %1 secs",_textX];
	["Countdown", format ["%1",_textX]] call A3A_fnc_customHint;
};

if (_typeX == "taxRep") then {
	incomeRep = true;
	playSound "3DEN_notificationDefault";
	[_textX, [safeZoneX + (0.8 * safeZoneW), (0.2 * safeZoneW)], 0.5, 5, 0, 0, 2] spawn bis_fnc_dynamicText;
	sleep 10;
	incomeRep = false;

	[] spawn A3A_fnc_statistics;
};
if (_typeX == "tier") then {
	waitUntil {sleep 0.2; !incomeRep};
	incomeRep = true;
	playSound "3DEN_notificationDefault";

	_textX = format ["War Level Changed<br/><br/>Current Level: %1",tierWar];

	[_textX, [safeZoneX + (0.8 * safeZoneW), (0.2 * safeZoneW)], 0.5, 5, 0, 0, 2] spawn bis_fnc_dynamicText;
	incomeRep = false;

	[] spawn A3A_fnc_statistics;
};

if (_typeX == "support") then {
	[_textX, [safeZoneX + (0.8 * safeZoneW), (0.2 * safeZoneW)], 0.5, 5, 0, 0, 2] spawn bis_fnc_dynamicText;
};

if (_typeX == "unlock") then {
	switch (tierWar) do {
		case (3): {
			_textX = format ["<br/><t size='0.6'>Rebel vehicles stock has been updated with new vehicles.</t>"];
			if (player == theBoss) then {
				_textX = _textX + format ["<br/><t size='0.6'>Roadblocks are available for building, MG squads and teams are available for recruitment.</t>"];
			};
		};

		case (4): {
			_textX = format ["<br/><br/><t size='0.6'>Black Vehicle Market stock has been updated with Tier 2 vehicles.</t>"];
			_textX = _textX + format ["<br/><t size='0.6'>Rebel vehicles stock has been updated with new vehicles.</t>"];
			if (player == theBoss) then {
				_textX = _textX + format ["<br/><t size='0.6'>AA, AT Emplacements are available for building, AA/AT squads and teams are available for recruitment.</t>"];
			};
		};

		case (5): {
			_textX = _textX + format ["<br/><t size='0.6'>Rebel vehicles stock has been updated with new vehicles.</t>"];
			if (player == theBoss) then {
				_textX = _textX + format ["<br/><t size='0.6'>Mortar teams are available for recruitment.</t>"];
			};
		};

		case (8): {
			_textX = format ["<br/><br/><t size='0.6'>Vehicle Market stock has been updated with Tier 3 vehicles.</t>"];
		};
	};

	if (!isSupportAnnounced) then {
		private _outposts = {sidesX getVariable [_x,sideUnknown] == teamPlayer} count outposts;
		if(_outposts > 4 && {player == theBoss}) then {
			_textX = _textX + format ["<br/><br/><t size='0.6'>Non-offensive support actions are available (Commander Menu).</t>"];
			isSupportAnnounced = true;
			publicVariable "isPowPaycheckAnnounced";
		};
	};

	if(tierWar > 3 && {!isPowPaycheckAnnounced}) then {
		_textX = _textX + format ["<br/><br/><t size='0.6'>Resistance has been recognized by <t size='0.6' color='#FFA500'>IDAP</t>, an third party peace-keeping organization and agreement has been made - <br/><t size='0.6' color='#FFA500'>IDAP</t> will pay <t size='0.6' color='#008000'>%1</t> for freeing <t size='0.6' color='#0033CC'>%2</t> soldiers.</t>", nameTeamPlayer, nameOccupants];
		isPowPaycheckAnnounced = true; 
		publicVariable "isPowPaycheckAnnounced";
	};

	[_textX, [safeZoneX + (0.65 * safeZoneW), (0.2 * safeZoneW)], 0.65, 8, 0, 0, 359] spawn BIS_fnc_dynamicText;
};