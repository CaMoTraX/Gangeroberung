private['_handled'];
_handled = false;

switch (_this select 1) do {
			   //Key ^
	case 41: {
		[] call hud_showLevelInfo;
		_handled = true;
	};
	case 60: {
		[] call earplugs_nextStage;
		_handled = true;
	};
};

_handled;