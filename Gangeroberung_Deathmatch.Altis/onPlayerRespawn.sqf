[player, [missionNamespace, "inventory_var"]] call BIS_fnc_loadInventory;

player enableFatigue false;
player enableStamina false;
player allowDamage false;

sleep 5;

player allowDamage true;






// Kill event

player addEventHandler[ "Killed", {
	params["_unit", "_killer", "_instigator", "_useEffects"];
	
	if (isNull _instigator) then {_instigator = UAVControl vehicle _killer select 0}; // UAV/UGV player operated road kill
	if (isNull _instigator) then {_instigator = _killer}; // player driven vehicle road kill
	//if (_instigator == _killer) exitWith {};
	
	
	_weaponClass = currentWeapon _instigator;
	_wname = getText(configFile >> "CfgWeapons" >> _weaponClass >> "displayName");
	_formatt = format["%1 was killed by %2 with - %3",name _killed, name _instigator, _wname];

	[_formatt] remoteExecCall ["systemChat", 0];
	
	// Other
	//hint format["%1 hat den gekillt: %2", owner _instigator, owner _killer];
	if (!(isNull _killer) && _killer != _unit) then {
		//_exp = _killer getVariable["gang_exp", 0];
		//_killer setVariable[ "gang_exp", (_exp + EXPSystem_CFG_KillReward )];
		//[] remoteExecCall ["expSystem_SyncClient", _killer];
		["kill"] remoteExecCall ["expSystem_AddExp", _killer];
		diag_log "test";
		[EXPSystem_CFG_SoundKill] remoteExecCall ["game_PlaySound", _killer];
		["+" + (str EXPSystem_CFG_KillReward) + " EXP für das Töten eines Spielers!"] remoteExecCall ["systemChat", _killer];
	};	
}];