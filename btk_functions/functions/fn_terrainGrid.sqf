/*
	File: fn_terrainGrid.sqf
	Author: sxp2high (BTK) (btk@arma3.cc)

	Description:
	Convert terraingrid to a comparable number.

	Parameter(s):
		0: NUMBER - value to convert
		1: NUMBER - convert which way? 0 = dialog to real

	Returns:
	NUMBER - converted value

	Syntax:
	_realTerrainGrid = [3, 0] call BTK_fnc_terrainGrid; // Returns 32
*/


private ["_value","_type","_return"];


// Parameter
_value = _this select 0;
_type = _this select 1;


// Convert
_return = if (_type == 0) then {

	switch (_value) do {

		case (0) : { 50; };
		case (1) : { 49; };
		case (2) : { 48; };
		case (3) : { 47; };
		case (4) : { 46; };
		case (5) : { 45; };
		case (6) : { 44; };
		case (7) : { 43; };
		case (8) : { 42; };
		case (9) : { 41; };
		case (10) : { 40; };
		case (11) : { 39; };
		case (12) : { 38; };
		case (13) : { 37; };
		case (14) : { 36; };
		case (15) : { 35; };
		case (16) : { 34; };
		case (17) : { 33; };
		case (18) : { 32; };
		case (19) : { 31; };
		case (20) : { 30; };
		case (21) : { 29; };
		case (22) : { 28; };
		case (23) : { 27; };
		case (24) : { 26; };
		case (25) : { 25; };
		case (26) : { 24; };
		case (27) : { 23; };
		case (28) : { 22; };
		case (29) : { 21; };
		case (30) : { 20; };
		case (31) : { 19; };
		case (32) : { 18; };
		case (33) : { 17; };
		case (34) : { 16; };
		case (35) : { 15; };
		case (36) : { 14; };
		case (37) : { 13; };
		case (38) : { 12; };
		case (39) : { 11; };
		case (40) : { 10; };
		case (41) : { 9; };
		case (42) : { 8; };
		case (43) : { 7; };
		case (44) : { 6; };
		case (45) : { 5; };
		case (46) : { 4; };
		case (47) : { 3; };
		case (48) : { 2; };
		case (49) : { 1; };
		case (50) : { 0; };
		default { 10; };

	};

} else {

	switch (_value) do {

		case (50) : { 0; };
		case (49) : { 1; };
		case (48) : { 2; };
		case (47) : { 3; };
		case (46) : { 4; };
		case (45) : { 5; };
		case (44) : { 6; };
		case (43) : { 7; };
		case (42) : { 8; };
		case (41) : { 9; };
		case (40) : { 10; };
		case (39) : { 11; };
		case (38) : { 12; };
		case (37) : { 13; };
		case (36) : { 14; };
		case (35) : { 15; };
		case (34) : { 16; };
		case (33) : { 17; };
		case (32) : { 18; };
		case (31) : { 19; };
		case (30) : { 20; };
		case (29) : { 21; };
		case (28) : { 22; };
		case (27) : { 23; };
		case (26) : { 24; };
		case (25) : { 25; };
		case (24) : { 26; };
		case (23) : { 27; };
		case (22) : { 28; };
		case (21) : { 29; };
		case (20) : { 30; };
		case (19) : { 31; };
		case (18) : { 32; };
		case (17) : { 33; };
		case (16) : { 34; };
		case (15) : { 35; };
		case (14) : { 36; };
		case (13) : { 37; };
		case (12) : { 38; };
		case (11) : { 39; };
		case (10) : { 40; };
		case (9) : { 41; };
		case (8) : { 42; };
		case (7) : { 43; };
		case (6) : { 44; };
		case (5) : { 45; };
		case (4) : { 46; };
		case (3) : { 47; };
		case (2) : { 48; };
		case (1) : { 49; };
		case (0) : { 50; };
		default { 10; };

	};

};


_return