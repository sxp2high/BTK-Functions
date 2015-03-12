/*
	File: fn_isJIP.sqf
	Author: sxp2high (BTK) (btk@arma3.cc)

	Description:
	Returns true when player joined in progress.

	Parameter(s):
		-

	Returns:
	BOOLEAN - true when jip, false when not

	Syntax:
	_jip = [] call BTK_fnc_isJIP;
*/


private ["_return"];


// Check
_return = if (isNil "btk_jip") then { false; } else { true; };


_return