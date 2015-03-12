// Wait for player
waitUntil {(isDedicated) || !(isNull player)};


// Server init
if (isServer) then {

	// Logic for storage
	if (isNil "btk_mp_logic") then {
		_group = createGroup sideLogic;
		btk_mp_logic = _group createUnit ["Logic", [0, 0, 0], [], 0, "NONE"]; publicVariable "btk_mp_logic";
		btk_mp_logic setVariable ["btk_mp_persistent", [], true];
		btk_mp_logic setVariable ["btk_mp_persistart", [], true];
	};

	// Reset on mission start
	[] spawn {
		sleep 0.1;
		btk_mp_logic setVariable ["btk_mp_persistart", [], true];
	};

};


// Already initialized?
if (!(isNil "btk_mp_init")) exitWith {};


// Init flag
btk_mp_init = true;


// Add for both player & server
"btk_mp_handler" addPublicVariableEventHandler {
	(_this select 1) call BTK_fnc_mpExec;
};


// Exit dedicated
if (isDedicated) exitWith {};


// Player init
[] spawn {

	// Wait for server
	waitUntil {!(isNil "btk_mp_logic")};
	waitUntil {!(isNil {btk_mp_logic getVariable "btk_mp_persistent"}) && !(isNil {btk_mp_logic getVariable "btk_mp_persistart"})};

	// Get queue
	_queue = (btk_mp_logic getVariable "btk_mp_persistent") + (btk_mp_logic getVariable "btk_mp_persistart");

	// Something stored?
	if ((count _queue) > 0) then {

		// Execute everything
		{ _x call BTK_fnc_mpExec; } forEach _queue;

	};

};