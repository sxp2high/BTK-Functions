/*
	File: fn_insignia.sqf
	Author: sxp2high (BTK) (btk@arma3.cc)

	Description:
	Set unit insignia. For palyers it stays after respawn and uniform change.

	Parameter(s):
		0: OBJECT - unit
		1: STRING - insignia

	Returns:
	BOOLEAN - true when done

	Syntax:
	_set = [player, "111thID"] call BTK_fnc_insignia;
	{ _set = [_x, "111thID"] call BTK_fnc_insignia; } forEach (switchableUnits + playableUnits);
*/


private ["_unit","_insignia","_respawnEh","_index"];


// Parameter
_unit = _this select 0;
_insignia = _this select 1;


// Local only
if (!(local _unit)) exitWith {};


// Already set?
if (!(isNil {_unit getVariable "btk_insignia_unit"})) exitWith {};


// Get slot
_index = -1;
{
	if (_x == "insignia") exitwith { _index = _forEachIndex; };
} forEach getArray (configfile >> "CfgVehicles" >> gettext (configfile >> "CfgWeapons" >> (uniform _unit) >> "ItemInfo" >> "uniformClass") >> "hiddenSelections");


// No slot found?
if (_index < 0) exitWith {};


// Get texture path
_cfgTexture = [["CfgUnitInsignia", _insignia], configfile] call BIS_fnc_loadClass;
_texture = getText (_cfgTexture >> "texture");


// Set for AI
if (!(isPlayer _unit)) exitWith {

	_unit setVariable ["btk_insignia_unit", [_insignia, _index], true];

	[_unit,_index,_texture] spawn {
		sleep 0.1;
		(_this select 0) setObjectTextureGlobal [(_this select 1), (_this select 2)];
	};

};


// Just in case
if (isDedicated) exitWith {};


// Set var for player
player setVariable ["btk_insignia_unit", [_insignia, _texture], true];


// Uniform change ,respawn
[] spawn {

	_var = player getVariable "btk_insignia_unit";
	_insignia = (_var select 0);
	_texture = (_var select 1);

	while {true} do {

		// Alive and has uniform
		waitUntil {sleep 1.419; ((uniform player) != "") && (alive player)};

		// Set insignia
		_uniform = (uniform player);
		_index = -1;
		{
			if (_x == "insignia") exitwith { _index = _forEachIndex; };
		} forEach getArray (configfile >> "CfgVehicles" >> gettext (configfile >> "CfgWeapons" >> _uniform >> "ItemInfo" >> "uniformClass") >> "hiddenSelections");

		if (_index > 0) then {
			sleep 0.1;
			player setObjectTextureGlobal [_index, _texture];
		};

		// Uniform change or dead
		waitUntil {sleep 1.531; ((uniform player) != _uniform) || !(alive player)};

	};

};


true