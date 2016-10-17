/*
	File: fn_nearBuildings.sqf
	Author: sxp2high (BTK) (btk@arma3.cc)

	Description:
	Returns all buildings with building positions within the given radius.

	Parameter(s):
		0: ANY - center
		1: NUMBER - radius

	Returns:
	ARRAY - found buildings

	Syntax:
	_buildings = [player, 100] call BTK_fnc_nearBuildings;
*/


private ["_center","_radius","_return","_pos","_buildings","_building","_buildingPos"];


// Parameter
_center = _this select 0;
_radius = _this select 1;
_return = [];


// Convert into a position
_pos = [_center] call BTK_fnc_getPos;


// Find buildings
_buildings = nearestObjects [_pos, ["House"], _radius];


// Check for building positions
{

	_building = _x;
	_count = 0;

	while {(count ((_building buildingPos _count) - [0]) > 0)} do { _count = (_count + 1); };
	_buildingPos = (_count - 1);

	if (_buildingPos > 0) then { _return pushBack _building; };

} forEach _buildings;


_return