/*
	File: fn_countItems.sqf
	Author: sxp2high (BTK) (btk@arma3.cc)

	Description:
	Returns how many of item X the unit has.

	Parameter(s):
		0: OBJECT - unit
		1: STRING - item class (can be anything, item, magazine, weapon, backback, etc.)

	Returns:
	NUMBER - how many

	Syntax:
	_number = [player, "ItemMap"] call BTK_fnc_countItems; // Returns: 1
*/


private ["_unit","_type","_allItems","_count"];


// Parameter
_unit = _this select 0;
_type = _this select 1;


// Variables
_allItems = ((itemsWithMagazines _unit) + (assignedItems _unit) + (weapons _unit) + [(backpack _unit), (uniform _unit), (vest _unit), (headgear _unit), (goggles _unit)] + (handgunItems _unit) + (secondaryWeaponItems _unit) + (primaryWeaponItems _unit) + (handgunMagazine player) + (secondaryWeaponMagazine player) + (primaryWeaponMagazine player));
_count = 0;


// Search
{

	if (_x == _type) then { _count = _count + 1; };

} forEach _allItems;


_count