/*
	File: fn_spawnGroup.sqf
	Author: sxp2high (BTK) (btk@arma3.cc)

	Description:
	Creates a random group with the given amount of units.

	Parameter(s):
		0: ANY - spawn position center
		1: SIDE - side
		2: STRING - type ("nato", "csat", "fia", "me")
		3: NUMBER - radius
		4: NUMBER - minimum distance to center
		5: NUMBER - amount of units in the group

	Returns:
	GROUP - the spawned group

	Syntax:
	_group = [_position, west, "nato", 100, 50, 4] call BTK_fnc_spawnGroup;
*/


private ["_center","_side","_type","_spawnRadius","_minDistance","_amount","_classes","_position","_pos","_nearEntities","_group","_leader"];


// Server only
if (!isServer) exitWith {};


// Parameter
_center = _this select 0;
_side = _this select 1;
_type = _this select 2;
_spawnRadius = _this select 3;
_minDistance = _this select 4;
_amount = _this select 5;


// Unit classes
_classes =  switch (_type) do {

	case ("nato") : {
		[
			["B_Soldier_SL_F", "B_Soldier_TL_F"],
			["B_soldier_AR_F", "B_soldier_exp_F", "B_Soldier_GL_F", "B_soldier_M_F", "B_medic_F", "B_Soldier_F", "B_soldier_repair_F", "B_soldier_LAT_F", "B_Soldier_lite_F"]
		];
	};

	case ("csat") : {
		[
			["O_Soldier_SL_F", "O_Soldier_TL_F"],
			["O_Soldier_F", "O_Soldier_AR_F", "O_soldier_exp_F", "O_Soldier_GL_F", "O_soldier_M_F", "O_medic_F", "O_soldier_repair_F", "O_Soldier_LAT_F", "O_Soldier_lite_F"]
		];
	};

	case ("fia") : {
		[
			["B_G_officer_F", "B_G_Soldier_SL_F", "B_G_Soldier_TL_F"],
			["B_G_Soldier_A_F", "B_G_Soldier_AR_F", "B_G_medic_F", "B_G_engineer_F", "B_G_Soldier_exp_F", "B_G_Soldier_GL_F", "B_G_Soldier_M_F", "B_G_Soldier_F", "B_G_Soldier_LAT_F", "B_G_Soldier_lite_F"]
		];
	};

	case ("me") : {
		[
			["CAF_AG_ME_T_AK47", "CAF_AG_ME_T_AK74", "CAF_AG_ME_T_GL"],
			["CAF_AG_ME_T_AK47", "CAF_AG_ME_T_AK74", "CAF_AG_ME_T_GL", "CAF_AG_ME_T_PKM", "CAF_AG_ME_T_RPG", "CAF_AG_ME_T_RPK74", "CAF_AG_ME_T_SVD"]
		];
	};

	case ("glt_me") : {
		[
			["GLT_Middle_East_Teamleader"],
			["GLT_Middle_East_Ammobearer","GLT_Middle_East_Autorifleman","GLT_Middle_East_Engineer","GLT_Middle_East_Exp_Specialist","GLT_Middle_East_Grenadier","GLT_Middle_East_Marksman","GLT_Middle_East_Medical_Specialist","GLT_Middle_East_Rifleman6","GLT_Middle_East_Rifleman2","GLT_Middle_East_Rifleman1","GLT_Middle_East_Rifleman4","GLT_Middle_East_Rifleman5","GLT_Middle_East_Rifleman3","GLT_Middle_East_Rifleman_AA","GLT_Middle_East_Rifleman_AT","GLT_Middle_East_Rifleman_LAT"]
		];
	};

	case ("duala_insurgents") : {
		[
			["GLT_Middle_East_Teamleader", "GLT_Middle_East_Rifleman1", "GLT_Middle_East_Rifleman2"],
			["GLT_Middle_East_Ammobearer", "GLT_Middle_East_Autorifleman", "GLT_Middle_East_Engineer", "GLT_Middle_East_Exp_Specialist","GLT_Middle_East_Grenadier", "GLT_Middle_East_Marksman", "GLT_Middle_East_Medical_Specialist", "GLT_Middle_East_Rifleman_AA", "GLT_Middle_East_Rifleman_AT", "GLT_Middle_East_Rifleman_LAT", "GLT_Middle_East_Rifleman1", "GLT_Middle_East_Rifleman2", "GLT_Middle_East_Rifleman3", "GLT_Middle_East_Rifleman4", "GLT_Middle_East_Rifleman5", "GLT_Middle_East_Rifleman6", "GLT_Middle_East_Sniper"]
		];
	};

	case ("rhs_us_army_woodland") : {
		[
			["rhsusf_army_ocp_squadleader","rhsusf_army_ocp_teamleader","rhsusf_army_ocp_fso"],
			["rhsusf_army_ocp_aa","rhsusf_army_ocp_javelin","rhsusf_army_ocp_autorifleman","rhsusf_army_ocp_autoriflemana","rhsusf_army_ocp_medic","rhsusf_army_ocp_engineer","rhsusf_army_ocp_grenadier","rhsusf_army_ocp_jfo","rhsusf_army_ocp_machinegunner","rhsusf_army_ocp_machinegunnera","rhsusf_army_ocp_marksman","rhsusf_army_ocp_rifleman","rhsusf_army_ocp_riflemanat","rhsusf_army_ocp_uav"]
		];
	};

	case ("rhs_us_army_desert") : {
		[
			["rhsusf_army_ucp_squadleader","rhsusf_army_ucp_teamleader","rhsusf_army_ucp_fso"],
			["rhsusf_army_ucp_aa","rhsusf_army_ucp_javelin","rhsusf_army_ucp_autorifleman","rhsusf_army_ucp_autoriflemana","rhsusf_army_ucp_medic","rhsusf_army_ucp_engineer","rhsusf_army_ucp_grenadier","rhsusf_army_ucp_jfo","rhsusf_army_ucp_machinegunner","rhsusf_army_ucp_machinegunnera","rhsusf_army_ucp_marksman","rhsusf_army_ucp_rifleman","rhsusf_army_ucp_riflemanat","rhsusf_army_ucp_uav"]
		];
	};

};


// Get spawn position
_position = [_center] call BTK_fnc_getPos;
//_pos = [_position, _spawnRadius, _minDistance] call BTK_fnc_getPosFlatEmpty;
_pos = [_position, _spawnRadius, _minDistance, 5, 5, 0.5, 0, true, true] call BTK_fnc_getPosFlatEmpty;


// Create group
_group = createGroup _side;


// Spawn leader
_leader = _group createUnit [((_classes select 0) call BIS_fnc_selectRandom), _pos, [], 0, "FORM"];
_leader setRank "SERGEANT";
[_leader] joinSilent _group;


// Spawn group member
for "_j" from 1 to (_amount - 1) do {
	private ["_unit"];
	_unit = _group createUnit [((_classes select 1) call BIS_fnc_selectRandom), _pos, [], 0, "FORM"];
	_unit setRank "PRIVATE";
	[_unit] joinSilent _group;
};


// Select leader
_group selectLeader _leader;


// Set skill
if (!(isNil "btk_ai_skill")) then {
	{
		_unit = _x;
		{
			_unit setSkill _x;
		} forEach btk_ai_skill;
	} forEach (units _group);
};


_group