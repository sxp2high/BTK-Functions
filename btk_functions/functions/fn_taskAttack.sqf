/*
	File: fn_taskAttack.sqf
	Author: sxp2high (BTK) (btk@arma3.cc)

	Description:
	The group will attack the given position.

	Parameter(s):
		0: GROUP - the group
		1: POSITION - position to attack

	Returns:
	BOOLEAN - true when initialized

	Syntax:
	_attacking = [_group, (getPosATL player)] call BTK_fnc_taskAttack;
*/


private ["_debug", "_group", "_pos", "_groupLeader", "_formations", "_formation", "_wp"];


_debug = false;


// Parameter
_group = _this select 0;
_pos = _this select 1;
_groupLeader = (leader _group);
_formations = ["NO CHANGE", "COLUMN", "STAG COLUMN", "WEDGE", "ECH LEFT", "ECH RIGHT", "VEE", "LINE", "FILE", "DIAMOND"];
_formation = (_formations call BIS_fnc_selectRandom);
_isAirPatrol = if ((vehicle _groupLeader) isKindOf "Air") then { true; } else { false; };


// Only local, never for players
if (!(local _groupLeader) || (isPlayer _groupLeader)) exitWith {};


// Delete all current wps
while {(count (waypoints _group)) > 0} do {
	deleteWaypoint ((waypoints _group) select 0);
};


// Make units available
if (!_isAirPatrol) then {
	{

		if ((vehicle _x) isKindOf "StaticWeapon") then {
			unassignVehicle _x;
			_x action ["Eject", (vehicle _x)];
		};

		_x playActionNow "Combat";
		_x setUnitPos "Auto";

	} forEach (units _group);
};


// Flow
[_group, _formation, _pos] spawn {

	_group = _this select 0;
	_formation = _this select 1;
	_pos = _this select 2;
	_isAir = if ((vehicle (leader _group)) isKindOf "Air") then { true; } else { false; };
	_wpDistance = if (_isAir) then { 350; } else { 200; };

	sleep 1;

	_wp = _group addWaypoint [_pos, 0];
	_wp setWaypointType "SAD";
	_wp setWaypointFormation _formation;
	_wp setWaypointSpeed "FULL";

	// Wait for them to be < 100m to the target position OR all dead
	while {({alive _x} count (units _group) > 0) && (((getPosATL (vehicle (leader _group))) distance _pos) > _wpDistance)} do { sleep 7.897; };

	// Reveal
	{ _group reveal _x; } forEach (_pos nearEntities [["Man", "Air", "Car", "Motorcycle", "Tank"], _wpDistance]);

	// Still alive ?
	if (({alive _x} count (units _group)) > 3) then {

		{

			// Unload cargo units
			if (!(_isAir) && (alive _x) && !((vehicle _x) isKindOf "Man") && (_x != (driver (vehicle _x))) && (_x != (gunner (vehicle _x))) && (_x != (commander (vehicle _x)))) then {
				unassignVehicle _x;
				sleep 1;
				[_x] orderGetIn false;
				sleep 2;
				_movePos = [_pos, 50] call btk_fnc_getPosRandom;
				_x doMove _movePos;
			};

		} forEach  (units _group);

	};

};


true