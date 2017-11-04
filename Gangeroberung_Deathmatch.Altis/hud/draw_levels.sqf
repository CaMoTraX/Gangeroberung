hudInfoEnabled = false;

hud_showLevelInfo = {
	if !(hudInfoEnabled) exitWith {
		hudInfoEnabled = true;
		
		hud_levelInfo = addMissionEventHandler["Draw3D", {
			{
				if ((alive _x) && ((player distance _x) < 2)) then {
					_pos = visiblePositionASL _x;
					_eyepos = ASLtoATL eyepos _x;
					if ((getTerrainHeightASL[_pos select 0, _pos select 1]) < 0) then {
						_eyepos = eyepos _x;
						_pos = visiblePositionASL _x;
					};
					_lvl = _x getVariable["gang_level", 0];
					_exp = _x getVariable["gang_exp", 0];
					_lvlexp = EXPSystem_CFG_ExpLevels select (_lvl);
					
					_fontsize = 0.05;
					_info = format[ "Level: %1 - EXP: %2 / %3", _lvl, _exp, _lvlexp ];
					_dotpos = [_eyepos select 0, _eyepos select 1, 0];
					_dotpos set[2, (_eyepos select 2) + 0.4];
					_dotpos2 = [_dotpos select 0, _dotpos select 1, (_dotpos select 2) + 0.1 ];
					_color = [1, 0.180, 0.180, 1];
					drawIcon3D["#(argb,8,8,3)color(0,0,0,0)", _color, _dotpos, 0.1, 0.1, 45, _info, 2, _fontsize, "PuristaMedium"];
					drawIcon3D["#(argb,8,8,3)color(0,0,0,0)", _color, _dotpos2, 0.1, 0.1, 45, name _x, 2, _fontsize - 0.01, "PuristaMedium"];
					//drawIcon3D["#(argb,8,8,3)color(1,0.843137,0,1)", _color, _eyepos, 0.13, 0.13, 45];
				};
			} forEach allUnits;
		}];
	};
	if (hudInfoEnabled) exitWith {removeMissionEventHandler["Draw3D", hud_levelInfo];hudInfoEnabled = false;};
};