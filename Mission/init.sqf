// Wait for player
waitUntil {(isDedicated) || !(isNull player)};


btk_global_debug = true;


// Require BTK Functions
waitUntil {!(isNil "btk_functions_init")};


[] call BTK_fnc_lobbyParams;


/*player addAction ["Select Loadout", {

	_uniforms = ["rhs_uniform_cu_ocp_patchless"];

	_vests = switch (typeOf player) do {
		case ("rhsusf_army_ocp_autorifleman") : { ["rhsusf_iotv_ocp","rhsusf_iotv_ocp_SAW"]; };
		default { ["rhsusf_iotv_ocp","rhsusf_iotv_ocp_grenadier","rhsusf_iotv_ocp_medic","rhsusf_iotv_ocp_repair","rhsusf_iotv_ocp_rifleman","rhsusf_iotv_ocp_SAW","rhsusf_iotv_ocp_squadleader","rhsusf_iotv_ocp_teamleader"]; };
	};

	_headgears = ["rhsusf_ach_bare_tan"];

	_attachments = ["rhsusf_acc_compm4"];

	_items = ["FirstAidKit","GLT_Item_Bandage"];

	_backpacks = ["rhsusf_assault_eagleaiii_ocp"];

	_weapons = ["rhs_weap_m4a1","rhs_weap_m4a1_grip"];

	_magazines = [
	"SmokeShell","SmokeShellRed","SmokeShellGreen","SmokeShellYellow","SmokeShellPurple","SmokeShellBlue","SmokeShellOrange","Chemlight_green","Chemlight_red","Chemlight_yellow","Chemlight_blue","rhs_mag_m67","rhs_mag_30Rnd_556x45_M855A1_Stanag"
	];

	[
		true,
		(_uniforms + _vests + _headgears + _attachments + _items),
		_backpacks,
		_weapons,
		_magazines
	] call BTK_fnc_arsenalInit;

} ];*/

if (isServer) then {

	//[["TEST: im not persistent!"], "BTK_fnc_log", "", false, true] spawn BTK_fnc_mp;
	//[["TEST: im persistent!"], "BTK_fnc_log", "", true, true] spawn BTK_fnc_mp;

	/*[] spawn {
		sleep 0.1;
		_index = -1;
		{
			if (_x == "insignia") exitwith {_index = _foreachindex;};
		} foreach getarray (configfile >> "CfgVehicles" >> gettext (configfile >> "CfgWeapons" >> (uniform btk_player_2) >> "ItemInfo" >> "uniformClass") >> "hiddenSelections");
		_cfgTexture = [["CfgUnitInsignia", "111thID"], configfile] call BIS_fnc_loadClass;
		_texture = getText (_cfgTexture >> "texture");
		btk_player_2 setObjectTextureGlobal [_index, _texture];
		//btk_player_2 setObjectTexture [_index, _texture];
	};*/

	/*[] spawn {
		sleep 10;
		//_taskUpdated = [(switchableUnits + playableUnits), "uniqueid", "Succeeded", true] call BTK_fnc_setTaskState;
		[[(switchableUnits + playableUnits), "uniqueid", "Succeeded", true], "BTK_fnc_setTaskState", "", false, true] spawn BTK_fnc_mp;
	};*/

	clearWeaponCargoGlobal btk_crate_1;
	clearMagazineCargoGlobal btk_crate_1;
	clearItemCargoGlobal btk_crate_1;
	clearBackpackCargoGlobal btk_crate_1;

	//btk_crate_1 addBackpackCargoGlobal ["rhsusf_assault_eagleaiii_ocp", 1];
	//btk_crate_1 addItemCargoGlobal ["rhs_uniform_cu_ucp_patchless", 1];
	//btk_crate_1 addItemCargoGlobal ["rhsusf_iotv_ocp", 1];
	btk_crate_1 addItemCargoGlobal ["H_Cap_oli", 1];
	btk_crate_1 addItemCargoGlobal ["NVGoggles", 1];
	btk_crate_1 addItemCargoGlobal ["Rangefinder", 1];
	btk_crate_1 addItemCargoGlobal ["Binocular", 1];
	btk_crate_1 addItemCargoGlobal ["FirstAidKit", 5];
	btk_crate_1 addItemCargoGlobal ["Medikit", 1];
	//btk_crate_1 addItemCargoGlobal ["rhsusf_acc_EOTECH", 1];

	//btk_crate_1 addMagazineCargoGlobal ["rhs_mag_30Rnd_556x45_M855A1_Stanag", 30];
	btk_crate_1 addMagazineCargoGlobal ["16Rnd_9x21_Mag", 30];
	btk_crate_1 addMagazineCargoGlobal ["Titan_AT", 10];

	btk_crate_1 addWeaponCargoGlobal ["hgun_P07_F", 1];
	//btk_crate_1 addWeaponCargoGlobal ["rhs_weap_m4", 1];
	btk_crate_1 addWeaponCargoGlobal ["launch_B_Titan_short_F", 1];

	for "_j" from 1 to 3 do {
		_posFlat = [(getMarkerPos "respawn_west"), 70, 10, 4, 4, 0.3, 0, false, true] call BTK_fnc_getPosFlatEmpty;
		_group = [_posFlat, west, "nato", 10, 0, 5] call BTK_fnc_spawnGroup;
		_patrolling = [_group, _posFlat, 70] call BTK_fnc_taskPatrol;
		[_group, true, true] call BTK_fnc_trackingMarker;
	};

};




//[] spawn BTK_fnc_weather;



// Loadout
/*{
	
	private ["_unit","_items"];
	
	_unit = _x;

	if (local _unit) then {

		if (!(isPlayer _unit)) then { doStop _unit; };

		_unit unlinkItem "rhsusf_ANPVS_14";
		_items = uniformItems _x;
		_unit forceAddUniform "rhs_uniform_cu_ocp_patchless";
		{ _unit addItemToUniform _x; } forEach _items;
	};

	[_unit] spawn BTK_fnc_gearRespawn;
	[_unit, "TFAegis"] call BTK_fnc_insignia;

} forEach (switchableUnits + playableUnits);*/


[] spawn {
	
	sleep 3;
	execVM "arsenal_vanilla.sqf";
	
};


if (isDedicated) exitWith {};


//[] spawn BTK_fnc_sandstorm;
[] spawn BTK_fnc_gearRespawn;




//btk_crate_arsenal addAction [format[("<t color='#fff000'>" + ("Arsenal") + "</t>")], "arsenal.sqf", [], 6, false, false, "", "(alive player)"];


/*[] spawn {

	while {true} do {
		hintSilent format["%1", rating player];
		sleep 0.2;
	};

};*/



/*

[] spawn {

	while {true} do {
		hintSilent format["%1", btk_keys_current];
		sleep 0.001;
	};

};

[] spawn {

	// Loop
	while {true} do {

		// Alive and keys match
		waitUntil {(alive player) && (btk_test_keys call BTK_fnc_keyCheck)};

		systemChat "keys match!";

		// Keys free or dead
		waitUntil {(alive player) && !(btk_test_keys call BTK_fnc_keyCheck)};

		systemChat "keys dont match!";

	};

};*/


/*
_loaded = ["BTK Quick Vault", "btk_aa", "btk_debug_aa"] call BTK_fnc_userconfig;
[format['"BTK" Userconfig loaded? %1', _loaded]] call BTK_fnc_log;
*/


/*
_names = btk_test_keys call BTK_fnc_keyNames;
["BTK Functions", "1.0.0", "https://github.com/sxp2high/BTK-Functions", ("Open dialog  " + _names)] call BTK_fnc_addonNote;
["BTK Functions", "1.0.0", "https://github.com/sxp2high/BTK-Functions", format["Open dialog  <font color='%1'>ss</font>", ([true] call BTK_fnc_usercolor)]] call BTK_fnc_addonNote;
*/


//["Hello RPT World!","Line 2 ???!"] call BTK_fnc_log;


//["KeyDown", "if ((_this select 1) != 1) then { systemchat format['Key pressed! %1', time]; };", "btk_key_handler_down"] spawn BTK_fnc_keyHandlerAdd;
//["KeyDown", btk_key_handler_down] spawn BTK_fnc_keyHandlerRemove;


//[true, "blablamarkerbla", (getPosATL player), "ICON", ["mil_triangle", "ColorRed", 1, [1,1], 90, "bla"]] call BTK_fnc_createMarker; // Create icon marker local


//[(switchableUnits + playableUnits), "uniqueid", "do something", "bla bla bla ...", "do", (getPosATL player), true, true] call BTK_fnc_createTask;


//[group player] call BTK_fnc_trackingMarker;


/*_array = [1,2,3,1,2,3];
[format['ARRAY BEFORE: %1', _array]] call BTK_fnc_log;
_array = [_array, 2] call BTK_fnc_deleteInArray;
[format['ARRAY AFTER: %1', _array]] call BTK_fnc_log;*/


//["HELLO", "World!", true, true] call BTK_fnc_error;


//[(getPosATL player), 3, 3, (getDir player), false, "ANY", "PRESENT", true, "({(_x in thisList)} count (switchableUnits + playableUnits) > 1)", "hint 'player is inside the trigger!';", "hint 'player left the trigger!';"] call BTK_fnc_createTrigger;


//[5, 2] spawn BTK_fnc_fadeIn;


//[player] call BTK_fnc_renegadeDisable;


/*_buildings = [player, 100] call BTK_fnc_nearBuildings;
_buildingPositions = [(_buildings select 0)] call BTK_fnc_getBuildingPositions;
["BTK_fnc_getBuildingPositions", format["building positions: %1", _buildingPositions], true, true] call BTK_fnc_error;*/


//_string = [10] call BTK_fnc_randomString;
//[format["string: %1", _string]] call BTK_fnc_error;


//_number = [(rank player)] call BTK_fnc_rankToNumber;
//[format["rank: %1", _number]] call BTK_fnc_error;


//[(getPosATL player), 50] call BTK_fnc_getComposition;


//[(getPosATL player), (getDir player), [["Land_BagFenceLong",[-0.0991211,1.8042,-0.028245],359.928,1,0,false],["Land_BagFenceLong",[2.87744,1.83008,-0.0295877],359.923,1,0,false],["Land_BagFenceLong",[-3.06006,1.76318,-0.0251417],359.937,1,0,false],["Land_Photos_V1_F",[-0.0473633,3.56641,0.81],359.946,1,0,false],["FoldTable",[-0.141113,3.62207,0.00106096],359.946,1,0,false],["FoldChair",[-0.115234,4.53955,0.00149822],359.936,1,0,false]]] call BTK_fnc_spawnComposition;


/*for "_j" from 1 to 50 do {
	_posFlat = [(getPosATL player), 5000, 50, 5, 5, 0.2, 0, false, true] call BTK_fnc_getPosFlatEmpty;
	[true, ([10] call BTK_fnc_randomString), _posFlat, "RECTANGLE", ["Solid", "ColorRed", 1, [5, 5], 90]] call BTK_fnc_createMarker;
};
*/


//[player] call BTK_fnc_renegadeDisable;


/*for "_j" from 1 to 3 do {
	_posFlat = [(getPosATL player), 1000, 50, 5, 5, 0.3, 0, false, true] call BTK_fnc_getPosFlatEmpty;
	_group = [_posFlat, west, "nato", 10, 1, 5] call BTK_fnc_spawnGroup;
	_patrolling = [_group, _posFlat, 500] call BTK_fnc_taskPatrol;
	[_group, true, true] call BTK_fnc_trackingMarker;
};*/


/*for "_j" from 1 to 3 do {
	_posFlat = [(getPosATL player), 70, 10, 4, 4, 0.3, 0, false, true] call BTK_fnc_getPosFlatEmpty;
	_group = [_posFlat, west, "rhs_us_army_woodland", 10, 0, 5] call BTK_fnc_spawnGroup;
	_patrolling = [_group, _posFlat, 70, true] call BTK_fnc_taskPatrolSimple;
	[_group, true, true] call BTK_fnc_trackingMarker;
};*/


/*for "_j" from 1 to 2 do {
	_posFlat = [(getPosATL player), 1000, 50, 5, 5, 0.3, 0, false, true] call BTK_fnc_getPosFlatEmpty;
	_group = [_posFlat, west, "nato", 10, 1, 5] call BTK_fnc_spawnGroup;
	_defending = [_group, _posFlat, 500] call BTK_fnc_taskDefend;
	[_group, true, true] call BTK_fnc_trackingMarker;
};*/


/*
_count = [[1,2,3,1,2,3], 3] call BTK_fnc_countInArray; // Will return 2
["BTK_fnc_arrayCount", format["Count: %1", _count]] call BTK_fnc_error;
*/