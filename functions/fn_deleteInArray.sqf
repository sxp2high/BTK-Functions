/*
	File: fn_deleteInArray.sqf
	Author: sxp2high (BTK) (btk@arma3.cc)

	Description:
	Delete entry from array. (Including all duplicates)

	Parameter(s):
		0: ARRAY - array to delete from
		1: ANY - what to delete

	Returns:
	ARRAY - new array

	Syntax:
	_deleted = [[1,2,3], 2] call BTK_fnc_deleteInArray; // Array afterwards: [1,3]
*/


private ["_array","_entry","_index"];


// Parameter
_array = _this select 0;
_entry = _this select 1;


// Not found
if (!(_entry in _array)) exitWith {};


// Find and delete
while {_entry in _array} do {

	_index = _array find _entry;
	_array deleteAt _index;

};


_array