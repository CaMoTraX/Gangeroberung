if (isDedicated) exitWith {};

game_PlaySound = {
	params["_name"];
	playSound3D [_name, player];
};

game_PlayLevelUp = {
	[] spawn {
		playMusic ["LeadTrack01_F", 15];
		sleep 4;
		playMusic "";
	};
};