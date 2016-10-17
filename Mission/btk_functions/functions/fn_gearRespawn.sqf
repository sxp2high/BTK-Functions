/*
	File: fn_gearRespawn.sqf
	Author: sxp2high (BTK) (btk@arma3.cc)

	Description:
	Initialize respawn with same gear for the current mission.

	Parameter(s):
		-

	Returns:
	NIL

	Syntax:
	_init = [] spawn BTK_fnc_gearRespawn;
*/


// No dedicated
if (isDedicated) exitWith {};


// Add eventhandler
player addMPEventHandler ["MPRespawn", { [] spawn { sleep 0.5; [] call BTK_fnc_gearLoad; sleep 2; btk_gear_respawning = nil; }; }];
player addEventHandler ["killed", { btk_gear_respawning = true; }];


// Save loop
while {true} do {

	waitUntil {sleep 2.345; (alive player) && (isNil "btk_gear_respawn_paused") && (isNil "btk_gear_respawning")};
	[] call BTK_fnc_gearSave;

};