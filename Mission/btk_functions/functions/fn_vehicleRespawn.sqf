/*
	File: fn_vehicleRespawn.sqf
	Author: sxp2high (BTK) (btk@arma3.cc)

	Description:
	Vehicle respawn.

	Parameter(s):
		0: OBJECT - vehicle
		1: NUMBER - how many respawns
		2: BOOLEAN - true to also respawn when deserted
		3: NUMBER - respawn destroyed time
		4: NUMBER - respawn deserted time
		5: NUMBER - respawn deserted distance to players

	Returns:
	NIL

	Syntax:
	[this, 2, true, 10, 10, 100] spawn BTK_fnc_vehicleRespawn;
*/


// Server only
if (!isServer) exitWith {};


// Parameter
_vehicle = _this select 0;
_respawnsRemaining = if ((count _this) > 1) then { _this select 1; } else { 99; };
_respawnDeserted = if ((count _this) > 2) then { _this select 2; } else { false; };
_destroyedRespawnTime = if ((count _this) > 3) then { _this select 3; } else { 30; };
_desertedRespawnTime = if ((count _this) > 4) then { _this select 4; } else { 60; };
_desertedDistance = if ((count _this) > 5) then { _this select 5; } else { 2000; };


// Variables
_varName = vehicleVarName _vehicle;
_pos = [((getPosATL _vehicle) select 0), ((getPosATL _vehicle) select 1), ((getPosATL _vehicle) select 2)];
_dir = getDir _vehicle;
_type = typeOf _vehicle;
_desertedCount = 0;
_deserted = false;


// Respawn fnc
_respawn = {

	private ["_vehicle","_varName","_pos","_dir","_type","_newVehicle"];

	// Parameter
	_vehicle = _this select 0;
	_varName = _this select 1;
	_pos = _this select 2;
	_dir = _this select 3;
	_type = _this select 4;

	// Delete old
	deleteVehicle _vehicle;

	// Spawn new
	_newVehicle = createVehicle [_type, _pos, [], 0, "NONE"];
	_newVehicle setDir _dir;
	_newVehicle setPosATL [(_pos select 0), (_pos select 1), ((_pos select 2) + 0.01)];
	[[_newVehicle, _varName], "setVehicleVarName", "", false, true] call BTK_fnc_mp;

	_newVehicle

};


// Deserted check fnc
_desertedCheck = {

	private ["_vehicle","_desertedDistance","_return","_checked"];

	// Parameter
	_vehicle = _this select 0;
	_desertedDistance = _this select 1;
	_return = false;
	_checked = 0;

	// Is empty?
	if ({alive _x} count (crew _vehicle) == 0) then {

		// Check all players
		{
			if (((_vehicle distance _x) > _desertedDistance)) then { _checked = _checked + 1; };
		} forEach (switchableUnits + playableUnits);

		// Found a  player nearby
		if (_checked == (count (switchableUnits + playableUnits))) then { _return = true; };

	};

	_return

};


// Random delay
sleep (random 10);


// Wait until it has been moved or is destroyed
waitUntil {sleep 5.532; ((_vehicle distance _pos) > 50) || !(alive _vehicle)};


// While respawns remaining
while {_respawnsRemaining > 0} do {

	// Delay
	_pause = true;
	sleep 10;

	// Destroyed or deserted, respawn
	if (!(alive _vehicle) || (_desertedCount >= _desertedRespawnTime)) then {

		// Respawn time
		if (!(alive _vehicle)) then {
			sleep _destroyedRespawnTime;
		} else {
			sleep _desertedRespawnTime;
		};

		// Respawn, overwrite _vehicle
		_vehicle = [_vehicle, _varName, _pos, _dir, _type] call _respawn;

		// Done
		if (_respawnsRemaining != 99) then { _respawnsRemaining = _respawnsRemaining - 1; };
		_deserted = false;
		_pause = false;
	
	} else {

		// Done
		_pause = false;

	};

	// Wait for handle to finish
	waitUntil {!_pause};

	// Deserted check if no crew
	_deserted = [_vehicle, _desertedDistance] call _desertedCheck;
	
	// Deserted?
	if (_deserted && _respawnDeserted) then {
		_desertedCount = _desertedCount + 10;	
	} else {
		_desertedCount = 0;
	};


};