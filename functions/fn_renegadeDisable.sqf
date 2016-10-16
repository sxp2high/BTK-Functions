/*
	File: fn_renegadeDisable.sqf
	Author: sxp2high (BTK) (btk@arma3.cc)

	Description:
	Disable renegade status for units. (Negative score)

	Parameter(s):
		0: OBJECT - unit to disable renegade for

	Returns:
	BOOLEAN - true when started

	Syntax:
	_disabled = [player] call BTK_fnc_renegadeDisable;
*/


_unit = _this select 0;


// Main flow
[_unit] spawn {

	_unit = _this select 0;
	
	while {true} do {

		// Count, wait for change
		waitUntil {sleep 0.861; ((rating _unit) < 0)};
		_unit addRating -(rating _unit);

	};

};


true