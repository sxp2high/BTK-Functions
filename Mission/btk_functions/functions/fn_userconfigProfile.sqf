/*
	File: fn_userconfigProfile.sqf
	Author: sxp2high (BTK) (btk@arma3.cc)

	Description:
	Load userconfig with 2 failsafes.

	Parameter(s):
		0: STRING - addon title
		1: STRING - addon tag
		2: STRING - variable name to confirm

	Returns:
	BOOLEAN - true when done

	Syntax:
	_loaded = [["function_version", "1.0.0"], ["function_keys", [13,24]]] call BTK_fnc_userconfig;
*/


private ["_title","_name","_var","_return"];


// Parameter
_entries = _this;


// Check all entries
{

	// Entry data
	_title = _x select 0;
	_default = _x select 1;
	_reset = if ((count _this) > 2) then { _x select 2; } else { false; };

	// Not found in profile
	if (isNil {profileNamespace getVariable _title}) then {

		// Create profile entry and variable
		profileNamespace setVariable [_title, _default];
		missionNamespace setVariable [_title, _default];

		// Log
		[format["%1 v%2 successfully installed!", _addonTitle, _addonVersion]] call BTK_fnc_log;

	// Found in profile, load
	} else {

		_value = profileNamespace getVariable _title;

		// Reset?
		if ((_value != _default) && _reset) then {

			// Update and create variable
			profileNamespace setVariable [_title, _default];
			missionNamespace setVariable [_title, _default];

			// Log
			[format["%1 v%2 successfully updated to %3!", _addonTitle, _addonVersion, _default]] call BTK_fnc_log;

		} else {

			// Just create variable
			missionNamespace setVariable [_title, _value];

		};

	};

} forEach _entries;


true