/*
	File: fn_handlerAdd.sqf
	Author: sxp2high (BTK) (btk@arma3.cc)

	Description:
	Register new display eventhandler.

	Parameter(s):
		0: STRING - type
		1: STRING - code
		2 (Optional): STRING - variable name for handler

	Returns:
	BOOLEAN - true when scheduled

	Syntax:
	["KeyDown", "if ((_this select 1) != 1) then { hint 'Key pressed!'; };", "btk_key_handler_down"] spawn BTK_fnc_keyHandlerAdd;
	["KeyUp", "if ((_this select 1) != 1) then { hint 'Key released!'; };"] spawn BTK_fnc_keyHandlerAdd;
*/


// Parameter
_type = _this select 0;
_code = _this select 1;
_handlerVar = if ((count _this) > 2) then { _this select 2; } else { ""; };


// Wait until alive and ingame
waituntil {!(isNull (findDisplay 46))};


// Delay
sleep (0.1 + (random 0.5));


// Add keyhandler
_handler = (findDisplay 46) displayAddEventHandler [_type, _code];


// Create var
if (_handlerVar != "") then { missionNamespace setVariable [_handlerVar, _handler]; };