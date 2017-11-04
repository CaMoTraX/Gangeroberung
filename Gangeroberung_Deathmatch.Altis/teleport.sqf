_gen = _this select 0;
_pl = _this select 1;
_id = _this select 2;

_pl allowDamage true;

Teleports = [rs1, rs2, rs3, rs4, rs5, rs6, rs7, rs8, rs9, rs10, rs11, rs12, rs13, rs14, rs15, rs16, rs17, rs18];

//if (objNull _pl) exitWith {};

slct_randomSpawn = {
	_rand = selectRandom Teleports;
	_pp = getPos _rand;
	_offset_pos = [_pp select 0, _pp select 1, 1.4];
	
	_nearents = (_offset_pos) nearEntities 5;
	if (count _nearents < 3) exitWith {
		_pl setPos (_offset_pos);
	}; 
	[] call slct_randomSpawn;
};
[] call slct_randomSpawn;
/*
{
_nearents = (position _x)  nearEntities 5;
if (count _nearents < 2) exitWith {_pl setPos (position _x)};
} forEach Teleports;*/



/* Für debugging und spawn check!
_p = rs18;
_o = [position _p select 0,position _p select 1, 1.4];
player setPos [_o select 0, _o select 1, 1.4];
*/