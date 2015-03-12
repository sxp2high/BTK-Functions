/*
	File: fn_rankToNumber.sqf
	Author: sxp2high (BTK) (btk@arma3.cc)

	Description:
	Convert a rank into a number for comparsion OR convert a number into a rank.

	Parameter(s):
		0: ANY - either string (rank) or number

	Returns:
	NUMBER - if input was string
	STRING - if input was number

	Syntax:
	_number = [(rank player)] call BTK_fnc_rankToNumber; // Returns 1
	_rank = [1] call BTK_fnc_rankToNumber; // Returns "PRIVATE"
*/


private ["_input","_output"];


// Parameter
_input = _this select 0;


// Convert
_output = if ((typeName _input) == "STRING") then {

	switch (_input) do {

		case ("PRIVATE") : { 1; };
		case ("CORPORAL") : { 2; };
		case ("SERGEANT") : { 3; };
		case ("LIEUTENANT") : { 4; };
		case ("CAPTAIN") : { 5; };
		case ("MAJOR") : { 6; };
		case ("COLONEL") : { 7; };

	};

} else {

	switch (_input) do {

		case (1) : { "PRIVATE"; };
		case (2) : { "CORPORAL"; };
		case (3) : { "SERGEANT"; };
		case (4) : { "LIEUTENANT"; };
		case (5) : { "CAPTAIN"; };
		case (6) : { "MAJOR"; };
		case (7) : { "COLONEL"; };

	};

};


_output