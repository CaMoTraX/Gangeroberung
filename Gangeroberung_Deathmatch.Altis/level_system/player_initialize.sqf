// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
// Client + Server
// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
[] execVM "level_system\config.sqf";	// Config for server & client

// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

if (isDedicated) exitWith{};		// Obove Client + Server, Down just Client!

// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
// Client
// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
[] execVM "hud\draw_levels.sqf";		// shows the levels

// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


// Start the Magic!

expSystem_LoadPlayer = {
	waitUntil {!(player == objNull)};

	_lvl = profileNamespace getVariable ["gang_level", 0];
	_exp = profileNamespace getVariable ["gang_exp", 0];
	profileNamespace setVariable ["gang_level", _lvl];
	profileNamespace setVariable ["gang_exp", _exp];
	saveprofileNamespace;
	
	[_lvl, _exp, (owner player)] remoteExecCall ["expSystem_SyncClients", 0];
};



expSystem_AddExp = {
	_type = _this select 0;
	
	_exp = 0;
	_lvl = profileNamespace getVariable ["gang_level", 0];
	
	if (_type == "") then {_exp = _this select 2;};
	if (_type == "flag-time") then {_exp = EXPSystem_CFG_FlagTimeReward;};
	if (_type == "flag") then {_exp = EXPSystem_CFG_FlagReward;};
	if (_type == "kill") then {_exp = EXPSystem_CFG_KillReward;};
	if (_type == "assist") then {_exp = EXPSystem_CFG_AssistReward;};
	if (_type == "win") then {_exp = EXPSystem_CFG_WinReward;};
	
	_lvlexp = EXPSystem_CFG_ExpLevels select _lvl;
	_savedExp = profileNamespace getVariable ["gang_exp", 0];
	
	if (_lvlexp < (_savedExp + _exp)) exitWith {
		profileNamespace setVariable ["gang_level", _lvl + 1];
		profileNamespace setVariable ["gang_exp", 0];
		saveprofileNamespace;
		[(_lvl + 1), 0, (owner player)] call expSystem_SyncServer;
		[] call game_PlayLevelUp;	// Sound
	};		// level up!
	
	profileNamespace setVariable ["gang_exp", _savedExp + _exp];
	saveprofileNamespace;
	[_lvl, (_savedExp + _exp), (owner player)] call expSystem_SyncServer;
};

expSystem_SyncServer = {
	_lvl = _this select 0;
	_exp = _this select 1;
	//[_lvl, _exp, (owner player)] call expSystem_SyncClients;
	[_lvl, _exp, (owner player)] remoteExecCall ["expSystem_SyncClients", 0];
};

expSystem_SaveClient = {
	profileNamespace setVariable ["gang_level", (player getVariable["gang_level", 0])];
	profileNamespace setVariable ["gang_exp", (player getVariable["gang_exp", 0])];
	saveprofileNamespace;
};




// at the end!
waitUntil {!(isNull player)};
[] call expSystem_LoadPlayer;