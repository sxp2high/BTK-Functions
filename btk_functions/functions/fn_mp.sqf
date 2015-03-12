/*
	File: fn_mp.sqf
	Author: sxp2high (BTK) (btk@arma3.cc)

	Description:
	Execute functions or commands remotely, simpler and more reliable than BIS_fnc_MP.

	Parameter(s):
		0: ANY - parameter
		1: STRING - Function/Command
		2 (Optional): ANY - (STRING, OBJECT, GROUP or SIDE) locality target (where to execute) (default: will be executed everywhere)
		3 (Optional): BOOLEAN - persistent (is executed for jip) (default: false)
		4 (Optional): BOOLEAN - call/spawn (true for call, false for spawn) (default: false)

	Returns:
	BOOLEAN - true when done

	Syntax:
	[[player, "Hello world!"], "sideChat", "", false, true] spawn BTK_fnc_mp; // show sideChat everywhere, but not for JIP
	[[parameter], "BIS_fnc_whatever", "server", false, false] call BTK_fnc_mp; // spawn BIS_fnc_whatever on server only
	[[parameter], "BIS_fnc_whatever", "player", true, true] call BTK_fnc_mp; // call BIS_fnc_whatever on clients only, incl. JIP
	[{ sleep 5; player sideChat 'Ok.'; }, "BIS_fnc_spawn", "", false, true] spawn BTK_fnc_mp; // Code
*/

private ["_parameter","_functionName","_target","_isPersistent","_isCall"];


// Parameter
_parameter = _this select 0;
_functionName = _this select 1;
_target = if ((count _this) > 2) then { _this select 2; } else { ""; };
_isPersistent = if ((count _this) > 3) then { _this select 3; } else { false; };
_isCall = if ((count _this) > 4) then { _this select 4; } else { false; };


// Send and execute locally
btk_mp_handler = [_parameter, _functionName, _target, _isPersistent, _isCall]; publicVariable "btk_mp_handler";
btk_mp_handler call BTK_fnc_mpExec;


true