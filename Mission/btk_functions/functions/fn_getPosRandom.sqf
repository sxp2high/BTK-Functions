/*
	File: fn_getPosRandom.sqf
	Author: sxp2high (BTK) (btk@arma3.cc)

	Description:
	Returns a random position within the given radius.

	Parameter(s):
		0: ANY - center
		1: NUMBER - radius around the center
		2 (Optional): NUMBER - minimum distance to center
		3 (Optional): BOOLEAN - can be water
		4 (Optional): BOOLEAN - must be water

	Returns:
	POSITION - the position

	Syntax:
	_randomPos = [player, 100] call BTK_fnc_getPosRandom;
	_randomPosOnLand = [player, 100, 0, false] call BTK_fnc_getPosRandom;
	_randomPosOnWater = [player, 500, 100, true, true] call BTK_fnc_getPosRandom;
*/


private ["_center","_radius","_minDistance","_canBeWater","_mustBeWater","_centerPos","_position"];


// Parameter
_center = _this select 0;
_radius = _this select 1;
_minDistance = if ((count _this) > 2) then { _this select 2; } else { 1; };
_canBeWater = if ((count _this) > 3) then { _this select 3; } else { true; };
_mustBeWater = if ((count _this) > 4) then { _this select 4; } else { false; };


// Get pos of center
_centerPos = [_center] call BTK_fnc_getPos;


// Generate
_position = [((_centerPos select 0) + (_radius - (random (2 * _radius)))), ((_centerPos select 1) + (_radius - (random (2 * _radius)))), 0];


// Check
while {((_position distance _center) < _minDistance) || (!(_canBeWater) && (surfaceIsWater _position)) || ((_mustBeWater) && !(surfaceIsWater _position))} do {
	_position = [((_centerPos select 0) + (_radius - (random (2 * _radius)))), ((_centerPos select 1) + (_radius - (random (2 * _radius)))), 0];
};


_position