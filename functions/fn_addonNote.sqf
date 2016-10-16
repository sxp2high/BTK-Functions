/*
	File: fn_addonNote.sqf
	Author: sxp2high (BTK) (btk@arma3.cc)

	Description:
	BTK Addon readme notes.

	Parameter(s):
		0: STRING - addon title
		1: STRING - addon version
		2: STRING - addon link/url
		3 (Optional): STRING - key bindings

	Returns:
	BOOLEAN - true when done

	Syntax:
	_names = btk_test_keys call BTK_fnc_keyNames;
	_added = ["BTK Addon", "1.0.0", "https://sxp2hi.gh/BTK-Addon", ("Do something  " + _names)] call BTK_fnc_addonNote;
	_added = ["BTK Addon XYZ", "1.0.0", "https://sxp2hi.gh/BTK-AddonXYZ"] call BTK_fnc_addonNote;
*/


private ["_title","_version","_link","_keys"];


// Parameter
_title = _this select 0;
_version = _this select 1;
_link = _this select 2;
_keys = if ((count _this) > 3) then { _this select 3; } else { "None"; };


// Create category
player createDiarySubject ["BTK", "BTK"];


// Add entry
player createDiaryRecord ["BTK", [format["%1", _title], format["<br /><font color='%2'>Addon:</font> %3<br /><font color='%2'>Version:</font> %4<br /><font color='%2'>Author:</font> sxp2high (BTK) (btk@arma3.cc)<br /><br /><font color='%2'>Readme, Changelog, License</font> <br />%5<br /><br /><font color='%2'>Key bindings</font><br />%6", ([true] call BTK_fnc_usercolor), "#c9cacc", _title, _version, _link, _keys]]];


true