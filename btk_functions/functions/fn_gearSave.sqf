/*
	File: fn_gearLoad.sqf
	Author: sxp2high (BTK) (btk@arma3.cc)

	Description:
	Save current palyer gear to be loaded by BTK_fnc_gearLoad. (Ie after respawn)

	Parameter(s):
		-

	Returns:
	BOOLEAN - true when done

	Syntax:
	_loaded = [] call BTK_fnc_gearSave;
*/


private ["_handgunWeapon","_handgunItems","_secondaryWeapon","_secondaryWeaponItems","_primaryWeapon","_primaryWeaponItems","_assignedItems","_backpack","_backpackItems","_uniform","_uniformItems","_vest","_vestItems","_magazines","_headgear","_goggles","_currentMuzzle"];


// Just in case
if (isDedicated) exitWith {};


// Dont save when player is dead (weapon is dropped etc.)
if (!(alive player)) exitWith {};


// Get data
_handgunWeapon = handgunWeapon player;
_handgunItems = if (isNil {(handgunItems player)}) then { []; } else { (handgunItems player); };
_secondaryWeapon = secondaryWeapon player;
_secondaryWeaponItems = if (isNil {(secondaryWeaponItems player)}) then { []; } else { (secondaryWeaponItems player); };
_primaryWeapon = primaryWeapon player;
_primaryWeaponItems = if (isNil {(primaryWeaponItems player)}) then { []; } else { (primaryWeaponItems player); };
_assignedItems = [];
{ if (["tf_", _x] call BIS_fnc_inString) then { _assignedItems pushBack "ItemRadio"; } else { _assignedItems pushBack _x; }; } forEach (assignedItems player);
_backpack = backpack player;
_backpackItems = [];
{
	if (!(isClass (configFile >> "CfgMagazines" >> _x))) then { _backpackItems pushBack _x; };
} forEach (backpackItems player);
_uniform = uniform player;
_uniformItems = [];
{
	if (!(isClass (configFile >> "CfgMagazines" >> _x))) then { _uniformItems pushBack _x; };
} forEach (uniformItems player);
_vest = vest player;
_vestItems = [];
{
	if (!(isClass (configFile >> "CfgMagazines" >> _x))) then { _vestItems pushBack _x; };
} forEach (vestItems player);
_magazines = magazinesAmmoFull player;
_headgear = headgear player;
_goggles = goggles player;
_currentMuzzle = if ((vehicle player) == player) then { (currentMuzzle player); } else { ""; };


// Compile
btk_gear_saved = [_handgunWeapon,_handgunItems,_secondaryWeapon,_secondaryWeaponItems,_primaryWeapon,_primaryWeaponItems,_assignedItems,_backpack,_backpackItems,_uniform,_uniformItems,_vest,_vestItems,_magazines,_headgear,_goggles,_currentMuzzle];


true