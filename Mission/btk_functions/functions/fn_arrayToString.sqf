/*
	File: fn_arrayToString.sqf
	Author: sxp2high (BTK) (btk@arma3.cc)

	Description:
	Convert array to string and add trailing symbol (Ie ", ").

	Parameter(s):
		0: ARRAY - target
		1 (Optional): STRING - traliling symbol (Default is ", ")

	Returns:
	STRING - converted string

	Syntax:
	_string = [["hello","world"]] call BTK_fnc_arrayToString;
	_string = [[1,2,3,4,5], " - "] call BTK_fnc_arrayToString;
*/


private ["_array","_trailing","_string","_index"];


_array = _this select 0;
_trailing = if ((count _this) > 1) then { _this select 1; } else { ", "; };


_string = "";
_index = 1;


{

	if (_index == (count _array)) then {
		_string = _string + (str _x);
	} else {
		_string = _string + (str _x) + _trailing;
	};

	_index = _index + 1;

} forEach _array;


_string