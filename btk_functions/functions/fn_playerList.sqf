/*
	File: fn_playerList.sqf
	Author: sxp2high (BTK) (btk@arma3.cc)

	Description:
	Returns a list with all players. (Not AI occupying player slots)

	Parameter(s):
		0 (Optional): BOOLEAN - alive only (true for alive players only) (default: false)
		1 (Optional): BOOLEAN - shuffle (randomize) array (default: false)

	Returns:
	ARRAY - player objects

	Syntax:
	[] call BTK_fnc_playerList; // All, not shuffled
	[true] call BTK_fnc_playerList; // All alive, not shuffled
	[false,true] call BTK_fnc_playerList; // All, shuffled
*/


private ["_onlyAlive","_shuffle","_players"];


// Parameter
_onlyAlive = if (count _this > 0) then { _this select 0; } else { false; };
_shuffle = if (count _this > 1) then { _this select 1; } else { false; };


// Array
_players = [];


// Only alive?
if (_onlyAlive) then {

	{

		if ((isPlayer _x) && (alive _x)) then {
			_players pushBack _x;
		};

	} forEach (switchableUnits + playableUnits);

} else {

	{

		if (isPlayer _x) then {
			_players pushBack _x;
		};

	} forEach (allUnits + allDead);

};


// Shuffle?
_players = if (_shuffle) then { _players call BIS_fnc_arrayShuffle; } else { _players; };


_players