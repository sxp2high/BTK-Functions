/*
	File: fn_spawnVehicle.sqf
	Author: sxp2high (BTK) (btk@arma3.cc)

	Description:
	Creates a vehicle with crew and a random amount of units in cargo.

	Parameter(s):
		0: POSITION - where to spawn the vehicle
		1: FACTION - string
		2: STRING - type of the vehicle, "random" or a vehicle class
		3: NUMBER - spawn radius
		4 (Optional): NUMBER - minimum distance to center
		5 (Optional): ARRAY - [min, max] units in cargo. I.e. use [2,2] to ensure 2 units, [0,0] for none, [99,99] for max capacity.

	Returns:
	ARRAY - [_vehicle, _group];

	Syntax:
	_vehicleArray = [_position, west, "B_MRAP_01_hmg_F", 150, 5, [2,6]] call BTK_fnc_spawnVehicle;
*/


private ["_center","_faction","_type","_spawnRadius","_minDistance","_minCargoUnits","_maxCargoUnits","_cargoUnitsSpawned","_pos","_classesRegular","_classesCrew","_classesHeli","_classesPlane","_classes","_vehicleClasses","_side","_group","_vehicleType","_vehiclePos","_dir","_vehicle","_turrets","_emptyCommander","_emptyCargo","_emptyGunner","_driver","_cargoUnits"];


// Server only
if (!isServer) exitWith {};


// Debug
_debug = true;


// Parameter
_center = _this select 0;
_faction = _this select 1;
_type = _this select 2;
_spawnRadius = _this select 3;
_minDistance = if ((count _this) > 4) then { _this select 4; } else { 0; };
_minCargoUnits = if ((count _this) > 5) then { (_this select 5) select 0; } else { 0; };
_maxCargoUnits = if ((count _this) > 5) then { (_this select 5) select 1; } else { 6; };


// Convert into a position
_pos = [_center] call BTK_fnc_getPos;


// Soldier classes
_classesRegular = switch (_faction) do {

	case (civilian) : { ["B_Soldier_F"]; };
	case (east) : { ["O_Soldier_SL_F", "O_Soldier_TL_F", "O_Soldier_F", "O_Soldier_AR_F", "O_soldier_exp_F", "O_Soldier_GL_F", "O_soldier_M_F", "O_medic_F", "O_soldier_repair_F", "O_Soldier_LAT_F"]; };
	case (resistance) : { ["B_Soldier_F"]; };
	case ("west") : { ["B_Soldier_SL_F", "B_Soldier_TL_F", "B_soldier_AR_F", "B_soldier_exp_F", "B_Soldier_GL_F", "B_soldier_M_F", "B_medic_F", "B_Soldier_F", "B_soldier_repair_F", "B_soldier_LAT_F", "B_Soldier_lite_F"]; };
	case ("me") : { ["CAF_AG_ME_T_AK47", "CAF_AG_ME_T_AK74", "CAF_AG_ME_T_GL", "CAF_AG_ME_T_AK47", "CAF_AG_ME_T_AK74", "CAF_AG_ME_T_GL", "CAF_AG_ME_T_PKM", "CAF_AG_ME_T_RPG", "CAF_AG_ME_T_RPK74", "CAF_AG_ME_T_SVD"]; };
	case ("duala_insurgents") : { ["CAF_AG_ME_T_AK47", "CAF_AG_ME_T_AK74", "CAF_AG_ME_T_GL", "CAF_AG_ME_T_PKM", "CAF_AG_ME_T_RPG", "CAF_AG_ME_T_RPK74", "CAF_AG_ME_T_SVD", "CAF_AG_AFR_P_AK47","CAF_AG_AFR_P_AK74","CAF_AG_AFR_P_GL","CAF_AG_AFR_P_PKM","CAF_AG_AFR_P_RPG","CAF_AG_AFR_P_RPK74","CAF_AG_AFR_P_SVD"]; };

};


// Crew classes
_classesCrew = switch (_faction) do {

	case (civilian) : { ["B_Soldier_F"]; };
	case (east) : { ["O_crew_F"]; };
	case (resistance) : { ["B_Soldier_F"]; };
	case ("west") : { ["B_Soldier_F"]; };
	case ("me") : { ["CAF_AG_ME_T_AK47", "CAF_AG_ME_T_AK74", "CAF_AG_ME_T_GL", "CAF_AG_ME_T_AK47", "CAF_AG_ME_T_AK74", "CAF_AG_ME_T_GL", "CAF_AG_ME_T_PKM", "CAF_AG_ME_T_RPG", "CAF_AG_ME_T_RPK74", "CAF_AG_ME_T_SVD"]; };
	case ("duala_insurgents") : { ["CAF_AG_ME_T_AK47", "CAF_AG_ME_T_AK74", "CAF_AG_ME_T_GL", "CAF_AG_ME_T_PKM", "CAF_AG_ME_T_RPG", "CAF_AG_ME_T_RPK74", "CAF_AG_ME_T_SVD", "CAF_AG_AFR_P_AK47","CAF_AG_AFR_P_AK74","CAF_AG_AFR_P_GL","CAF_AG_AFR_P_PKM","CAF_AG_AFR_P_RPG","CAF_AG_AFR_P_RPK74","CAF_AG_AFR_P_SVD"]; };

};


// Air crew classes
_classesHeli = switch (_faction) do {

	case (civilian) : { ["B_Soldier_F"]; };
	case (east) : { ["O_helipilot_F"]; };
	case (resistance) : { ["B_Soldier_F"]; };
	case ("west") : { ["B_helicrew_F"]; };
	case ("me") : { ["B_Hunter_F"]; };
	case ("duala_insurgents") : { ["CAF_AG_ME_T_AK47", "CAF_AG_ME_T_AK74", "CAF_AG_ME_T_GL", "CAF_AG_ME_T_PKM", "CAF_AG_ME_T_RPG", "CAF_AG_ME_T_RPK74", "CAF_AG_ME_T_SVD", "CAF_AG_AFR_P_AK47","CAF_AG_AFR_P_AK74","CAF_AG_AFR_P_GL","CAF_AG_AFR_P_PKM","CAF_AG_AFR_P_RPG","CAF_AG_AFR_P_RPK74","CAF_AG_AFR_P_SVD"]; };

};


// Plane crew classes (pilot)
_classesPlane = switch (_faction) do {

	case (civilian) : { ["B_Soldier_F"]; };
	case (east) : { ["B_Soldier_F"]; };
	case (resistance) : { ["B_Soldier_F"]; };
	case ("west") : { ["B_Pilot_F"]; };
	case ("me") : { ["B_Hunter_F"]; };
	case ("duala_insurgents") : { ["GLT_Middle_East_Teamleader", "GLT_Middle_East_Rifleman1", "GLT_Middle_East_Rifleman2", "CAF_AG_AFR_P_AK47","CAF_AG_AFR_P_AK74","CAF_AG_AFR_P_GL", "GLT_Middle_East_Ammobearer", "GLT_Middle_East_Autorifleman", "GLT_Middle_East_Engineer", "GLT_Middle_East_Exp_Specialist","GLT_Middle_East_Grenadier", "GLT_Middle_East_Marksman", "GLT_Middle_East_Medical_Specialist", "GLT_Middle_East_Rifleman_AA", "GLT_Middle_East_Rifleman_AT", "GLT_Middle_East_Rifleman_LAT", "GLT_Middle_East_Rifleman1", "GLT_Middle_East_Rifleman2", "GLT_Middle_East_Rifleman3", "GLT_Middle_East_Rifleman4", "GLT_Middle_East_Rifleman5", "GLT_Middle_East_Rifleman6", "GLT_Middle_East_Sniper", "CAF_AG_AFR_P_AK47","CAF_AG_AFR_P_AK74","CAF_AG_AFR_P_GL","CAF_AG_AFR_P_PKM","CAF_AG_AFR_P_RPG","CAF_AG_AFR_P_RPK74","CAF_AG_AFR_P_SVD"]; };

};


// Vehicle classes
_vehicleClasses = switch (_faction) do {

	case (civilian) : { ["B_Hunter_F"]; };
	case (east) : { ["O_MRAP_02_F", "O_MRAP_02_gmg_F", "O_MRAP_02_hmg_F", "O_Truck_02_transport_F", "O_Truck_02_covered_F", "O_APC_Tracked_02_cannon_F", "O_APC_Wheeled_02_rcws_F", "O_MBT_02_cannon_F", "O_APC_Tracked_02_AA_F"]; };
	case (resistance) : { ["B_Hunter_F"]; };
	case ("west") : { ["B_Truck_01_transport_F", "B_MRAP_01_hmg_F", "B_MRAP_01_F", "B_APC_Tracked_01_rcws_F", "B_APC_Tracked_01_AA_F", "B_APC_Wheeled_01_cannon_F"]; };
	case ("me") : { ["B_G_Offroad_01_armed_F","CAF_AG_ME_T_Offroad_armed_01","CAF_AG_eeur_r_Offroad_armed_01","B_G_Van_01_transport_F"]; };
	case ("duala_insurgents") : { ["CAF_AG_afr_p_Offroad_armed_01","CAF_AG_eeur_r_Offroad_armed_01","CAF_AG_ME_T_Offroad_armed_01","CAF_AG_eeur_r_van_01","CAF_AG_ME_T_van_01","CAF_AG_afr_p_Offroad","CAF_AG_eeur_r_Offroad","CAF_AG_ME_T_Offroad","rhs_btr70_chdkz","rhs_t72bb_chdkz","GLT_Offroad_MEA_Armed","GLT_Kamaz_Open_MEA","GLT_Kamaz_MEA"]; };

};


// Vehicle type
_vehicleType = switch (_type) do {

	case ("random") : { (_vehicleClasses call BIS_fnc_selectRandom); };
	default { _this select 2; };

};


// Get class array based on vehicle type
_classes = switch (true) do {
	case (_vehicleType isKindOf "Helicopter") : { _classesHeli; };
	case (_vehicleType isKindOf "Plane") : { _classesPlane; };
	case (_vehicleType isKindOf "Tank") : { _classesCrew; };
	default { _classesRegular; };
};


// Get side
_side = switch (_faction) do {

	case ("west") : { west; };
	case ("me") : { east; };
	case ("duala_insurgents") : { east; };

};


// Create group
_group = createGroup _side;


// Position and dir
_vehiclePos = [_pos, _spawnRadius, _minDistance, 6, 6, 0.3, 0, true, true] call BTK_fnc_getPosFlatEmpty;
_dir = (round (random 359));


// Create vehicle
_vehicle = createVehicle [_vehicleType, _vehiclePos, [], 0, "NONE"];
_vehicle setDir _dir;
_vehicle setPosATL [(_vehiclePos select 0), (_vehiclePos select 1), 0];


// Get turrets
_turrets = [_vehicle,[]] call BIS_fnc_getTurrets;
_turrets = if ((count _turrets) > 0) then { (_turrets - [(_turrets select 0)]); } else { []; }; // First turret is gunner


// Get empty seats
_emptyCommander = _vehicle emptyPositions "commander";
_emptyCargo = _vehicle emptyPositions "cargo";
_emptyGunner = _vehicle emptyPositions "gunner";


// Define cargo amount
_cargoUnits = if (_minCargoUnits == _maxCargoUnits) then { (_maxCargoUnits min (_emptyCargo - 1)); } else { ((_minCargoUnits + (floor (random (_maxCargoUnits - _minCargoUnits)))) min (_emptyCargo - 1)); };


// Spawn driver
_driver = _group createUnit [(_classes call BIS_fnc_selectRandom), _vehiclePos, [], 0, "FORM"];
_driver assignAsDriver _vehicle;
_driver moveInDriver _vehicle;
[_driver] joinSilent _group;


// Spawn commander
if (_emptyCommander > 0) then {

	for "_j" from 1 to _emptyCommander do {

		private ["_unit"];

		_unit = _group createUnit [(_classes call BIS_fnc_selectRandom), _vehiclePos, [], 0, "FORM"];
		_unit assignAsCommander _vehicle;
		_unit moveInCommander _vehicle;
		[_unit] joinSilent _group;

	};

};


// Spawn gunner
if (_emptyGunner > 0) then {

	for "_j" from 1 to _emptyGunner do {

		private ["_unit"];

		_unit = _group createUnit [(_classes call BIS_fnc_selectRandom), _vehiclePos, [], 0, "FORM"];
		_unit assignAsGunner _vehicle;
		_unit moveInGunner _vehicle;
		[_unit] joinSilent _group;

	};

};


// Spawn turret gunners
if ((count _turrets) > 0) then {

	{
			private ["_unit"];

			_unit = _group createUnit [(_classes call BIS_fnc_selectRandom), _vehiclePos, [], 0, "FORM"];
			_unit assignAsTurret [_vehicle, _x];
			_unit moveInTurret [_vehicle, _x];
			[_unit] joinSilent _group;
		
	} forEach _turrets;

};


// Spawn cargo units
if ((_emptyCargo > 0) && (_maxCargoUnits > 0)) then {

	for "_j" from 1 to _cargoUnits do {

		private ["_unit"];
		_unit = _group createUnit [(_classesRegular call BIS_fnc_selectRandom), _vehiclePos, [], 0, "FORM"]; // Cargo units are always regular units
		_unit assignAsCargo _vehicle;
		_unit moveInCargo _vehicle;
		[_unit] joinSilent _group;

	};

};


// Initial behaviour
_group setBehaviour "SAFE";


// Set skill
if (!(isNil "btk_ai_skill")) then {
	{
		_unit = _x;
		{
			_unit setSkill _x;
		} forEach btk_ai_skill;
	} forEach (units _group);
};


// Debug
if (_debug && !(isNil "btk_global_debug")) then {
	[_group] call BTK_fnc_debugMarker;
};


// Make sure it survives spawn -.-
_vehicle spawn {
	_this allowDamage false;
	sleep 4;
	_this allowDamage true;
};


[_vehicle, _group]