/*
	File: fn_randomString.sqf
	Author: sxp2high (BTK) (btk@arma3.cc)

	Description:
	Returns a random string with the given length.

	Parameter(s):
		0: NUMBER - length of the string

	Returns:
	STRING - random string with characters 0-9 and a-z

	Syntax:
	_string = [10] call BTK_fnc_randomString;
*/


private ["_length","_return","_pool"];


// Parameter
_length = _this select 0;
_return = "";


// Set to choose from
_pool = ["0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"];


// Compile string
for "_j" from 1 to _length do { _return = _return + (_pool call BIS_fnc_selectRandom); };


_return