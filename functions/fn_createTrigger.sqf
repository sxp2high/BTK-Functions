/*
	File: fn_createTrigger.sqf
	Author: sxp2high (BTK) (btk@arma3.cc)

	Description:
	Creates a trigger.

	Parameter(s):
		0: ARRAY - position
		1: SCALAR - size X
		2: SCALAR - size Y
		3: SCALAR - dir/angle
		4: BOOLEAN - rectangle or ellipse (true for rectangle, false for ellipse)
		5: STRING - activated by ("ANY", "EAST", "WEST", etc. See https://community.bistudio.com/wiki/setTriggerActivation)
		6: STRING - activation type ("PRESENT", "NOT PRESENT", etc.)
		7: BOOLEAN - repeating (true if the trigger can activate more than once)
		8: STRING - condition code (trigger will activate if this condition is met)
		9: BOOLEAN - activation code (this code is executed when trigger is activated)
		10: BOOLEAN - deactivation code (this code is executed when trigger is deactivated)

	Returns:
	OBJECT - the created trigger

	Syntax:
	_trigger [(getPosATL player), 10, 10, (getDir player), false, "ANY", "PRESENT", true, "({(_x in thisList)} count (switchableUnits + playableUnits) > 0)", "hint 'player is inside the trigger!';", "hint 'player left the trigger!';"] call BTK_fnc_createTrigger;
*/


private ["_pos","_sizeX","_sizeY","_dir","_rectangle","_activatedBy","_activatedType","_activatedRepeat","_condition","_state1","_state2","_trigger"];


// Parameter
_pos = _this select 0;
_sizeX = _this select 1;
_sizeY = _this select 2;
_dir = _this select 3;
_rectangle = _this select 4;
_activatedBy = _this select 5;
_activatedType = _this select 6;
_activatedRepeat = _this select 7;
_condition = _this select 8;
_state1 = _this select 9;
_state2 = _this select 10;


// Create the trigger
_trigger = createTrigger ["EmptyDetector", _pos];
_trigger setTriggerArea [_sizeX, _sizeY, _dir, _rectangle];
_trigger setTriggerActivation [_activatedBy, _activatedType, _activatedRepeat];
_trigger setTriggerStatements [_condition, _state1, _state2];


_trigger