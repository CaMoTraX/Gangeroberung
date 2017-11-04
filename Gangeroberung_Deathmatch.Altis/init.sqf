if !(isDedicated) then {
	[] execVM "initPlayerLocal.sqf";
	[] execVM "weapon_whitelist.sqf";
	//[] execVM "simpleEP.sqf";
	[] execVM "level_system\player_initialize.sqf";
	[] execVM "sound_system\playsound.sqf";
} else {
	//[] execVM "level_system\server_functions.sqf";
};


// debug | Server

if (isServer) then {
	//[] execVM "level_system\server_functions.sqf";
};