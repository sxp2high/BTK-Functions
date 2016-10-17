/*
	File: fn_keyNames.sqf
	Author: sxp2high (BTK) (btk@arma3.cc)

	Description:
	Convert key ids into human-readable text.

	Parameter(s):
		0: ARRAY - key(s)

	Returns:
	BOOLEAN - true when pressed, false when not

	Syntax:
	[17] call BTK_fnc_keyNames; // Returns 'W'
	[57,17] call BTK_fnc_keyNames; // Returns 'SPACE + W'
*/


private ["_keys","_keyNames","_keyIndex"];


// Parmeter
_keys = _this;


// Variables
_keyNames = "";
_keyIndex = 0;


// Create string
{
	private ["_keyName"];

	_keyName = (keyName (_keys select _keyIndex));

	if (_keyIndex == ((count _keys) - 1)) then {
		_keyNames = (_keyNames + _keyName);
	} else {
		_keyNames = (_keyNames + _keyName + " + ");
	};

	_keyIndex = _keyIndex + 1;

} forEach _keys;


_keyNames