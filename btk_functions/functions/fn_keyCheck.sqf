/*
	File: fn_keyCheck.sqf
	Author: sxp2high (BTK) (btk@arma3.cc)

	Description:
	Checks for key press.

	Parameter(s):
		0: ARRAY - key(s)

	Returns:
	BOOLEAN - true when pressed, false when not

	Syntax:
	[17] call BTK_fnc_keyCheck;
	waitUntil {(btk_test_keys call BTK_fnc_keyCheck)};
*/


private ["_keys","_return"];


// Parameter
_keys = _this;


// Check
_return = if (({(_x in _keys)} count btk_keys_current) == (count _keys)) then { true; } else { false; };


_return