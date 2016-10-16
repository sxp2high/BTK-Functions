/*
	File: fn_userconfig.sqf
	Author: sxp2high (BTK) (btk@arma3.cc)

	Description:
	Load userconfig with 2 failsafes.

	Parameter(s):
		0: STRING - addon title
		1: STRING - addon tag
		2: STRING - variable name to confirm

	Returns:
	BOOLEAN - true when loaded, false when failed

	Syntax:
	_loaded = ["BTK Addon", "btk_addon", "btk_addon_config_init"] call BTK_fnc_userconfig;
*/


private ["_title","_name","_var","_return"];


// Parameter
_title = _this select 0;
_name = _this select 1;
_var = _this select 2;


// Try root frist
[] call (compile (preprocessFileLineNumbers format["\userconfig\btk\%1.hpp", _name]));


// Root not found
if (isNil _var) then {

	// Addon?
	if (isClass (configFile >> "CfgPatches" >> format["%1", _name])) then {

		// Try addon default
		[] call (compile (preprocessFileLineNumbers format["\%1\%1.hpp", _name]));

	} else {

		// Try mission default
		[] call (compile (preprocessFileLineNumbers format["%1\%1.hpp", _name]));

	};

	// Warning
	[_title,_var] spawn {

		sleep 2;

		// Default loaded?
		_text = if (isNil (_this select 1)) then {
			format["<t align='left'><t color='#ff0000'>WARNING</t><br />%1 userconfig is missing! Addon exiting...</t>", (_this select 0)];
		} else {
			format["<t align='left'><t color='#ff0000'>WARNING</t><br />%1 userconfig is missing! Using default settings...</t>", (_this select 0)];
		};

		hint parseText _text

	};

};


// Return result
_return = if (isNil _var) then { false; } else { true; };


_return