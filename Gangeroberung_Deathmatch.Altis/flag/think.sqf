//if !(isServer || isDedicated) exitWith {hint "nope";};

maxFlagDistance = 8;

// select 0 = player who's capturing...
gang_flag setVariable["take_ply", _this select 0, true];
gang_flag setVariable["takeover", "nil", true];
gang_flag setVariable["progress", 0, true];
// Dont touch!

["Nehme Flage ein..."] remoteExec ["hint", _this select 0];


[] spawn {
	while {true} do {
		sleep 1;
		
		_ply = (gang_flag getVariable[ "take_ply", objNull]);
		_team = (gang_flag getVariable[ "takeover", "nil"]);
		
		_playerGrp = group _ply;
		_gname = groupId _playerGrp;
		_count = count (units group _ply);
		
		//hint (format["%1", _count]);
		//sleep 1;
		if (_count < 2) exitWith{["Du besitzt keine Gang\n\n Eröffne erst eine Gang mit 'U'\n\n( Die Gruppe muss Mind. 2 Spieler beinhalten )"] remoteExec[ "hint", _ply]};
		if (_ply == objNull) exitWith {hint "end"};
		
		
		_progress = gang_flag getVariable["progress", 0];
		
		// reset, because to ranged takeover player
		if ( gang_flag distance _ply > maxFlagDistance || !alive _ply) exitWith {
			["Übernahme Abgebrochen.\nDu hast dich von der Flagge entfernt!"] remoteExec[ "hint", _ply];
			gang_flag setVariable["take_ply", objNull, true];
			gang_flag setVariable["takeover", "nil", true];
			gang_flag setVariable["progress", 0, true];
		};
		
		// Hint Shit...
		if (_progress == 10) then {[_ply] call broadcast_flag_hint};
		if (_progress == 20) then {[_ply] call broadcast_flag_hint};
		if (_progress == 30) then {[_ply] call broadcast_flag_hint};
		if (_progress == 40) then {[_ply] call broadcast_flag_hint};
		if (_progress == 50) then {[_ply] call broadcast_flag_hint};
		if (_progress == 60) then {[_ply] call broadcast_flag_hint};
		if (_progress == 70) then {[_ply] call broadcast_flag_hint};
		if (_progress == 80) then {[_ply] call broadcast_flag_hint};
		if (_progress == 90) then {[_ply] call broadcast_flag_hint};
		if (_progress == 98) then {[_ply] call broadcast_flag_hint};
		
		// Done Capturing/
		_progress = _progress + 2;
		gang_flag setVariable["progress", _progress];
		if (_progress > 100) exitWith {
			_progress = 100;
			gang_flag setVariable["progress", _progress, true];
			gang_flag setVariable[ "takeover", _gname];
			[] call broadcast_flag_hint;
			"zonemarkername" setMarkerText ("Gangeroberung - " + _team);
		};
	};
};

// Ticket Think
[] spawn = {
	_taker = getVariable[ "take_ply", objNull]);
	_units = objNull;
	
	if !(isNull _taker) then {_units = units group _taker};
	
	while {!(isNull _taker)} do {
		sleep 30
		
		[EXPSystem_CFG_SoundFlagTime] remoteExecCall ["game_PlaySound", _units];
		["flag-time"] remoteExecCall ["expSystem_AddExp", _units];
		["+" + (str EXPSystem_CFG_FlagTimeReward) + " EXP für das halten der Flagge!"] remoteExecCall ["systemChat", _units];
	};
};


//////////////////////
// Other Stuff
//////////////////////
flag_giveEXP = {
	_ply = _this select 0;
	_grp = units group _ply;
	
	[EXPSystem_CFG_SoundKill] remoteExecCall ["game_PlaySound", _ply];
	["+" + (str EXPSystem_CFG_FlagReward) + " EXP für das einnehmen der Flagge!"] remoteExecCall ["systemChat", _grp];
	["flag"] remoteExecCall ["expSystem_AddExp", _grp];

	[west, -10] remoteExecCall ["BIS_fnc_respawnTickets", 2];
};

broadcast_flag_hint = {
	_ply = _this select 0;
	_progress = gang_flag getVariable["progress", 0];
	
	if (_progress < 100) then {
		_t = format[ "die Flagge wurde zu %1 Prozent eingenommen!", _progress];
		[_t] remoteExec[ "hint", _ply];
	} else {
		_team = gang_flag getVariable[ "takeover", nil];
		_Stxt = parseText format
		["
		<t color='#ffff00' size='3.0'>Gangeroberung</t><br/>
		<t color='#ffff00' size='1.5'>Die Flagge wurde von:</t><br/>
		<t color='#FFFFFF' size='2.5'>%1</t><br/>
		<t color='#ffff00'>eingenommen!</t><br/>
		", _team];
		
		[_Stxt] remoteExec[ "hint", 0];
	};
};

