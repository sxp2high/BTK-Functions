/*
	File: fn_log.sqf
	Author: sxp2high (BTK) (btk@arma3.cc)

	Description:
	Write log to RPT.

	Parameter(s):
		0: ARRAY - log lines

	Returns:
	BOOLEAN - true when done

	Syntax:
	_logged = ["Hello RPT World!"] call BTK_fnc_log;
	_logged = [format["time is: %1", time], "Line 2"] call BTK_fnc_log;
*/


private ["_input"];


// Parameter
_input = _this;


// Log
{ diag_log text ('"BTK" ' + _x); } forEach _input;


true