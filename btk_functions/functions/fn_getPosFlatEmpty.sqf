/*
	File: fn_getPosFlatEmpty.sqf
	Author: sxp2high (BTK) (btk@arma3.cc)

	Description:
	Returns a (random) flat and/or emtpy position within the given radius.

	Parameter(s):
		0: ANY - center
		1: NUMBER - radius around the center
		2 (Optional): NUMBER - minimum distance to the center
		3 (Optional): NUMBER - size
		4 (Optional): NUMBER - minimum distance to nearest object
		5 (Optional): NUMBER - max gradient
		6 (Optional): NUMBER - 0 = no water, 1 = can be water, 2 = must be water
		7 (Optional): BOOLEAN - true if some water can be in 25m radius
		8 (Optional): BOOLEAN - true if position can be on a road

	Returns:
	POSITION - the position

	Syntax:
	_posFlat = [(getPosATL player), 100] call BTK_fnc_getPosFlatEmpty;
	_posFlat = [(getPosATL player), 100, 50, 10, 10, 0.2, 0, true, true] call BTK_fnc_getPosFlatEmpty;
*/

	
private ["_center","_radius","_minDistance","_areaSize","_objectDistance","_maxGradient","_canBeWater","_canBeOnShore","_canBeRoad","_ignoreObject","_tries","_return","_centerPos"];


// Parameter
_center = _this select 0;
_radius = _this select 1;
_minDistance = if ((count _this) > 2) then { _this select 2; } else { 0; };
_areaSize = if ((count _this) > 3) then { _this select 3; } else { 5; };
_objectDistance = if ((count _this) > 4) then { _this select 4; } else { 5; };
_maxGradient = if ((count _this) > 5) then { _this select 5; } else { 0.2; };
_canBeWater = if ((count _this) > 6) then { _this select 6; } else { 0; };
_canBeOnShore = if ((count _this) > 7) then { _this select 7; } else { false; };
_canBeRoad = if ((count _this) > 8) then { _this select 8; } else { true; };


// Variables
_ignoreObject = objNull;
_tries = 0;
_return = [];


// Get pos of center
_centerPos = [_center] call BTK_fnc_getPos;


// Try
while {((count _return) == 0) && (_tries < 9999)} do {

	private ["_posRandom"];

	_tries = _tries + 1;

	_posRandom = [_centerPos, _radius, _minDistance] call btk_fnc_getPosRandom;

	_return = [(_posRandom select 0), (_posRandom select 1), 0];
	_return = _return isFlatEmpty [_objectDistance, 0, _maxGradient, _areaSize, _canBeWater, _canBeOnShore, _ignoreObject];

	if ((count _return) > 0) then {

		_return set [2, 0];

		//if ((_return distance _centerPos) < (_radius / 5)) then { _return = []; };

		if (!(_canBeRoad)) then {
			if ((count (_return nearRoads (_areaSize + 25))) > 0) then { _return = []; };
		};

	};

	if ((count _return) > 0) exitWith {};

};


// Nothing found - return random position
if ((count _return) == 0) then { _return = [((_centerPos select 0) + (_radius - (random (2 * _radius)))), ((_centerPos select 1) + (_radius - (random (2 * _radius)))), 0]; };


_return