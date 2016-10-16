class btk_functions {

	tag = "BTK";

	class Init {

		class initPre { file = "btk_functions\initPre.sqf"; preInit = 1; }; // BTK_fnc_initPre
		class init { file = "btk_functions\init.sqf"; postInit = 1; }; // BTK_fnc_init
		class initMP { file = "btk_functions\initMP.sqf"; postInit = 1; }; // BTK_fnc_initMP

	};

	class Functions {

		file = "btk_functions\functions";

		class addonNote { description = "BTK Addon readme notes."; }; // BTK_fnc_addonNote
		class arrayToString { description = "Convert array to string list."; }; // BTK_fnc_arrayToString
		class arsenal { description = ""; }; // BTK_fnc_arsenal
		class arsenalInit { description = ""; }; // BTK_fnc_arsenalInit
		class countInArray { description = "Count how often entry is in array."; }; // BTK_fnc_countInArray
		class countItems { description = "Returns how many of item X the unit has."; }; // BTK_fnc_countItems
		class createMarker { description = "Creates a map marker."; }; // BTK_fnc_createMarker
		class createNote { description = "Creates a diary note."; }; // BTK_fnc_createNote
		class createTask { description = "Creates a task. More reliable and flexible than BIS_fnc_taskCreate."; }; // BTK_fnc_createTask
		class createTrigger { description = "Creates a trigger."; }; // BTK_fnc_createTrigger
		class deleteInArray { description = "Delete entry from array. (Including all duplicates)"; }; // BTK_fnc_deleteInArray
		class error { description = "Show errors message and/or logs it."; }; // BTK_fnc_error
		class fadeIn { description = "Fade in from black screen."; }; // BTK_fnc_fadeIn
		class gearLoad { description = "Load gear for player saved by BTK_fnc_gearSave. (Ie after respawn)"; }; // BTK_fnc_gearLoad
		class gearRespawn { description = "Initialize respawn with same gear for the current mission."; }; // BTK_fnc_gearRespawn
		class gearSave { description = "Save current palyer gear to be loaded by BTK_fnc_gearLoad. (Ie after respawn)"; }; // BTK_fnc_gearSave
		class getBuildingPositions { description = "Returns all building positions of the given building."; }; // BTK_fnc_getBuildingPositions
		class getComposition { description = "Log composition to be used with BTK_fnc_spawnComposition."; }; // BTK_fnc_getComposition
		class getPos { description = "Converts anything into a position."; }; // BTK_fnc_getPos
		class getPosFlatEmpty { description = "Returns a (random) flat and/or emtpy position within the given radius."; }; // BTK_fnc_getPosFlatEmpty
		class getPosRandom { description = "Returns a random position within the given radius."; }; // BTK_fnc_getPosRandom
		class heliHover { description = "Makes a helicopter hover perfectly still."; }; // BTK_fnc_heliHover
		class insignia { description = "Set unit insignia. Stays after respawn and uniform change."; }; // BTK_fnc_insignia
		class isJIP { description = "Returns true when player joined in progress."; }; // BTK_fnc_isJIP
		class keyCheck { description = "Checks for key press."; }; // BTK_fnc_keyCheck
		class keyHandler { description = "Handle key press."; }; // BTK_fnc_keyHandler
		class keyHandlerAdd { description = "Register new display eventhandler."; }; // BTK_fnc_keyHandlerAdd
		class keyHandlerRemove { description = "Remove display eventhandler.."; }; // BTK_fnc_keyHandlerRemove
		class keyNames { description = "Convert key ids into human-readable text."; }; // BTK_fnc_keyNames
		class lobbyParams { description = "Convert lobby parameter into missionNamespace variables."; }; // BTK_fnc_lobbyParams
		class log { description = "Write log to RPT."; }; // BTK_fnc_log
		class mp { description = "Execute functions or commands remotely, simpler and more reliable than BIS_fnc_MP."; }; // BTK_fnc_mp
		class mpExec { description = "Called by BTK_fnc_mp."; }; // BTK_fnc_mpExec
		class nearBuildings { description = "Returns all buildings with building positions within the given radius."; }; // BTK_fnc_nearBuildings
		class playerList { description = "Returns a list with all players. (Not AI occupying player slots)"; }; // BTK_fnc_playerList
		class randomString { description = "Returns a random string with the given length."; }; // BTK_fnc_randomString
		class rankToNumber { description = "Convert a rank into a number for comparsion OR convert a number into a rank."; }; // BTK_fnc_rankToNumber
		class renegadeDisable { description = "Disable renegade status for units. (Negative score)"; }; // BTK_fnc_renegadeDisable
		class sandstorm { description = ""; }; // BTK_fnc_sandstorm
		class setTaskState { description = "Change task state. More reliable and flexible than BIS_fnc_setTaskState."; }; // BTK_fnc_setTaskState
		class spawnComposition { description = "Spawn composition saved by BTK_fnc_getComposition."; }; // BTK_fnc_spawnComposition
		class spawnGroup { description = "Creates a random group with the given amount of units."; }; // BTK_fnc_spawnGroup
		class spawnVehicle { description = "Creates a vehicle with crew and a random amount of units in cargo."; }; // BTK_fnc_spawnVehicle
		class taskAttack { description = "The group will attack the given position."; }; // BTK_fnc_taskAttack
		class taskDefend { description = "The group will defend/hold the given location."; }; // BTK_fnc_taskDefend
		class taskHunt { description = "The group will hunt the given object/vehicle/unit/group."; }; // BTK_fnc_taskHunt
		class taskPatrol { description = "The group will patrol the given sector. They will also move into buildings on occasion."; }; // BTK_fnc_taskPatrol
		class taskPatrolSimple { description = ""; }; // BTK_fnc_taskPatrolSimple
		class terrainGrid { description = "Convert terraingrid to a comparable number."; }; // BTK_fnc_terrainGrid
		class trackingMarker { description = "Return user GUI color in HTML or RGB."; }; // BTK_fnc_trackingMarker
		class usercolor { description = "Return user GUI color in HTML or RGB."; }; // BTK_fnc_usercolor
		class userconfig { description = "Load userconfig with 2 failsafes."; }; // BTK_fnc_userconfig
		class vehicleRespawn { description = "Vehicle respawn."; }; // BTK_fnc_vehicleRespawn
		class weather { description = ""; }; // BTK_fnc_weather

	};

};