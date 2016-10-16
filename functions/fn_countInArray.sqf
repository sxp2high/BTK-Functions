/*
	File: fn_countInArray.sqf
	Author: sxp2high (BTK) (btk@arma3.cc)

	Description:
	Count how often entry is in array.

	Parameter(s):
		0: ARRAY - array to delete from
		1: ANY - what to find

	Returns:
	NUMBER - how many, 0 if not found

	Syntax:
	_count = [[1,2,3,1,2,3], 3] call BTK_fnc_countInArray; // Will return 2
*/


// Parameter
_array = _this select 0;
_find = _this select 1;
_count = 0;


// Search
{
	if (_x == _find) then { _count = _count + 1; };
} forEach _array;


_count