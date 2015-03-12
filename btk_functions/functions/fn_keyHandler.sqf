/*
	File: fn_handler.sqf
	Author: sxp2high (BTK) (btk@arma3.cc)

	Description:
	Handle key press.

	Parameter(s):
		0: NUMBER - key
		1: NUMBER - 0 = down, 1 = up

	Returns:
	BOOLEAN - false when done (doesnt overwrite)

	Syntax:
	_down = (findDisplay 46) displayAddEventHandler ["KeyDown", "[(_this select 1), 0] call BTK_fnc_keyHandler;"];
	_up = (findDisplay 46) displayAddEventHandler ["KeyUp", "[(_this select 1), 1] call BTK_fnc_keyHandler;"];
*/


private ["_key","_type","_index"];


// Parameter
_key = _this select 0;
_type = _this select 1;


// No ESC
if (_key == 1) exitWith { false };


// Up or down?
switch (_type) do {

	case (0) : {

		if (!(_key in btk_keys_current)) then {
			btk_keys_current pushBack _key;
		};

	};

	case (1) : {

		if (_key in btk_keys_current) then {
			_index = btk_keys_current find _key;
			btk_keys_current deleteAt _index;
		};

	};

};


false