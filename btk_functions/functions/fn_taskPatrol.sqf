/*
	File: fn_taskPatrol.sqf
	Author: sxp2high (BTK) (btk@arma3.cc)

	Description:
	The group will patrol the given sector. They will also move into buildings on occasion.
	Random waypoints will be generated on-the-fly, the group will wait up to 2 minutes after each waypoint.
	They might spread out at each waypoint.

	Parameter(s):
		0: GROUP - target group
		1: POSITION - position
		2: NUMBER - radius
		3 (Optional): STRING - formation, if not specified a random formation will be choosen

	Returns:
	BOOLEAN - group initialized

	Syntax:
	_patrolling = [_group, _position, _radius] call BTK_fnc_taskPatrol
*/


private ["_debug", "_debugShowChatter", "_group", "_pos", "_radius", "_formation", "_groupLeader", "_buildings", "_isVehiclePatrol", "_isAirPatrol", "_isShipPatrol", "_wpRadius"];


_debug = true;
_debugShowChatter = false;


// Formations to choose from
_formations = ["NO CHANGE", "COLUMN", "STAG COLUMN", "WEDGE", "ECH LEFT", "ECH RIGHT", "VEE", "LINE", "FILE", "DIAMOND"];


// Parameter
_group = _this select 0;
_pos = _this select 1;
_radius = _this select 2;
_formation = if (count _this > 3) then { if ((_this select 3) == "RANDOM") then { (_formations call BIS_fnc_selectRandom); } else { _this select 3; }; } else { (_formations call BIS_fnc_selectRandom); };
_groupLeader = (leader _group);
_buildings = [_pos, _radius] call BTK_fnc_nearBuildings;


// Only local, never for players
if (!(local _groupLeader) || (isPlayer _groupLeader)) exitWith {};


// Is it foot patrol?
_isVehiclePatrol = if ((vehicle _groupLeader) isKindOf "Man") then { false; } else { true; };
_isAirPatrol = if ((vehicle _groupLeader) isKindOf "Air") then { true; } else { false; };
_isShipPatrol = if ((vehicle _groupLeader) isKindOf "Ship") then { true; } else { false; };
_wpRadius = if ((_isVehiclePatrol) || (_isAirPatrol) || (_isShipPatrol)) then { if ((_isAirPatrol)) then { 300; } else { 100; };  } else { 50; };


// Patrol flow
[_group, _pos, _radius, _formation, _groupLeader, _debug, _wpRadius, _buildings, _isVehiclePatrol, _isAirPatrol, _isShipPatrol, _debugShowChatter] spawn {

	// Variables
	_group = _this select 0;
	_pos = _this select 1;
	_radius = _this select 2;
	_formation = _this select 3;
	_groupLeader = _this select 4;
	_debug = _this select 5;
	_wpRadius = _this select 6;
	_buildings = _this select 7;
	_isVehiclePatrol = _this select 8;
	_isAirPatrol = _this select 9;
	_isShipPatrol = _this select 10;
	_debugShowChatter = _this select 11;
	_wpsCreated = 0;

	// While group has alive members
	while {(({alive _x} count (units _group)) > 0)} do {

		while {(count (waypoints _group)) > 0} do { deleteWaypoint ((waypoints _group) select 0); };

		// WP Pos and random waiting time, based on vehicle type
		_wpPos = if (_isShipPatrol) then { [_pos, _radius, 0, true, true] call btk_fnc_getPosRandom; } else { [_pos, _radius, 0, 0, 2, 1.0, 0, false, true] call BTK_fnc_getPosFlatEmpty; };
		_wpTimeout = if ((_isVehiclePatrol) || (_isAirPatrol) || (_isShipPatrol)) then { if (_isVehiclePatrol) then { (15 + (round (random 35))); } else { (30 + (round (random 90))); };  } else { (60 + (round (random 120))); };
		_markerId = str(_wpPos);

		// Units on foot maybe walk into a building
		if (((random 1) > 0.65) && ((count _buildings) > 0) && !(_isVehiclePatrol) && !(_isAirPatrol) && !(_isShipPatrol)) then {
			_building = _buildings call BIS_fnc_selectRandom;
			_buildingPositions = [_building] call BTK_fnc_getBuildingPositions;
			_wpPos = _buildingPositions call BIS_fnc_selectRandom;
		};

		// Assign
		_wp = _group addWaypoint [_wpPos, 0];
		_wp setWaypointType "MOVE";
		_wp setWaypointCompletionRadius _wpRadius;

		// Special values for first wp
		if (_wpsCreated == 0) then {
			_wpsCreated = _wpsCreated + 1;
			_group setBehaviour "SAFE";
			if (!(_isVehiclePatrol) && !(_isAirPatrol) && !(_isShipPatrol)) then { _wp setWaypointSpeed "LIMITED"; } else { _wp setWaypointSpeed "FULL"; };
			_wp setWaypointBehaviour "SAFE";
			_wp setWaypointFormation _formation;
		};

		// Debug
		if (_debug && !(isNil "btk_global_debug")) then {
			_marker = createMarker [_markerId, _wpPos];
			_marker setMarkerShape "ICON";
			_marker setMarkerType "waypoint";
			_marker setMarkerColor "ColorOrange";
			_marker setMarkerSize [0.75, 0.75];
		};

		if (_debugShowChatter) then { systemChat format["(%1): patrol: move to that position!", (groupId _group)]; };

		// Wait until arrived or all dead
		//while {(({alive _x} count (units _group)) > 0) && (((vehicle (leader _group)) distance _wpPos) > _wpRadius)} do { sleep 5; hint format["current wp: %1\nwps: %2", (currentWaypoint _group), (waypoints _group)]; };
		while {(({alive _x} count (units _group)) > 0) && ((currentWaypoint _group) == 0)} do { sleep 5; };

		if (_debug && !(isNil "btk_global_debug")) then { deleteMarker _markerId; };

		// Still alive?
		if ((({alive _x} count (units _group)) > 0)) then {

			// On-foot patrols maybe spread out
			if (!(_isVehiclePatrol) && !(_isAirPatrol) && !(_isShipPatrol) && ((random 1) > 0)) then {

				_units = (units _group);

				{

					[_x, _wpPos, _buildings, _debug, _debugShowChatter] spawn {

						_unit = (_this select 0);
						_wpPos = (_this select 1);
						_buildings = (_this select 2);
						_debug = (_this select 3);
						_debugShowChatter = (_this select 4);
						_isLeader = if (_unit == (leader (group _unit))) then { true; } else { false; };
						_unitWpPos = (getPosATL _unit);

						waitUntil {sleep 3.847; ((speed (vehicle (leader (group _unit)))) == 0)};
						sleep (round (random 5));

						// leader?
						if (!_isLeader) then {

							_unitPos = getPosATL _unit;

							// They might go inside buildings or to a vehicle
							if ((random 1) > 0.5) then {

								if (_debugShowChatter) then { systemChat format["(%1): patrol: spread out! move to that building!", groupId (group _unit)]; };

								_buildings = [_unitPos, 50] call BTK_fnc_nearBuildings;

								// Buildings found
								if ((count _buildings) > 0) then {

									_building = _buildings call BIS_fnc_selectRandom;
									_buildingPositions = [_building] call BTK_fnc_getBuildingPositions;
									_unitWpPos = _buildingPositions call BIS_fnc_selectRandom;

								} else {

									_vehicles = _unitPos nearEntities [["Air", "Car", "Motorcycle", "Tank"], 50];

									// Vehicles found
									if (((count _vehicles) > 0) && ((random 1) > 0.0)) then {

										if (_debugShowChatter) then { systemChat format["(%1): patrol: spread out! move to that vehicle!", groupId (group _unit)]; };

										_vehicle = _vehicles call BIS_fnc_selectRandom;
										_unitWpPos = (getPosATL _vehicle);

									} else {

										if (_debugShowChatter) then { systemChat format["(%1): patrol: spread out! move to that position!", groupId (group _unit)]; };

										_unitWpPos = [_unitPos, 50, 0, 0, 2, 1.0, 0, false, true] call BTK_fnc_getPosFlatEmpty;

									};

								};

							} else {

								if (_debugShowChatter) then { systemChat format["(%1): patrol: spread out! move to that position!", groupId (group _unit)]; };

								_unitWpPos = [_unitPos, 50, 0, 0, 2, 1.0, 0, false, true] call BTK_fnc_getPosFlatEmpty;

							};

							sleep 2;

							if ((behaviour _unit) == "SAFE") then {

								_unit commandMove _unitWpPos;

								//_vh = createVehicle ["Sign_Arrow_Yellow_F", _unitWpPos, [], 0, "NONE"];
								//_vh setPosATL [(_unitWpPos select 0), (_unitWpPos select 1), (1.5 + (random 1.5))];

								waitUntil {sleep 2.861; ((_unit distance _unitWpPos) < 3)};
								sleep 1;
								if (_debugShowChatter) then { systemChat format["(%1): patrol: wait there!", groupId (group _unit)]; };
								commandStop _unit;
								sleep 5;
								//deleteVehicle _vh;

							};

						};

					};

				} forEach _units;

				sleep _wpTimeout;

				{ _x commandMove (getPosATL (vehicle _x)); } forEach _units;

				if (_debugShowChatter) then { systemChat format["(%1): patrol: regroup!", (groupId _group)]; };

				sleep (8 + (random 15));

				if (_debugShowChatter) then { systemChat format["(%1): patrol: let's move on!", (groupId _group)]; };

			} else {

				sleep _wpTimeout;

				if (_debugShowChatter) then { systemChat format["(%1): patrol: let's move on!", (groupId _group)]; };

				if (_debug && !(isNil "btk_global_debug")) then { deleteMarker _markerId; };

			};

		// All dead
		} else {

			sleep 5;

			if (_debug && !(isNil "btk_global_debug")) then { deleteMarker _markerId; };

		};

	};

};


true;