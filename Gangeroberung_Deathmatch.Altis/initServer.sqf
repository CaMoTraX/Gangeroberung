[] execVM "level_system\server_functions.sqs";

/*
addMissionEventHandler ["EntityKilled", 
{
	params ["_killed", "_killer", "_instigator"];
	if (isNull _instigator) then {_instigator = UAVControl vehicle _killer select 0}; // UAV/UGV player operated road kill
	if (isNull _instigator) then {_instigator = _killer}; // player driven vehicle road kill
	
	_weaponClass = currentWeapon _instigator;
	_wname = getText(configFile >> "CfgWeapons" >> _weaponClass >> "displayName");
	_formatt = format["%1 was killed by %2 with - %3",name _killed, name _instigator, _wname];
	
	/*
	_safezone = (_killer distance2D ammobox_spawn);
	if (_safezone < 100) then {
		["Zafezone Kill wird nicht toleriert!"] remoteExecCall ["endMission", _killer];
	};
	
	
	[_formatt] remoteExecCall ["systemChat", 0];
	
	
	// Other
	//hint format["%1 hat den gekillt: %2", owner _instigator, owner _killer];
	if (!(isNull _killer) && _killed != _killer) then {
		//_exp = _killer getVariable["gang_exp", 0];
		//_killer setVariable[ "gang_exp", (_exp + EXPSystem_CFG_KillReward )];
		//[] remoteExecCall ["expSystem_SyncClient", _killer];
		["kill"] remoteExecCall ["expSystem_AddExp", _killer];
		diag_log "test";
		[EXPSystem_CFG_SoundKill] remoteExecCall ["game_PlaySound", _killer];
		["+" + (str EXPSystem_CFG_KillReward) + " EXP für das Töten eines Spielers!"] remoteExecCall ["systemChat", _killer];
	};	
}];*/

["Initialize"] call BIS_fnc_dynamicGroups;