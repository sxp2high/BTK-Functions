/*
	File: fn_taskPatrolSimple.sqf
	Author: sxp2high (BTK) (btk@arma3.cc)

	Description:
	The group will patrol the given sector.

	Parameter(s):
		0: GROUP - target group
		1: POSITION - position
		2: NUMBER - radius
		3 (Optional): BOOLEAN - group will make breaks

	Returns:
	BOOLEAN - group initialized

	Syntax:
	_patrolling = [_group, _position, _radius, true] call BTK_fnc_taskPatrolSimple
*/


private ["_group","_pos","_radius","_withBreaks","_debug","_wps","_formations","_wpTypes","_amount","_findWpPos"];


// Parameter
_group = _this select 0;
_pos = _this select 1;
_radius = _this select 2;
_withBreaks = if ((count _this) > 3) then { _this select 3; } else { false; };


// Vars
_debug = false;
_wps = [];
_formations = ["NO CHANGE", "COLUMN", "STAG COLUMN", "WEDGE", "ECH LEFT", "ECH RIGHT", "VEE", "LINE", "FILE", "DIAMOND"];
_wpTypes = ["MOVE","LOITER","DISMISS"];
_amount = (3 + (floor (random 4)));


// Find wp pos fnc
_findWpPos = {

	private ["_center","_radius","_wps","_checked","_distance","_minDistance","_pos"];
	
	_center = _this select 0;
	_radius = _this select 1;
	_wps = _this select 2;

	_checked = 0;
	_distance = (_radius * 0.25);
	_minDistance = (_radius * 0.1);

	for "_j" from 1 to 10000 do {

		_checked = 0;
		_pos = [_center, _radius, _minDistance, false] call BTK_fnc_getPosRandom;
		
		{
			if (((_pos distance _x) > _distance)) then { _checked = _checked + 1; };
		} forEach _wps;

		if ((_checked == (count _wps))) exitWith {};

	};

	_pos

};


// Only local, never for players
if (!(local(leader _group)) || (isPlayer (leader _group))) exitWith {};


// Delete all current wps
while {(count (waypoints _group)) > 0} do {
	deleteWaypoint ((waypoints _group) select 0);
};


// Set them to safe initially
_group setBehaviour "SAFE";


// Create waypoints
for "_j" from 0 to _amount do {

	private ["_wpPos","_wpTimeout","_wpType","_wpFormation","_wp"];
	
	_wpPos = [_pos, _radius, _wps] call _findWpPos;
	
	_isAirPatrol = if ((vehicle (leader _group)) isKindOf "Air") then { true; } else { false; };
	_wpTimeout = if (_withBreaks) then { (20 + (round (random 100))); } else { if (_isAirPatrol) then { 0; } else { (round (random 5)); }; };
	_wpType = if ((random 1 > 0) && _withBreaks) then { _wpTypes call BIS_fnc_selectRandom; } else { "MOVE"; };
	_wpFormation = (_formations call BIS_fnc_selectRandom);
	_radius = if (_isAirPatrol) then { 500; } else { 20; };

	_wp = _group addWaypoint [_wpPos, 0];
	if (((count _wps) == 0) && !(_isAirPatrol)) then { _wp setWaypointSpeed "LIMITED"; };
	if ((count _wps) == _amount) then { _wp setWaypointType "CYCLE"; } else { _wp setWaypointType _wpType; };
	_wp setWaypointCompletionRadius _radius;
	_wp setWaypointFormation _wpFormation;
	if (((count _wps) == 0) || ((count _wps) == _amount)) then { _wp setWaypointTimeout [0, 0, 0]; } else { _wp setWaypointTimeout [_wpTimeout, _wpTimeout, _wpTimeout]; };

	_wps set [(count _wps), _wpPos];

	if (_debug && !(isNil "btk_global_debug")) then { [true, str(_wpPos), _wpPos, "ICON", ["waypoint", "Color3_FD_F", 0.8, [0.8, 0.8]]] call BTK_fnc_createMarker; }; 

};


_wps