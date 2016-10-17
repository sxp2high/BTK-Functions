/*
	File: fn_getBuildingPositions.sqf
	Author: sxp2high (BTK) (btk@arma3.cc)

	Description:
	Returns all building positions of the given building.

	Parameter(s):
		0: OBJECT - building

	Returns:
	ARRAY - building positions

	Syntax:
	_buildingPositions = [myHouse] call BTK_fnc_getBuildingPositions;
*/


private ["_building","_count","_return","_max"];


// Parameter
_building = _this select 0;
_count = 0;
_return = [];


// How many are avilable?
while {(count ((_building buildingPos _count) - [0]) > 0)} do { _count = (_count + 1); };


// Add them to array
_max = (_count - 1);
for "_j" from 1 to _max do { _return pushBack (_building buildingPos _j); };


_return