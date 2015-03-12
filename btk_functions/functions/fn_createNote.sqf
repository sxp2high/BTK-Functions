/*
	File: fn_createNote.sqf
	Author: sxp2high (BTK) (btk@arma3.cc)

	Description:
	Creates a diary note.

	Parameter(s):
		0: ARRAY - target units
		1: STRING - category aka diary subject (use "Diary" to use default category)
		2: STRING - note title
		3: STRING - note contents

	Returns:
	BOOLEAN - true when done

	Syntax:
	[[player], "Diary", "Hello", "Hello world!"] call BTK_fnc_createNote;
	[switchableUnits, "Extra Notes", "Note #1", format["Welcome to %1!", worldName]] call BTK_fnc_createNote;
*/


private ["_units","_section","_title","_note"];


// Parameter
_units = _this select 0;
_section = _this select 1;
_title = _this select 2;
_note = _this select 3;


// Create subject?
{
	if (_section != "Diary") then { _x createDiarySubject [_section, _section]; };
} forEach _units;


// Create note
{
	_x createDiaryRecord [_section, [_title, _note]];
} forEach _units;


true