/*
	File: fn_gearLoad.sqf
	Author: sxp2high (BTK) (btk@arma3.cc)

	Description:
	Load gear for player saved by BTK_fnc_gearSave. (Ie after respawn)

	Parameter(s):
		-

	Returns:
	BOOLEAN - true when done

	Syntax:
	_loaded = [] call BTK_fnc_gearLoad;
*/


private ["_loadout","_handgunWeapon","_handgunItems","_secondaryWeapon","_secondaryWeaponItems","_primaryWeapon","_primaryWeaponItems","_assignedItems","_backpack","_backpackItems","_uniform","_uniformItems","_vest","_vestItems","_magazines","_headgear","_goggles","_currentMuzzle","_magazinesCurrent","_magazinesRest","_designatorLoaded"];


// Flag
btk_gear_respawning = true;


// Just in case
if (isDedicated) exitWith {};


// Nothing found
if (isNil "btk_gear_saved") exitWith {};


// Get loadout
_loadout = btk_gear_saved;
_handgunWeapon = (_loadout select 0);
_handgunItems = (_loadout select 1);
_secondaryWeapon = (_loadout select 2);
_secondaryWeaponItems = (_loadout select 3);
_primaryWeapon = (_loadout select 4);
_primaryWeaponItems = (_loadout select 5);
_assignedItems = (_loadout select 6);
_backpack = (_loadout select 7);
_backpackItems = (_loadout select 8);
_uniform = (_loadout select 9);
_uniformItems = (_loadout select 10);
_vest = (_loadout select 11);
_vestItems = (_loadout select 12);
_magazines = (_loadout select 13);
_grenades = (_loadout select 14);
_headgear = (_loadout select 15);
_goggles = (_loadout select 16);
_currentMuzzle = (_loadout select 17);
_designatorLoaded = (_loadout select 18);


// Clear
removeAllAssignedItems player;
removeBackpack player;
removeUniform player;
removeVest player;
removeHeadgear player;
removeGoggles player;
player removeWeapon (primaryWeapon player);
player removeWeapon (handgunWeapon player);
player removeWeapon (secondaryWeapon player);
removeAllPrimaryWeaponItems player;
removeAllHandgunItems player;


// Add temp backback so we have some space to work with
player addBackpack "B_Carryall_oucamo"; //B_Carryall_oucamo
waitUntil {((backpack player) != "")};
clearAllItemsFromBackpack player;


// Filter current magazines
_magazinesRest = [];
_magazinesCurrent = [];
{
	if ((_x select 2) && ((_x select 4) in [_handgunWeapon,_secondaryWeapon,_primaryWeapon])) then {
		_magazinesCurrent pushBack [(_x select 0), (_x select 1)];
	} else {
		_magazinesRest pushBack [(_x select 0), (_x select 1)];
	};
} forEach _magazines;


// Add current mags
{ player addMagazine [(_x select 0), (_x select 1)]; waitUntil {((_x select 0) in (backpackItems player))}; } forEach _magazinesCurrent;


// Add weapons
if (_handgunWeapon != "") then { player addWeapon _handgunWeapon; waitUntil {(player hasWeapon _handgunWeapon)}; };
if (_secondaryWeapon != "") then { player addWeapon _secondaryWeapon; waitUntil {(player hasWeapon _secondaryWeapon)}; };
if (_primaryWeapon != "") then { player addWeapon _primaryWeapon; waitUntil {(player hasWeapon _primaryWeapon)}; };


// Add attachments
if ((count _handgunItems) > 0) then { { if (_x != "") then { player addHandgunItem _x; } } forEach _handgunItems; };
if ((count _secondaryWeaponItems) > 0) then { { if (_x != "") then { player addSecondaryWeaponItem _x; } } forEach _secondaryWeaponItems; };
if ((count _primaryWeaponItems) > 0) then { { if (_x != "") then { player addPrimaryWeaponItem _x; } } forEach _primaryWeaponItems; };


// Designator battery
if ((_designatorLoaded > 0) && ("Laserdesignator" in _assignedItems)) then { player addMagazine "Laserbatteries"; };


// Add assigned items + Workaround for binoculars & rangefinder
if ((count _assignedItems) > 0) then {
	{
		if ((_x == "Binocular") || (_x == "Rangefinder") || (_x == "Laserdesignator")) then { player addWeapon _x; } else { player addItem _x; };
		waitUntil {(_x in (items player)) || (_x in (weapons player))};
		player assignItem _x;
	} forEach _assignedItems;
};


// Remove temp backpack
removeBackpack player;
waitUntil {((backpack player) == "")};


// Add uniform
if (_uniform != "") then {

	player addUniform _uniform;
	waitUntil {(uniform player) != ""};

	if ((count _uniformItems) > 0) then {
		{ player addItemToUniform _x; } forEach _uniformItems;
		waitUntil {((count _uniformItems) == (count (uniformItems player)))};
	};

};


// Add vest
if (_vest != "") then {

	player addVest _vest;
	waitUntil {(vest player) != ""};

	if ((count _vestItems) > 0) then {
		{ player addItemToVest _x; } forEach _vestItems;
		waitUntil {((count _vestItems) == (count (vestItems player)))};
	};

};


// Add backpack
if (_backpack != "") then {

	player addBackpack _backpack;
	waitUntil {((backpack player) != "")};

	_backpack = unitBackpack player;

	clearWeaponCargo _backpack;
	clearMagazineCargo _backpack;
	clearItemCargo _backpack;
	clearBackpackCargo _backpack;

	{ player addItemToBackpack _x; } forEach _backpackItems;

};


// Add headgear
if (_headgear != "") then { player addHeadgear _headgear; };


// Add goggles
if (_goggles != "") then { player addGoggles _goggles; };


// Add remaining magazines
{ player addMagazine [(_x select 0), (_x select 1)]; } forEach _magazinesRest;


// Add grenades
{ player addMagazine _x; } forEach _grenades;


// Select primary
if (_currentMuzzle != "") then { player selectWeapon _currentMuzzle; };


btk_gear_respawning = nil;


true