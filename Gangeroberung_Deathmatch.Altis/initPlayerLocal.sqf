[] execVM "weapon_whitelist.sqf";

player addEventHandler ["Fired", {
		_safezone = ((_this select 7) distance2D ammobox_spawn);
		if (_safezone < 200) then {
			_bullet = _this select 6;
			_bullet setPosASL [0,0,0];
		};
}];

/*
[] spawn {
	_adminState = admin owner player;
	if (_adminState == 2) exitWith{};
	
	
	[ missionNamespace, "arsenalOpened", {
		disableSerialization;
		_display = _this select 0;
		{
			( _display displayCtrl _x ) ctrlSetText "Disabled";
			( _display displayCtrl _x ) ctrlSetTextColor [ 1, 0, 0, 0.5 ];
			( _display displayCtrl _x ) ctrlRemoveAllEventHandlers "buttonclick";
		}forEach [ 44146, 44147, 44150 ];
	} ] call BIS_fnc_addScriptedEventHandler;
};
*/

["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;
setGroupIconsVisible [true, true];


keyspressed = compile preprocessFile "hotkeys.sqf";
waituntil {!(IsNull (findDisplay 46))};
_keyDown = (findDisplay 46) displayAddEventHandler ["KeyDown", "_this call keyspressed"];


earplugs_nextStage = {
	_vol = soundVolume;
	[EXPSystem_CFG_SoundKill] call game_PlaySound;
	
	if (_vol == 1) exitWith{1 fadeSound 0.75;titleText["Volume: 75%", "PLAIN DOWN", 2];};
	if (_vol == 0.75) exitWith{1 fadeSound 0.5;titleText["Volume: 50%", "PLAIN DOWN", 2];};
	if (_vol == 0.5) exitWith{1 fadeSound 0.3;titleText["Volume: 30%", "PLAIN DOWN", 2];};
	if (_vol == 0.3) exitWith{1 fadeSound 1;titleText["Volume: 100%", "PLAIN DOWN", 2];};
};

