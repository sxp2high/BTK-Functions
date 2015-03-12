private ["_addonTitle","_addonVersion","_addonVersion"];


// Variables
_addonTitle = "BTK Functions";
_addonVersion = "1.0.0";
_addonLink = "https://github.com/sxp2high/BTK-BTK-Functions";


// Wait for player
waitUntil {(isDedicated) || !(isNull player)};


// Server init
if (isServer) then {

	// Create centers, just to make sure
	createCenter west;
	createCenter east;
	createCenter resistance;
	createCenter civilian;
	createCenter sideLogic;

	// JIP flag
	[] spawn {
		sleep 10;
		btk_jip = true; publicVariable "btk_jip";
	};

};


// Already initialized?
if (!(isNil "btk_functions_init")) exitWith {};


// Init flag
btk_functions_init = true;


// Exit dedicated
if (isDedicated) exitWith {};


// Variables
btk_keys_current = [];


// Add global key handler
["KeyDown", "[(_this select 1), 0] call BTK_fnc_keyHandler;", "btk_key_handler_down"] spawn BTK_fnc_keyHandlerAdd;
["KeyUp", "[(_this select 1), 1] call BTK_fnc_keyHandler;", "btk_key_handler_up"] spawn BTK_fnc_keyHandlerAdd;


// Note
[_addonTitle, _addonVersion, _addonLink] call BTK_fnc_addonNote;


// Log
[format["%1 initialized!", _addonTitle]] call BTK_fnc_log;