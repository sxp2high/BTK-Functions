/*
	File: fn_mpExec.sqf
	Author: sxp2high (BTK) (btk@arma3.cc)

	Description:
	Called by BTK_fnc_mp.

	Parameter(s):
		0: ANY - parameter
		1: STRING - Function/Command
		2 (Optional): ANY - (STRING, OBJECT, GROUP or SIDE) locality target (where to execute) (default: will be executed everywhere)
		3 (Optional): BOOLEAN - persistent (is executed for jip) (default: false)
		4 (Optional): BOOLEAN - call/spawn (true for call, false for spawn) (default: false)

	Returns:
	BOOLEAN - true when done

	Syntax:
	See BTK_fnc_mp
*/


private ["_parameter","_functionName","_target","_isPersistent","_isCall","_execute","_commands","_whitelist","_stored","_storedStart","_function"];


// Parameter
_parameter = _this select 0;
_functionName = _this select 1;
_target = _this select 2;
_isPersistent = _this select 3;
_isCall = _this select 4;
_execute = false;


// Arrays
_commands = ["action","allowdamage","assignascargo","commandchat","enablesimulation","globalchat","groupchat","hint","moveincargo","ordergetin","playmove","playmovenow","playmusic","playsound","playactionnow","say","setcaptive","setdir","setface","setfuel","setgroupid","setpos","setposasl","setposatl","setrank","setvehiclevarname","sidechat","switchmove","systemchat","unassignvehicle","vehiclechat"];
_whitelist = ["bis_fnc_spawn","btk_fnc_log","btk_fnc_settaskstate","btk_groupmanager_fnc_setgroupleader"];


// Not whitelisted or command?
if (!((toLower _functionName) in _whitelist) && !((toLower _functionName) in _commands)) exitWith {
	["BTK_fnc_mpExec", format["Function %1 is not whitelisted!", _functionName]] call BIS_fnc_error;
};


// Is direct function?
if ((toLower _functionName) in _commands) then {

	// Commands
	switch (toLower _functionName) do {

		case ("action") : { if (local (_parameter select 0)) then { (_parameter select 0) action (_parameter select 1); }; };
		case ("allowdamage") : { (_parameter select 0) allowDamage (_parameter select 1); };
		case ("assignascargo") : { (_parameter select 0) assignAsCargo (_parameter select 1); };
		case ("commandchat") : { (_parameter select 0) commandChat (_parameter select 1); };
		case ("enablesimulation") : { (_parameter select 0) enableSimulation (_parameter select 1); };
		case ("globalchat") : { (_parameter select 0) globalChat (_parameter select 1); };
		case ("groupchat") : { (_parameter select 0) groupChat (_parameter select 1); };
		case ("hint") : { hint (_parameter select 0); };
		case ("moveincargo") : { if (local (_parameter select 0)) then { (_parameter select 0) moveInCargo (_parameter select 1); }; };
		case ("ordergetin") : { if (local (_parameter select 0)) then { (_parameter select 0) orderGetIn (_parameter select 1); }; };
		case ("playmove") : { (_parameter select 0) playMove (_parameter select 1); };
		case ("playmovenow") : { (_parameter select 0) playMoveNow (_parameter select 1); };
		case ("playmusic") : { playMusic (_parameter select 0); };
		case ("playsound") : { playSound (_parameter select 0); };
		case ("playactionnow") : { if (local (_parameter select 0)) then { (_parameter select 0) playActionNow (_parameter select 1); }; };
		case ("say") : { (_parameter select 0) say (_parameter select 1); };
		case ("setcaptive") : { (_parameter select 0) setCaptive (_parameter select 1); };
		case ("setdir") : { (_parameter select 0) setDir (_parameter select 1); };
		case ("setface") : { (_parameter select 0) setFace (_parameter select 1); };
		case ("setfuel") : { (_parameter select 0) setFuel (_parameter select 1); };
		case ("setgroupid") : { (_parameter select 0) setGroupId [(_parameter select 1)]; };
		case ("setpos") : { if (local (_parameter select 0)) then { (_parameter select 0) setPos (_parameter select 1); }; };
		case ("setposasl") : { if (local (_parameter select 0)) then { (_parameter select 0) setPosASL (_parameter select 1); }; };
		case ("setposatl") : { if (local (_parameter select 0)) then { (_parameter select 0) setPosATL (_parameter select 1); }; };
		case ("setrank") : { (_parameter select 0) setRank (_parameter select 1); };
		case ("setvehiclevarname") : { (_parameter select 0) setVehicleVarName (_parameter select 1); };
		case ("sidechat") : { (_parameter select 0) sideChat (_parameter select 1); };
		case ("switchmove") : { (_parameter select 0) switchMove (_parameter select 1); };
		case ("systemchat") : { systemChat (_parameter select 0); };
		case ("unassignvehicle") : { if (local (_parameter select 0)) then { unassignVehicle (_parameter select 0); }; };
		case ("vehiclechat") : { (_parameter select 0) vehicleChat (_parameter select 1); };
		default {};

	};

};


// Store persistent
if (_isPersistent && isServer) then {

	// Get stored data
	_stored = btk_mp_logic getVariable "btk_mp_persistent";

	// Dont store the same twice
	if (!([_parameter, _functionName, _target, _isPersistent, _isCall] in _stored)) then {

		// Set
		_stored pushBack [_parameter, _functionName, _target, _isPersistent, _isCall];
		btk_mp_logic setVariable ["btk_mp_persistent", _stored, true];

	};

};


// Mission start must be stored too
if (!(_isPersistent) && isServer && (time == 0)) then {
	
	// Get stored data
	_storedStart = btk_mp_logic getVariable "btk_mp_persistart";
	_storedStart pushBack [_parameter, _functionName, _target, _isPersistent, _isCall];
	btk_mp_logic setVariable ["btk_mp_persistart", _storedStart, true];

};


// Exit here if it was direct command
if ((toLower _functionName) in _commands) exitWith { true };


// Check locality
switch (typeName _target) do {

	case ("STRING") : {

		switch (true) do {
			case (_target == "") : { _execute = true; };
			case ((_target == "server") && isServer) : { _execute = true; };
			case ((_target == "player") && !(isDedicated)) : { _execute = true; };
			default { _execute = false; };
		};

	};

	case ("OBJECT") : {

		switch (true) do {
			case (local _target) : { _execute = true; };
			default { _execute = false; };
		};

	};

	case ("GROUP") : {

		switch (true) do {
			case (player in (units _target)) : { _execute = true; };
			default { _execute = false; };
		};

	};

	case ("SIDE") : {

		switch (true) do {
			case ((side player) == _target) : { _execute = true; };
			default { _execute = false; };
		};
	
	};

	default { _execute = false; };

};


// Execute
if (_execute) then {

	// Get function name
	_function = missionNamespace getVariable _functionName;

	// Function exist?
	if (!(isNil "_function")) then {

		// Call or spawn?
		if (_isCall) then {
			_parameter call _function;
		} else {
			_parameter spawn _function;
		};

	};

};


true