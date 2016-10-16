/*
	File: fn_getComposition.sqf
	Author: sxp2high (BTK) (btk@arma3.cc)

	Description:
	Log composition to be used with BTK_fnc_spawnComposition.

	Parameter(s):
		0: POSITION - center position
		1: NUMBER - radius around the center

	Returns:
	ARRAY - building positions

	Syntax:
	[(getPosATL player), 50] call BTK_fnc_getComposition;
*/


private ["_center","_radius","_objects","_objectsFiltered","_objectsReturn"];


// Parameter
_center = _this select 0;
_radius = _this select 1;


// Get objects
_objects = nearestObjects [_center, ["All"], _radius];
_objectsFiltered = [];
_objectsReturn = [];


// Filter
{
	if (!(_x isKindOf "Man")) then { _objectsFiltered pushBack _x; };
} forEach _objects;


// No objects?
if ((count _objectsFiltered) < 1) exitWith { ["BTK_fnc_getComposition", "No objects found!"] call BTK_fnc_error; };


// Start logging
[format["'==================== COMPOSITION START ===================='"]] call BTK_fnc_log;


{

	private ["_type","_offsetX","_offsetY","_z","_dir","_fuel","_damage"];

	_type = typeOf _x;
	_offsetX = ((getPosATL _x) select 0) - (_center select 0);
	_offsetY = ((getPosATL _x) select 1) - (_center select 1);
	_z = ((getPosATL _x) select 2);
	_dir = getDir _x;
	_fuel = fuel _x;
	_damage = damage _x;
	_simualtion = if (simulationEnabled _x) then { true; } else { false; };

	_objectsReturn pushBack [_type, [_offsetX, _offsetY, _z], _dir, _fuel, _damage, _simualtion];

} forEach _objectsFiltered;


// Log
[format["%1", _objectsReturn]] call BTK_fnc_log;
copyToClipboard str(_objectsReturn);


// End logging
[format["'==================== COMPOSITION END ===================='"]] call BTK_fnc_log;


// Confirm
["BTK_fnc_getComposition", format["%1 Objects saved.", (count _objectsFiltered)]] call BTK_fnc_error;


_objectsReturn