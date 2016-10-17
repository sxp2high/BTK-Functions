/*
	File: fn_handlerRemove.sqf
	Author: sxp2high (BTK) (btk@arma3.cc)

	Description:
	Remove display eventhandler.

	Parameter(s):
		0: STRING - type
		1: NUMBER - handler id

	Returns:
	NIL

	Syntax:
	["KeyDown", _id] spawn BTK_fnc_keyHandlerRemove;
*/


private ["_type","_id"];


// Parameter
_type = _this select 0;
_id = _this select 1;


// Wait until ingame
waituntil {!(isNull (findDisplay 46))};


// Add keyhandler
(findDisplay 46) displayRemoveEventHandler [_type, _id];