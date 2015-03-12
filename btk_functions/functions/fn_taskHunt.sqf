/*
	File: fn_taskHunt.sqf
	Author: sxp2high (BTK) (btk@arma3.cc)

	Description:
	The group will hunt the given object/vehicle/unit/group.

	Parameter(s):
		0: GROUP - the hunting party
		1: OBJECT - the prey

	Returns:
	BOOLEAN - true when initialized

	Syntax:
	_hunting = [group, player] call BTK_fnc_taskHunt;
*/


private ["_debug", "_group", "_pos", "_groupLeader", "_formations", "_formation", "_wp"];


_debug = true;


// Parameter
_group = _this select 0;
_target = _this select 1;
_groupLeader = (leader _group);
_formations = ["NO CHANGE", "COLUMN", "STAG COLUMN", "WEDGE", "ECH LEFT", "ECH RIGHT", "VEE", "LINE", "FILE", "DIAMOND"];
_formation = (_formations call BTK_fnc_selectRandom);


// Only local, never for players
if (!(local _groupLeader) || (isPlayer _groupLeader)) exitWith {};


// Delete all current wps
while {(count (waypoints _group)) > 0} do {
	deleteWaypoint ((waypoints _group) select 0);
};


// Make units available
{

	if ((vehicle _x) isKindOf "StaticWeapon") then {
		unassignVehicle _x;
		_x action ["Eject", (vehicle _x)];
	};

	_x playActionNow "Combat";
	_x setUnitPos "Auto";

} forEach (units _group);


// Flow
[_group, _formation, _target] spawn {

	_group = _this select 0;
	_formation = _this select 1;
	_target = _this select 2;

	sleep 2;

	// Wait for them to be < 100m to the target position OR all dead
	while {({alive _x} count (units _group) > 0) && (((getPosATL (vehicle (leader _group))) distance _target) > 200)} do {

		_wpPos = [_target, 150] call btk_fnc_getPosRandom;
		_wp = _group addWaypoint [_wpPos, 0];
		_wp setWaypointType "SAD";
		_wp setWaypointFormation _formation;
		_wp setWaypointSpeed "FULL";
		_group reveal _target;

		sleep 60;

	};

};


// Debug
if (_debug && !(isNil "btk_global_debug")) then {

	[_group, _target] spawn {

		_group = _this select 0;
		_target = _this select 1;
		_pos = (getPosATL _target);

		_marker = createMarker [str(random 999999), _pos];
		_marker setMarkerShape "ICON";
		_marker setMarkerType "hd_destroy";
		_marker setMarkerColor "ColorRed";
		_marker setMarkerSize [0.5, 0.5];
		_marker setMarkerText format["hunt"];

		while {{alive _x} count (units _group) > 0} do { sleep 5; _marker setMarkerPos (getPosATL _target); };

		deleteMarker _marker;

	};

};


if (_debug && !(isNil "btk_global_debug")) then { diag_log text format["=====> btk_fnc_taskHunt : group %1 is now hunting %2!", _group, _target]; };


true;