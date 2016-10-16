/*
	File: fn_taskDefend.sqf
	Author: sxp2high (BTK) (btk@arma3.cc)

	Description:
	The group will defend/hold the given location.
	They will use statics, vehicles, buildings - in that order.

	Parameter(s):
		0: GROUP - the group
		1: POSITION - position
		2: NUMBER - radius

	Returns:
	BOOLEAN - true when initialized

	Syntax:
	_defending = [_group, _position, _radius] call BTK_fnc_taskDefend;
*/


private ["_debug", "_group", "_pos", "_radius", "_units", "_wpPos", "_allStatics", "_allVehicles", "_statics", "_wp"];


_debug = false;


// Parameter
_group = _this select 0;
_pos = _this select 1;
_radius = _this select 2;
_useStatics = if (count _this > 3) then { _this select 3; } else { true; };
_useVehicles = if (count _this > 4) then { _this select 4; } else { true; };
_useBuildings = if (count _this > 5) then { _this select 5; } else { true; };
_groupLeader = (leader _group);
_units = (units _group);


// Only local, never for players
if (!(local _groupLeader) || (isPlayer _groupLeader)) exitWith {};


// Delete all current wps
while {(count (waypoints _group)) > 0} do {
	deleteWaypoint ((waypoints _group) select 0);
};


// Variables
_isVehiclePatrol = if ((vehicle _groupLeader) isKindOf "Man") then { false; } else { true; };
_isAirPatrol = if ((vehicle _groupLeader) isKindOf "Air") then { true; } else { false; };
_allStatics = _pos nearEntities ["StaticWeapon", _radius];
_allVehicles = _pos nearEntities [["LandVehicle","Tank"], _radius];
_buildings = [_pos, _radius] call BTK_fnc_nearBuildings;
_wpPos = [_pos, _radius] call BTK_fnc_getPosFlatEmpty;
_statics = [];
_vehicles = [];


// Initial behaviour
_group setBehaviour "SAFE";


// Not vehicle
if (!_isVehiclePatrol) then {

	if ((count _allStatics) > 0) then {
		{ if (((_x emptyPositions "gunner") > 0) && (isNil {_x getVariable "btk_ai_dont_use"})) then { _statics set [(count _statics), _x]; }; } forEach _allStatics;
	};


	if ((count _allVehicles) > 0) then {
		{ if ((((_x emptyPositions "gunner") > 0) || ((_x emptyPositions "commander") > 0)) && (isNil {_x getVariable "btk_ai_dont_use"})) then { _vehicles set [(count _vehicles), _x]; }; } forEach _allVehicles;
	};

	// Mount statics
	if (_useStatics && ((count _statics) > 0) && ((count _units) > 0)) then {

		{

			private ["_unit"];

			if ((count _units) > 0) then {

				_unit = _units select 0;

				_unit assignAsGunner _x;
				[_unit] orderGetIn true;

				_units  = _units - [_unit];

			};

		} forEach _statics;

	};


	// Mount vehicles
	if (_useVehicles && ((count _vehicles) > 0) && ((count _units) > 0)) then {

		{

			private ["_unit"];

			if ((count _units) > 0 && ((_x emptyPositions "gunner") > 0)) then {

				_unit = _units select 0;

				_unit assignAsGunner _x;
				[_unit] orderGetIn true;

				_units = _units - [_unit];

			};

			if ((count _units) > 0 && ((_x emptyPositions "commander") > 0)) then {

				_unit = _units select 0;

				_unit assignAsCommander _x;
				[_unit] orderGetIn true;

				_units = _units - [_unit];

			};

		} forEach _vehicles;

	};


	// Use buildings
	if (_useBuildings && ((count _buildings) > 0) && ((count _units) > 0)) then {

		// Get all building positions
		_buildingPositions = [];
		{

			private ["_building","_buildingPositionsX"];

			_building = _x;
			_buildingPositionsX = [_building] call BTK_fnc_getBuildingPositions;

			{
				_buildingPositions set [(count _buildingPositions), _x];
			} forEach _buildingPositionsX;


		} forEach _buildings;

		// Use all building positions
		{

			private ["_unit", "_buildingPos"];

			if (((count _units) > 0)) then {

				_unit = _units select 0;
				_buildingPos = _x;
				_buildingPositions = _buildingPositions - [_buildingPos];

				[_unit, _buildingPos] spawn {

					_unit = _this select 0;
					_buildingPos = _this select 1;

					waitUntil {((_unit distance _buildingPos) < 5)};
					sleep 2;
					doStop _unit;
				if ((random 1) > 0.5) then { _unit setUnitPos "UP"; } else { _unit setUnitPos "DOWN"; };

				};

				_unit commandMove _buildingPos;

				_units = _units - [_unit];

			};

		} forEach _buildingPositions;

	};

};


// Remaining units guard on foot
_wp = _group addWaypoint [_wpPos, 20];
_wp setWaypointType "HOLD";


// Remaining units that are not inside a vehicle
if (((count _units) > 0) && !(_isVehiclePatrol)) then {

	{

		private ["_movePos"];

		_movePos = ([_pos, _radius] call BTK_fnc_getPosRandom);

		[_x, _movePos] spawn {

			_unit = _this select 0;
			_movePos = _this select 1;

			_unit doMove _movePos;
			waitUntil {((_unit distance _movePos) < 5)};
			sleep 2;
			doStop _unit;

		};

	} forEach _units;

};


true